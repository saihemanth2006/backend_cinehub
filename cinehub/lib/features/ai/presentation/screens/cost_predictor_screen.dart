import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';

class CostPredictorScreen extends StatelessWidget {
  const CostPredictorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Film Cost Predictor'), leading: const BackButton()),
      body: Center(child: Text('Cost predictor coming soon', style: AppTypography.bodyLarge)),
    );
  }
}
