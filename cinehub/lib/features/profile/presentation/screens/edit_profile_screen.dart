import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Edit Profile'), leading: const BackButton()),
      body: Center(child: Text('Edit profile', style: AppTypography.bodyLarge)),
    );
  }
}
