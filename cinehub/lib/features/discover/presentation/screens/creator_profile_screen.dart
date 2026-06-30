import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';

class CreatorProfileScreen extends StatelessWidget {
  final String creatorId;
  const CreatorProfileScreen({super.key, required this.creatorId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Creator Profile')),
      body: Center(
        child: Text('Creator profile: $creatorId', style: AppTypography.bodyLarge),
      ),
    );
  }
}
