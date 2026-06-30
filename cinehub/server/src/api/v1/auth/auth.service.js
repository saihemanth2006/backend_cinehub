/**
 * @module api/v1/auth/auth.service
 * @description Authentication business logic — registration, login, token management.
 */
const { env } = require('../../../config');
const ApiError = require('../../../utils/ApiError');
const { generateAuthTokens, verifyToken, generateResetPasswordToken, generateVerifyEmailToken, TOKEN_TYPES } = require('../../../utils/token');
const userRepo = require('../../../repositories/user.repository');
const eventEmitter = require('../../../events/emitter');

class AuthService {
  async register(userData) {
    if (await userRepo.findByEmail(userData.email)) {
      throw ApiError.conflict('Email is already registered', 'AUTH_EMAIL_TAKEN');
    }

    const user = await userRepo.create({
      ...userData,
      slug: `${userData.firstName}-${userData.lastName}-${Date.now().toString(36)}`.toLowerCase(),
    });

    const tokens = generateAuthTokens(user);
    await userRepo.updateById(user._id, { refreshToken: tokens.refreshToken });

    eventEmitter.emit('user:registered', { userId: user._id, email: user.email });

    return { user: this._sanitizeUser(user), tokens };
  }

  async login(email, password) {
    const user = await userRepo.findByEmail(email);
    if (!user || !(await user.comparePassword(password))) {
      throw ApiError.unauthorized('Invalid email or password', 'AUTH_INVALID_CREDENTIALS');
    }

    if (!user.isActive) {
      throw ApiError.forbidden('Account is deactivated', 'AUTH_ACCOUNT_DEACTIVATED');
    }

    const tokens = generateAuthTokens(user);
    await userRepo.updateById(user._id, { refreshToken: tokens.refreshToken, lastLoginAt: new Date() });

    eventEmitter.emit('user:loggedIn', { userId: user._id });

    return { user: this._sanitizeUser(user), tokens };
  }

  async refreshTokens(refreshToken) {
    const decoded = verifyToken(refreshToken, env.jwt.refreshSecret);
    if (decoded.type !== TOKEN_TYPES.REFRESH) {
      throw ApiError.unauthorized('Invalid token type', 'AUTH_WRONG_TOKEN_TYPE');
    }

    const user = await userRepo.findById(decoded.sub, { lean: false });
    if (!user || user.refreshToken !== refreshToken) {
      throw ApiError.unauthorized('Invalid refresh token', 'AUTH_INVALID_REFRESH_TOKEN');
    }

    const tokens = generateAuthTokens(user);
    await userRepo.updateById(user._id, { refreshToken: tokens.refreshToken });

    return tokens;
  }

  async logout(userId) {
    await userRepo.updateById(userId, { refreshToken: null });
  }

  async forgotPassword(email) {
    const user = await userRepo.findByEmail(email);
    if (!user) return; // Silent — don't reveal if email exists

    const resetToken = generateResetPasswordToken(user._id);
    eventEmitter.emit('user:forgotPassword', { userId: user._id, email, resetToken });
  }

  async resetPassword(token, newPassword) {
    const decoded = verifyToken(token, env.jwt.accessSecret);
    if (decoded.type !== TOKEN_TYPES.RESET_PASSWORD) {
      throw ApiError.badRequest('Invalid reset token', 'AUTH_INVALID_RESET_TOKEN');
    }

    const user = await userRepo.findById(decoded.sub, { lean: false });
    if (!user) throw ApiError.notFound('User not found');

    user.password = newPassword;
    user.refreshToken = null;
    await user.save();

    eventEmitter.emit('user:passwordReset', { userId: user._id });
  }

  async changePassword(userId, currentPassword, newPassword) {
    const user = await userRepo.findById(userId, { lean: false, select: '+password' });
    if (!user) throw ApiError.notFound('User not found');

    // Re-fetch with password field
    const userWithPwd = await require('../../../models/user.model').findById(userId);
    if (!(await userWithPwd.comparePassword(currentPassword))) {
      throw ApiError.badRequest('Current password is incorrect', 'AUTH_WRONG_PASSWORD');
    }

    userWithPwd.password = newPassword;
    userWithPwd.refreshToken = null;
    await userWithPwd.save();
  }

  async verifyEmail(token) {
    const decoded = verifyToken(token, env.jwt.accessSecret);
    if (decoded.type !== TOKEN_TYPES.VERIFY_EMAIL) {
      throw ApiError.badRequest('Invalid verification token');
    }

    await userRepo.updateById(decoded.sub, { isEmailVerified: true });
    eventEmitter.emit('user:emailVerified', { userId: decoded.sub });
  }

  _sanitizeUser(user) {
    const obj = user.toJSON ? user.toJSON() : user;
    delete obj.password;
    delete obj.refreshToken;
    return obj;
  }
}

module.exports = new AuthService();
