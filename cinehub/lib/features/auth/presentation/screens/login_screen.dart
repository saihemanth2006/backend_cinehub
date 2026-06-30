import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';
import '../../../../shared/widgets/buttons/buttons.dart';
import '../../../../shared/widgets/inputs/inputs.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.xxl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.massive),
              // Logo / Brand
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  gradient: AppGradients.primary,
                  borderRadius: AppRadii.borderLg,
                ),
                child: const Icon(Icons.movie_filter, color: Colors.white, size: 28),
              ),
              const SizedBox(height: AppSpacing.xxl),
              Text('Welcome to', style: AppTypography.bodyLarge.copyWith(color: AppColors.textSecondary)),
              Text('CineHub', style: AppTypography.displayMedium),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'The AI-powered filmmaking ecosystem',
                style: AppTypography.bodyMedium.copyWith(color: AppColors.textTertiary),
              ),
              const SizedBox(height: AppSpacing.huge),
              // Form
              const AppTextField(
                label: 'Email',
                hint: 'you@example.com',
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: AppSpacing.lg),
              const AppTextField(
                label: 'Password',
                hint: '••••••••',
                prefixIcon: Icons.lock_outline,
                obscureText: true,
              ),
              const SizedBox(height: AppSpacing.sm),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot password?',
                    style: AppTypography.labelMedium.copyWith(color: AppColors.primary),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),
              PrimaryButton(
                label: 'Sign In',
                isExpanded: true,
                onPressed: () {},
              ),
              const SizedBox(height: AppSpacing.lg),
              GhostButton(
                label: 'Create Account',
                isExpanded: true,
                onPressed: () {},
              ),
              const SizedBox(height: AppSpacing.xxl),
              // Divider
              Row(
                children: [
                  const Expanded(child: Divider(color: AppColors.divider)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                    child: Text('or continue with', style: AppTypography.caption),
                  ),
                  const Expanded(child: Divider(color: AppColors.divider)),
                ],
              ),
              const SizedBox(height: AppSpacing.xxl),
              // Social
              Row(
                children: [
                  Expanded(
                    child: GhostButton(
                      label: 'Google',
                      icon: Icons.g_mobiledata,
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: GhostButton(
                      label: 'Apple',
                      icon: Icons.apple,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
