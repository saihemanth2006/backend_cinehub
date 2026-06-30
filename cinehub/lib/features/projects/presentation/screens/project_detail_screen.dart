import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';

class ProjectDetailScreen extends StatelessWidget {
  final String projectId;
  const ProjectDetailScreen({super.key, required this.projectId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Project'), leading: const BackButton()),
      body: Center(child: Text('Project: $projectId', style: AppTypography.bodyLarge)),
    );
  }
}
