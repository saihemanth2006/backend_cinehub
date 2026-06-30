import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import '../../services/auth_service.dart'; // To get the token
import '../../services/jobs_service.dart';

class PostJobPage extends StatefulWidget {
  const PostJobPage({super.key});

  @override
  State<PostJobPage> createState() => _PostJobPageState();
}

class _PostJobPageState extends State<PostJobPage> {
  // Theme constants
  static const _bg = Color(0xFF06060E);
  static const _card = Color(0xFF111120);
  static const _cardBorder = Color(0xFF1A1A2E);
  static const _accent = Color(0xFF7B5CFF);
  static const _textPrimary = Color(0xFFEEECFF);
  static const _textSec = Color(0xFF8884AA);

  final _formKey = GlobalKey<FormState>();

  final _titleCtrl = TextEditingController();
  final _companyCtrl = TextEditingController();
  final _locationCtrl = TextEditingController();
  final _payCtrl = TextEditingController();

  String _selectedType = 'On-site';
  String _selectedCategory = 'Acting';
  bool _isUrgent = false;

  bool _isSubmitting = false;
  final JobsService _jobsSvc = JobsService();

  final List<String> _types = ['On-site', 'Remote', 'Hybrid', 'Contract', 'Freelance'];
  final List<String> _categories = [
    'Acting', 'Direction', 'Cinematography', 'Editing', 'Writing', 'Production', 'VFX'
  ];

  @override
  void dispose() {
    _titleCtrl.dispose();
    _companyCtrl.dispose();
    _locationCtrl.dispose();
    _payCtrl.dispose();
    super.dispose();
  }

  Future<void> _submitJob() async {
    if (!_formKey.currentState!.validate()) return;
    
    final token = AuthService().token;
    if (token == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please log in to post a job.')),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final payload = {
        'title': _titleCtrl.text.trim(),
        'company': _companyCtrl.text.trim(),
        'location': _locationCtrl.text.trim(),
        'type': _selectedType,
        'pay': _payCtrl.text.trim(),
        'category': _selectedCategory,
        'urgent': _isUrgent,
      };

      final ok = await _jobsSvc.postJob(payload, token: token);
      if (!mounted) return;
      if (ok) {
        HapticFeedback.mediumImpact();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Job posted successfully!')),
        );
        Navigator.of(context).pop(true);
      } else {
        throw Exception('Failed to post job');
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hint,
    IconData? icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: _textPrimary, fontSize: 13, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          style: const TextStyle(color: Colors.white, fontSize: 14),
          validator: (val) {
            if (val == null || val.trim().isEmpty) return 'Required';
            return null;
          },
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: _textSec.withOpacity(0.5), fontSize: 14),
            prefixIcon: icon != null ? Icon(icon, color: _textSec, size: 20) : null,
            filled: true,
            fillColor: _card,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: _cardBorder)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: _accent, width: 1.5)),
            errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.redAccent)),
            focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.redAccent, width: 1.5)),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: Colors.white, size: 24),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Post a Job', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(label: 'Job Title', controller: _titleCtrl, hint: 'e.g., Lead Actor - Feature Film', icon: Icons.work_outline_rounded),
              const SizedBox(height: 16),
              _buildTextField(label: 'Company / Production', controller: _companyCtrl, hint: 'e.g., Red Curtain Productions', icon: Icons.business_rounded),
              const SizedBox(height: 16),
              _buildTextField(label: 'Location', controller: _locationCtrl, hint: 'e.g., Mumbai, MH or Remote', icon: Icons.location_on_outlined),
              const SizedBox(height: 16),
              _buildTextField(label: 'Pay / Compensation', controller: _payCtrl, hint: 'e.g., ₹2L–₹5L or Unpaid', icon: Icons.currency_rupee_rounded),
              const SizedBox(height: 20),

              // Dropdowns
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Job Type', style: TextStyle(color: _textPrimary, fontSize: 13, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(color: _card, borderRadius: BorderRadius.circular(12), border: Border.all(color: _cardBorder)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedType,
                              isExpanded: true,
                              dropdownColor: _card,
                              style: const TextStyle(color: Colors.white, fontSize: 14),
                              items: _types.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                              onChanged: (v) => setState(() => _selectedType = v!),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Category', style: TextStyle(color: _textPrimary, fontSize: 13, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(color: _card, borderRadius: BorderRadius.circular(12), border: Border.all(color: _cardBorder)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedCategory,
                              isExpanded: true,
                              dropdownColor: _card,
                              style: const TextStyle(color: Colors.white, fontSize: 14),
                              items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                              onChanged: (v) => setState(() => _selectedCategory = v!),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Urgent Switch
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(color: _card, borderRadius: BorderRadius.circular(12), border: Border.all(color: _cardBorder)),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: const Color(0xFFFF3D6B).withOpacity(0.15), borderRadius: BorderRadius.circular(8)),
                      child: const Icon(Icons.bolt_rounded, color: Color(0xFFFF3D6B), size: 18),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text('Mark as Urgent', style: TextStyle(color: _textPrimary, fontSize: 14, fontWeight: FontWeight.w600)),
                    ),
                    Switch(
                      value: _isUrgent,
                      activeColor: const Color(0xFFFF3D6B),
                      onChanged: (v) => setState(() => _isUrgent = v),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Submit
              GestureDetector(
                onTap: _isSubmitting ? null : _submitJob,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: double.infinity,
                  height: 54,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: _isSubmitting ? [_accent.withOpacity(0.5), const Color(0xFF9B4FE0).withOpacity(0.5)] : [_accent, const Color(0xFF9B4FE0)],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      if (!_isSubmitting) BoxShadow(color: _accent.withOpacity(0.4), blurRadius: 16, offset: const Offset(0, 6)),
                    ],
                  ),
                  child: Center(
                    child: _isSubmitting
                        ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
                        : const Text('Post Job', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800)),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
