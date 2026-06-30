import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';

class TrailerConceptScreen extends StatelessWidget {
  const TrailerConceptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Trailer Concept'), leading: const BackButton()),
      body: Center(child: Text('Trailer concept generator coming soon', style: AppTypography.bodyLarge)),
    );
  }
}
