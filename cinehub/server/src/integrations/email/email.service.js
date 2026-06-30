/**
 * @module integrations/email/email.service
 * @description Email service using Nodemailer + Handlebars templates.
 */
const nodemailer = require('nodemailer');
const Handlebars = require('handlebars');
const { env, logger } = require('../../config');

class EmailService {
  constructor() {
    this.transporter = nodemailer.createTransport({
      host: env.email.smtp.host,
      port: env.email.smtp.port,
      secure: env.email.smtp.secure,
      auth: env.email.smtp.auth,
    });
  }

  async sendEmail({ to, subject, html, text }) {
    try {
      const info = await this.transporter.sendMail({
        from: env.email.from,
        to,
        subject,
        html,
        text,
      });
      logger.info(`[Email] Sent to ${to}: ${info.messageId}`);
      return info;
    } catch (err) {
      logger.error(`[Email] Failed to send to ${to}: ${err.message}`);
      throw err;
    }
  }

  async sendWelcomeEmail(user) {
    const template = Handlebars.compile(`
      <h1>Welcome to {{appName}}, {{name}}! 🎬</h1>
      <p>You've joined the premier AI-powered filmmaking platform.</p>
      <p>Start by completing your profile and exploring projects.</p>
      <a href="{{url}}/verify?token={{token}}" style="background:#7C3AED;color:white;padding:12px 24px;border-radius:8px;text-decoration:none;">Verify Email</a>
    `);

    return this.sendEmail({
      to: user.email,
      subject: `Welcome to ${env.appName}!`,
      html: template({ appName: env.appName, name: user.firstName, url: env.clientUrl, token: user.verifyToken || '' }),
    });
  }

  async sendPasswordResetEmail(email, resetToken) {
    const template = Handlebars.compile(`
      <h1>Password Reset</h1>
      <p>Click the button below to reset your password. This link expires in 10 minutes.</p>
      <a href="{{url}}/reset-password?token={{token}}" style="background:#7C3AED;color:white;padding:12px 24px;border-radius:8px;text-decoration:none;">Reset Password</a>
      <p>If you didn't request this, ignore this email.</p>
    `);

    return this.sendEmail({
      to: email,
      subject: 'Reset your password',
      html: template({ url: env.clientUrl, token: resetToken }),
    });
  }

  async sendTeamInviteEmail(email, inviterName, projectName) {
    const template = Handlebars.compile(`
      <h1>You're Invited! 🎬</h1>
      <p><strong>{{inviter}}</strong> invited you to join the project <strong>{{project}}</strong> on {{appName}}.</p>
      <a href="{{url}}/teams" style="background:#7C3AED;color:white;padding:12px 24px;border-radius:8px;text-decoration:none;">View Invitation</a>
    `);

    return this.sendEmail({
      to: email,
      subject: `Team invitation: ${projectName}`,
      html: template({ inviter: inviterName, project: projectName, appName: env.appName, url: env.clientUrl }),
    });
  }
}

module.exports = new EmailService();
