import 'package:flutter/material.dart';
import '../models/cost_prediction_models.dart';
import '../film_cost_predictor_service.dart';

class FilmCostPredictorScreen extends StatefulWidget {
  final String apiKey;

  const FilmCostPredictorScreen({
    required this.apiKey,
    super.key,
  });

  @override
  State<FilmCostPredictorScreen> createState() =>
      _FilmCostPredictorScreenState();
}

class _FilmCostPredictorScreenState extends State<FilmCostPredictorScreen> {
  late FilmCostPredictorService _service;
  
  EquipmentLevel _selectedEquipmentLevel = EquipmentLevel.professional;
         
  final TextEditingController _scriptController = TextEditingController();
  final TextEditingController _actorsController = TextEditingController();
  final TextEditingController _locationsController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  
  CostPredictionResponse? _prediction;
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _service = FilmCostPredictorService(apiKey: widget.apiKey);
  }

  @override
  void dispose() {
    _scriptController.dispose();
    _actorsController.dispose();
    _locationsController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  Future<void> _predictCost() async {
    if (_scriptController.text.isEmpty || 
        _actorsController.text.isEmpty ||
        _locationsController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final actors = int.parse(_actorsController.text);
      final locations = int.parse(_locationsController.text);

      final request = CostPredictionRequest(
        scriptDescription: _scriptController.text,
        numberOfActors: actors,
        numberOfLocations: locations,
        equipmentLevel: _selectedEquipmentLevel,
        additionalDetails: _detailsController.text.isNotEmpty
            ? _detailsController.text
            : null,
      );

      final response = await _service.predictCost(request);

      setState(() {
        _prediction = response;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cost prediction completed!')),
      );
    } catch (e) {
      setState(() {
        _error = e.toString();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('💰 Film Cost Predictor'),
        elevation: 0,
      ),
      body: _isLoading
          ? _buildLoadingView()
          : (_prediction != null
              ? _buildResultView()
              : _buildFormView()),
    );
  }

  Widget _buildFormView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Production Details'),
          const SizedBox(height: 16),
          _buildScriptInput(),
          const SizedBox(height: 12),
          _buildActorsInput(),
          const SizedBox(height: 12),
          _buildLocationsInput(),
          const SizedBox(height: 12),
          _buildEquipmentDropdown(),
          const SizedBox(height: 12),
          _buildDetailsInput(),
          const SizedBox(height: 24),
          _buildPredictButton(),
        ],
      ),
    );
  }

  Widget _buildScriptInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Script Description *',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _scriptController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'e.g., Action thriller with 3 main scenes',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActorsInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Number of Actors *',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _actorsController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'e.g., 5',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLocationsInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Number of Locations *',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _locationsController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'e.g., 3',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEquipmentDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Equipment Level',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        DropdownButton<EquipmentLevel>(
          isExpanded: true,
          value: _selectedEquipmentLevel,
          items: EquipmentLevel.values.map((level) {
            return DropdownMenuItem(
              value: level,
              child: Text(level.label),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() => _selectedEquipmentLevel = value);
            }
          },
        ),
      ],
    );
  }

  Widget _buildDetailsInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Additional Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _detailsController,
          maxLines: 2,
          decoration: InputDecoration(
            hintText: 'e.g., International crew, special effects required',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPredictButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _isLoading ? null : _predictCost,
        icon: const Icon(Icons.calculate),
        label: const Text('Predict Budget'),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 20),
          Text(
            'Calculating production costs...',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  Widget _buildResultView() {
    if (_prediction == null) return const SizedBox();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Budget Estimate',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _prediction = null;
                  });
                },
                icon: const Icon(Icons.add),
                label: const Text('New Estimate'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildTotalBudgetCard(),
          const SizedBox(height: 16),
          _buildCostBreakdownSection(),
          const SizedBox(height: 16),
          _buildRationaleCard(),
        ],
      ),
    );
  }

  Widget _buildTotalBudgetCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Total Estimated Budget',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '\$${_prediction!.totalEstimatedBudget.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCostBreakdownSection() {
    final breakdown = _prediction!.breakdown;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Cost Breakdown'),
        const SizedBox(height: 12),
        _buildBreakdownItem('Actors', breakdown.actors),
        _buildBreakdownItem('Equipment', breakdown.equipment),
        _buildBreakdownItem('Editing', breakdown.editing),
        _buildBreakdownItem('Marketing', breakdown.marketing),
        _buildBreakdownItem('Other', breakdown.other),
        const Divider(thickness: 2),
        _buildBreakdownItem(
          'Total',
          breakdown.total,
          isBold: true,
        ),
      ],
    );
  }

  Widget _buildBreakdownItem(
    String label,
    double amount, {
    bool isBold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: isBold ? 16 : 14,
            ),
          ),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: isBold ? 16 : 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRationaleCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Rationale'),
            const SizedBox(height: 12),
            Text(
              _prediction!.rationale,
              style: const TextStyle(height: 1.6),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
