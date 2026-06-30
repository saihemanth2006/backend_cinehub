import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';

class JobDetailScreen extends StatelessWidget {
  final String jobId;
  const JobDetailScreen({super.key, required this.jobId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Job Details'), leading: const BackButton()),
      body: Center(child: Text('Job: $jobId', style: AppTypography.bodyLarge)),
    );
  }
}
