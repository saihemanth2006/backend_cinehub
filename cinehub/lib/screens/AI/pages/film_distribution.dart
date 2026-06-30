import 'package:flutter/material.dart';

class FilmDistributionPage extends StatefulWidget {
  const FilmDistributionPage({super.key});

  @override
  State<FilmDistributionPage> createState() => _FilmDistributionPageState();
}

class _FilmDistributionPageState extends State<FilmDistributionPage> {
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
          'Film Distribution',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: const Center(
        child: Text('Film Distribution Page'),
      ),
    );
  }
}
