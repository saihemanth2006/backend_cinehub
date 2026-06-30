import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/theme.dart';

/// Comprehensive Android settings screen for CineHub.
///
/// Includes account, appearance, notifications, storage, privacy,
/// about, and developer options (in dev mode).
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // ── Setting states ───────────────────────────────────────────
  bool _darkMode = true;
  bool _amoledBlack = true;
  bool _pushNotifications = true;
  bool _emailNotifications = false;
  bool _jobAlerts = true;
  bool _aiSuggestions = true;
  bool _autoplay = true;
  bool _downloadOnWifi = true;
  bool _analytics = false;
  bool _crashReports = true;
  bool _biometric = false;
  double _cacheSize = 256; // MB

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── App Bar ───────────────────────────────────────────
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.background,
            surfaceTintColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(Iconsax.arrow_left, size: AppSizes.iconMd),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text('Settings', style: AppTypography.h2),
            actions: [
              IconButton(
                icon: const Icon(Iconsax.search_normal, size: AppSizes.iconMd),
                onPressed: () {
                  HapticFeedback.lightImpact();
                  // TODO: Search settings
                },
              ),
              const SizedBox(width: 4),
            ],
          ),

          // ── Account Section ───────────────────────────────────
          _buildSectionHeader('Account'),
          SliverToBoxAdapter(
            child: _SettingsTile(
              icon: Iconsax.user,
              iconColor: AppColors.primary,
              title: 'Profile',
              subtitle: 'Edit your public profile information',
              onTap: () {},
            ).animate().fadeIn(duration: 300.ms).slideX(begin: -0.02),
          ),
          SliverToBoxAdapter(
            child: _SettingsTile(
              icon: Iconsax.shield_tick,
              iconColor: AppColors.success,
              title: 'Account Security',
              subtitle: 'Password, 2FA, and login sessions',
              onTap: () {},
            ).animate().fadeIn(delay: 50.ms, duration: 300.ms).slideX(begin: -0.02),
          ),
          SliverToBoxAdapter(
            child: _SettingsSwitch(
              icon: Iconsax.finger_scan,
              iconColor: AppColors.info,
              title: 'Biometric Lock',
              subtitle: 'Use fingerprint or face unlock',
              value: _biometric,
              onChanged: (v) => setState(() => _biometric = v),
            ).animate().fadeIn(delay: 100.ms, duration: 300.ms).slideX(begin: -0.02),
          ),
          SliverToBoxAdapter(
            child: _SettingsTile(
              icon: Iconsax.link,
              iconColor: AppColors.accent,
              title: 'Connected Accounts',
              subtitle: 'Google, GitHub, IMDb linked profiles',
              onTap: () {},
            ).animate().fadeIn(delay: 150.ms, duration: 300.ms).slideX(begin: -0.02),
          ),
          _buildDivider(),

          // ── Appearance Section ────────────────────────────────
          _buildSectionHeader('Appearance'),
          SliverToBoxAdapter(
            child: _SettingsSwitch(
              icon: Iconsax.moon,
              iconColor: AppColors.primaryLight,
              title: 'Dark Mode',
              subtitle: 'Cinematic dark theme',
              value: _darkMode,
              onChanged: (v) => setState(() => _darkMode = v),
            ).animate().fadeIn(delay: 200.ms, duration: 300.ms).slideX(begin: -0.02),
          ),
          SliverToBoxAdapter(
            child: _SettingsSwitch(
              icon: Iconsax.paintbucket,
              iconColor: AppColors.textPrimary,
              title: 'AMOLED Black',
              subtitle: 'Pure black for OLED screens, saves battery',
              value: _amoledBlack,
              onChanged: (v) => setState(() => _amoledBlack = v),
            ).animate().fadeIn(delay: 250.ms, duration: 300.ms).slideX(begin: -0.02),
          ),
          SliverToBoxAdapter(
            child: _SettingsTile(
              icon: Iconsax.text,
              iconColor: AppColors.warning,
              title: 'Text Size',
              subtitle: 'Adjust font scaling',
              trailing: Text(
                'Default',
                style: AppTypography.labelMedium.copyWith(color: AppColors.primary),
              ),
              onTap: () => _showTextSizeSheet(context),
            ).animate().fadeIn(delay: 300.ms, duration: 300.ms).slideX(begin: -0.02),
          ),
          SliverToBoxAdapter(
            child: _SettingsTile(
              icon: Iconsax.language_square,
              iconColor: AppColors.info,
              title: 'Language',
              subtitle: 'English (US)',
              onTap: () {},
            ).animate().fadeIn(delay: 350.ms, duration: 300.ms).slideX(begin: -0.02),
          ),
          _buildDivider(),

          // ── Notifications Section ─────────────────────────────
          _buildSectionHeader('Notifications'),
          SliverToBoxAdapter(
            child: _SettingsSwitch(
              icon: Iconsax.notification,
              iconColor: AppColors.error,
              title: 'Push Notifications',
              subtitle: 'Receive real-time alerts on your device',
              value: _pushNotifications,
              onChanged: (v) => setState(() => _pushNotifications = v),
            ),
          ),
          SliverToBoxAdapter(
            child: _SettingsSwitch(
              icon: Iconsax.sms,
              iconColor: AppColors.accent,
              title: 'Email Notifications',
              subtitle: 'Weekly digest and important updates',
              value: _emailNotifications,
              onChanged: (v) => setState(() => _emailNotifications = v),
            ),
          ),
          SliverToBoxAdapter(
            child: _SettingsSwitch(
              icon: Iconsax.briefcase,
              iconColor: AppColors.success,
              title: 'Job Alerts',
              subtitle: 'New opportunities matching your skills',
              value: _jobAlerts,
              onChanged: (v) => setState(() => _jobAlerts = v),
            ),
          ),
          SliverToBoxAdapter(
            child: _SettingsSwitch(
              icon: Iconsax.cpu,
              iconColor: AppColors.primary,
              title: 'AI Suggestions',
              subtitle: 'Personalized recommendations from CineHub AI',
              value: _aiSuggestions,
              onChanged: (v) => setState(() => _aiSuggestions = v),
            ),
          ),
          _buildDivider(),

          // ── Data & Storage Section ────────────────────────────
          _buildSectionHeader('Data & Storage'),
          SliverToBoxAdapter(
            child: _SettingsSwitch(
              icon: Iconsax.video_play,
              iconColor: AppColors.secondary,
              title: 'Autoplay Videos',
              subtitle: 'Autoplay portfolio previews in feed',
              value: _autoplay,
              onChanged: (v) => setState(() => _autoplay = v),
            ),
          ),
          SliverToBoxAdapter(
            child: _SettingsSwitch(
              icon: Iconsax.wifi,
              iconColor: AppColors.info,
              title: 'Download on Wi-Fi Only',
              subtitle: 'Save mobile data',
              value: _downloadOnWifi,
              onChanged: (v) => setState(() => _downloadOnWifi = v),
            ),
          ),
          SliverToBoxAdapter(
            child: _CacheSlider(
              value: _cacheSize,
              onChanged: (v) => setState(() => _cacheSize = v),
            ),
          ),
          SliverToBoxAdapter(
            child: _SettingsTile(
              icon: Iconsax.trash,
              iconColor: AppColors.error,
              title: 'Clear Cache',
              subtitle: '${_cacheSize.round()} MB allocated • Tap to clear',
              onTap: () => _showClearCacheDialog(context),
            ),
          ),
          _buildDivider(),

          // ── Privacy Section ───────────────────────────────────
          _buildSectionHeader('Privacy'),
          SliverToBoxAdapter(
            child: _SettingsSwitch(
              icon: Iconsax.chart,
              iconColor: AppColors.warning,
              title: 'Usage Analytics',
              subtitle: 'Help improve CineHub with anonymous data',
              value: _analytics,
              onChanged: (v) => setState(() => _analytics = v),
            ),
          ),
          SliverToBoxAdapter(
            child: _SettingsSwitch(
              icon: Iconsax.danger,
              iconColor: AppColors.error,
              title: 'Crash Reports',
              subtitle: 'Automatically send crash diagnostics',
              value: _crashReports,
              onChanged: (v) => setState(() => _crashReports = v),
            ),
          ),
          SliverToBoxAdapter(
            child: _SettingsTile(
              icon: Iconsax.document,
              iconColor: AppColors.textSecondary,
              title: 'Privacy Policy',
              subtitle: 'Read our data handling practices',
              onTap: () {},
            ),
          ),
          SliverToBoxAdapter(
            child: _SettingsTile(
              icon: Iconsax.document_text,
              iconColor: AppColors.textSecondary,
              title: 'Terms of Service',
              subtitle: 'Review terms and conditions',
              onTap: () {},
            ),
          ),
          _buildDivider(),

          // ── About Section ─────────────────────────────────────
          _buildSectionHeader('About'),
          SliverToBoxAdapter(
            child: _SettingsTile(
              icon: Iconsax.info_circle,
              iconColor: AppColors.primary,
              title: 'App Version',
              subtitle: 'CineHub v2.0.0 (Build 1)',
              trailing: _VersionBadge(),
              onTap: () {},
            ),
          ),
          SliverToBoxAdapter(
            child: _SettingsTile(
              icon: Iconsax.star,
              iconColor: AppColors.accent,
              title: 'Rate CineHub',
              subtitle: 'Love CineHub? Leave a review on Play Store',
              onTap: () {},
            ),
          ),
          SliverToBoxAdapter(
            child: _SettingsTile(
              icon: Iconsax.share,
              iconColor: AppColors.success,
              title: 'Share CineHub',
              subtitle: 'Invite fellow filmmakers to join',
              onTap: () {},
            ),
          ),
          SliverToBoxAdapter(
            child: _SettingsTile(
              icon: Iconsax.message_question,
              iconColor: AppColors.info,
              title: 'Help & Support',
              subtitle: 'FAQ, contact us, bug reports',
              onTap: () {},
            ),
          ),
          SliverToBoxAdapter(
            child: _SettingsTile(
              icon: Iconsax.code,
              iconColor: AppColors.textTertiary,
              title: 'Open Source Licenses',
              subtitle: 'Third-party software used in CineHub',
              onTap: () => showLicensePage(
                context: context,
                applicationName: 'CineHub',
                applicationVersion: '2.0.0',
              ),
            ),
          ),
          _buildDivider(),

          // ── Danger Zone ───────────────────────────────────────
          _buildSectionHeader('Danger Zone'),
          SliverToBoxAdapter(
            child: _SettingsTile(
              icon: Iconsax.logout,
              iconColor: AppColors.warning,
              title: 'Sign Out',
              subtitle: 'Log out of your CineHub account',
              titleColor: AppColors.warning,
              onTap: () => _showSignOutDialog(context),
            ),
          ),
          SliverToBoxAdapter(
            child: _SettingsTile(
              icon: Iconsax.trash,
              iconColor: AppColors.error,
              title: 'Delete Account',
              subtitle: 'Permanently remove your data',
              titleColor: AppColors.error,
              onTap: () => _showDeleteAccountDialog(context),
            ),
          ),

          // ── Bottom safe area ──────────────────────────────────
          SliverToBoxAdapter(
            child: SizedBox(height: AppSizes.safeBottom(context) + 32),
          ),
        ],
      ),
    );
  }

  // ── Section header builder ──────────────────────────────────
  SliverToBoxAdapter _buildSectionHeader(String title) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
        child: Text(
          title.toUpperCase(),
          style: AppTypography.overline.copyWith(
            color: AppColors.primary,
            letterSpacing: 1.8,
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildDivider() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Divider(color: AppColors.divider, height: 1),
      ),
    );
  }

  // ── Dialogs ─────────────────────────────────────────────────
  void _showTextSizeSheet(BuildContext context) {
    double fontSize = 1.0;
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surfaceElevated,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) => Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: AppSizes.bottomSheetHandleWidth,
                  height: AppSizes.bottomSheetHandle,
                  decoration: BoxDecoration(
                    color: AppColors.textTertiary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text('Text Size', style: AppTypography.h2),
              const SizedBox(height: 8),
              Text(
                'Adjust the text scaling for the entire app',
                style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Text('A', style: AppTypography.bodySmall.copyWith(fontSize: 12)),
                  Expanded(
                    child: SliderTheme(
                      data: SliderThemeData(
                        activeTrackColor: AppColors.primary,
                        inactiveTrackColor: AppColors.surfaceOverlay,
                        thumbColor: AppColors.primary,
                        overlayColor: AppColors.primaryGlow,
                        trackHeight: 4,
                      ),
                      child: Slider(
                        value: fontSize,
                        min: 0.8,
                        max: 1.4,
                        divisions: 6,
                        onChanged: (v) => setModalState(() => fontSize = v),
                      ),
                    ),
                  ),
                  Text('A', style: AppTypography.bodySmall.copyWith(fontSize: 22)),
                ],
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  '${(fontSize * 100).round()}%',
                  style: AppTypography.h3.copyWith(color: AppColors.primary),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Preview text at ${(fontSize * 100).round()}% size',
                style: AppTypography.bodyMedium.copyWith(
                  fontSize: 14 * fontSize,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: AppSizes.buttonHeight,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('Apply'),
                ),
              ),
              SizedBox(height: MediaQuery.paddingOf(ctx).bottom),
            ],
          ),
        ),
      ),
    );
  }

  void _showClearCacheDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceElevated,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadii.xl)),
        title: Text('Clear Cache', style: AppTypography.h2),
        content: Text(
          'This will free up ${_cacheSize.round()} MB of storage. Downloaded content and offline data will be removed.',
          style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel', style: TextStyle(color: AppColors.textSecondary)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Cache cleared successfully'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            child: Text('Clear', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceElevated,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadii.xl)),
        title: Text('Sign Out', style: AppTypography.h2),
        content: Text(
          'Are you sure you want to sign out of CineHub?',
          style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel', style: TextStyle(color: AppColors.textSecondary)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Sign Out', style: TextStyle(color: AppColors.warning)),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceElevated,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadii.xl)),
        title: Row(
          children: [
            Icon(Iconsax.warning_2, color: AppColors.error, size: AppSizes.iconMd),
            const SizedBox(width: 8),
            Text('Delete Account', style: AppTypography.h2.copyWith(color: AppColors.error)),
          ],
        ),
        content: Text(
          'This action is permanent and cannot be undone. All your projects, portfolio items, and profile data will be permanently deleted.',
          style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel', style: TextStyle(color: AppColors.textSecondary)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Delete Forever', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// LOCAL WIDGETS
// ═══════════════════════════════════════════════════════════════

/// Standard settings tile with icon, title, subtitle, and optional trailing.
class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final Color? titleColor;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.titleColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          HapticFeedback.selectionClick();
          onTap?.call();
        },
        splashColor: AppColors.primaryGlow,
        highlightColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppRadii.md),
                ),
                child: Icon(icon, color: iconColor, size: AppSizes.iconSm),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTypography.labelLarge.copyWith(
                        color: titleColor ?? AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: AppTypography.caption.copyWith(color: AppColors.textTertiary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (trailing != null) trailing!,
              if (trailing == null)
                const Icon(Iconsax.arrow_right_3, size: 16, color: AppColors.textTertiary),
            ],
          ),
        ),
      ),
    );
  }
}

/// Settings tile with a switch.
class _SettingsSwitch extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SettingsSwitch({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppRadii.md),
            ),
            child: Icon(icon, color: iconColor, size: AppSizes.iconSm),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTypography.labelLarge),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: AppTypography.caption.copyWith(color: AppColors.textTertiary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: (v) {
              HapticFeedback.lightImpact();
              onChanged(v);
            },
            activeColor: AppColors.primary,
            activeTrackColor: AppColors.primaryMuted,
            inactiveThumbColor: AppColors.textTertiary,
            inactiveTrackColor: AppColors.surfaceOverlay,
          ),
        ],
      ),
    );
  }
}

/// Cache size slider widget.
class _CacheSlider extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;

  const _CacheSlider({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppRadii.md),
            ),
            child: Icon(Iconsax.folder, color: AppColors.accent, size: AppSizes.iconSm),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Max Cache Size', style: AppTypography.labelLarge),
                    Text(
                      '${value.round()} MB',
                      style: AppTypography.labelMedium.copyWith(color: AppColors.accent),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                SliderTheme(
                  data: SliderThemeData(
                    activeTrackColor: AppColors.accent,
                    inactiveTrackColor: AppColors.surfaceOverlay,
                    thumbColor: AppColors.accent,
                    overlayColor: AppColors.accentMuted,
                    trackHeight: 4,
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
                  ),
                  child: Slider(
                    value: value,
                    min: 64,
                    max: 1024,
                    divisions: 15,
                    onChanged: onChanged,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Small version badge chip.
class _VersionBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.success.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadii.full),
        border: Border.all(color: AppColors.success.withValues(alpha: 0.25)),
      ),
      child: Text(
        'Latest',
        style: AppTypography.labelSmall.copyWith(
          color: AppColors.success,
          fontSize: 10,
        ),
      ),
    );
  }
}
