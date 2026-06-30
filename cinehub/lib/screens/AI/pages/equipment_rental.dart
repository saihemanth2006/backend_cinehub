import 'package:flutter/material.dart';

class EquipmentRentalPage extends StatefulWidget {
  const EquipmentRentalPage({super.key});

  @override
  State<EquipmentRentalPage> createState() => _EquipmentRentalPageState();
}

class _EquipmentRentalPageState extends State<EquipmentRentalPage> {
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
          'Equipment Rental',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: const Center(
        child: Text('Equipment Rental Page'),
      ),
    );
  }
}
