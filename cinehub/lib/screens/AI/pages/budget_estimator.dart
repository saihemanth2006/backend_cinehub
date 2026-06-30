import 'package:flutter/material.dart';

class BudgetEstimatorPage extends StatefulWidget {
  const BudgetEstimatorPage({super.key});

  @override
  State<BudgetEstimatorPage> createState() => _BudgetEstimatorPageState();
}

class _BudgetEstimatorPageState extends State<BudgetEstimatorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF09090B),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Budget Estimator',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: const Center(
        child: Text('Budget Estimator Page'),
      ),
    );
  }
}
