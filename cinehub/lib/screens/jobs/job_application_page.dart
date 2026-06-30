import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JobApplicationPage extends StatefulWidget {
  final Map<String, dynamic> job;

  const JobApplicationPage({super.key, required this.job});

  @override
  State<JobApplicationPage> createState() => _JobApplicationPageState();
}

class _JobApplicationPageState extends State<JobApplicationPage> {
  // Theme colors matching JobsPage
  static const _bg = Color(0xFF06060E);
  static const _card = Color(0xFF111120);
  static const _cardBorder = Color(0xFF1A1A2E);
  static const _accent = Color(0xFF7B5CFF);
  static const _accentSoft = Color(0xFF9B7FFF);
  static const _textPrimary = Color(0xFFEEECFF);
  static const _textSec = Color(0xFF8884AA);
  
  final _formKey = GlobalKey<FormState>();
  
  // Form controllers
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _portfolioCtrl = TextEditingController();
  final _experienceCtrl = TextEditingController();
  
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _portfolioCtrl.dispose();
    _experienceCtrl.dispose();
    super.dispose();
  }

  void _submitApplication() async {
    if (_formKey.currentState!.validate()) {
      HapticFeedback.mediumImpact();
      setState(() => _isSubmitting = true);
      
      // Simulate network request
      await Future.delayed(const Duration(seconds: 2));
      
      if (!mounted) return;
      setState(() => _isSubmitting = false);
      
      // Show success dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          backgroundColor: _card,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: _cardBorder),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _accent.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_circle_rounded, color: _accent, size: 48),
              ),
              const SizedBox(height: 20),
              const Text(
                'Application Sent!',
                style: TextStyle(
                  color: _textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Your application for ${widget.job['title']} has been successfully submitted to ${widget.job['company']}.',
                textAlign: TextAlign.center,
                style: const TextStyle(color: _textSec, fontSize: 13, height: 1.5),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close dialog
                    Navigator.of(context).pop(); // Go back to jobs
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _accent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Back to Jobs', style: TextStyle(fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hint,
    IconData? icon,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: _textPrimary, fontSize: 13, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          style: const TextStyle(color: Colors.white, fontSize: 14),
          validator: validator ?? (val) {
            if (val == null || val.trim().isEmpty) return 'This field is required';
            return null;
          },
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: _textSec.withOpacity(0.5), fontSize: 14),
            prefixIcon: icon != null ? Icon(icon, color: _textSec, size: 20) : null,
            filled: true,
            fillColor: _bg,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: maxLines > 1 ? 16 : 0),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: _cardBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: _accent, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.redAccent),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final c1 = widget.job['color1'] as Color;
    final c2 = widget.job['color2'] as Color;

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Apply Now', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // Job Header
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: _card,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: c1.withOpacity(0.3)),
                gradient: LinearGradient(
                  colors: [c1.withOpacity(0.1), c2.withOpacity(0.02)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [c1, c2]),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(color: c1.withOpacity(0.4), blurRadius: 12, offset: const Offset(0, 4)),
                      ],
                    ),
                    child: Icon(widget.job['icon'] as IconData, color: Colors.white, size: 28),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.job['title'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.job['company'],
                    style: TextStyle(color: c1, fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),

            // Form
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Personal Information', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 16),
                    _buildTextField(
                      label: 'Full Name',
                      controller: _nameCtrl,
                      hint: 'John Doe',
                      icon: Icons.person_outline_rounded,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      label: 'Email Address',
                      controller: _emailCtrl,
                      hint: 'john@example.com',
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) {
                        if (val == null || val.isEmpty) return 'Email is required';
                        if (!val.contains('@')) return 'Enter a valid email';
                        return null;
                      }
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      label: 'Phone Number',
                      controller: _phoneCtrl,
                      hint: '+91 98765 43210',
                      icon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                    ),
                    
                    const SizedBox(height: 32),
                    const Text('Professional Details', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 16),
                    _buildTextField(
                      label: 'Portfolio / Showreel Link',
                      controller: _portfolioCtrl,
                      hint: 'https://vimeo.com/...',
                      icon: Icons.link_rounded,
                      keyboardType: TextInputType.url,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      label: 'Previous Experience / Cover Letter',
                      controller: _experienceCtrl,
                      hint: 'Tell us about your relevant work in short films...',
                      maxLines: 4,
                    ),
                    
                    const SizedBox(height: 24),
                    // Upload Resume Button
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.selectionClick();
                        // Dummy upload action
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Resume attached successfully!'),
                            backgroundColor: _card,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: _card,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: _cardBorder),
                        ),
                        child: const Column(
                          children: [
                            Icon(Icons.upload_file_rounded, color: _accentSoft, size: 28),
                            SizedBox(height: 8),
                            Text('Upload Resume / CV', style: TextStyle(color: _textPrimary, fontSize: 14, fontWeight: FontWeight.w600)),
                            SizedBox(height: 4),
                            Text('PDF, DOCX up to 5MB', style: TextStyle(color: _textSec, fontSize: 11)),
                          ],
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 40),
                    
                    // Submit Button
                    GestureDetector(
                      onTap: _isSubmitting ? null : _submitApplication,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: double.infinity,
                        height: 54,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: _isSubmitting 
                                ? [_accent.withOpacity(0.5), const Color(0xFF9B4FE0).withOpacity(0.5)]
                                : [_accent, const Color(0xFF9B4FE0)],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            if (!_isSubmitting)
                              BoxShadow(color: _accent.withOpacity(0.4), blurRadius: 16, offset: const Offset(0, 6)),
                          ],
                        ),
                        child: Center(
                          child: _isSubmitting
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                                )
                              : const Text('Submit Application', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
