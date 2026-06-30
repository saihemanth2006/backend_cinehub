import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/theme.dart';
import '../../../../shared/widgets/buttons/buttons.dart';
import '../../../../shared/widgets/inputs/inputs.dart';
import '../../../../shared/widgets/cards/cards.dart';
import '../../../../shared/widgets/ai/ai_widgets.dart';
import '../providers/ai_providers.dart';
import '../../data/datasources/ai_generate_service.dart';

class ScriptGeneratorScreen extends ConsumerStatefulWidget {
  const ScriptGeneratorScreen({super.key});

  @override
  ConsumerState<ScriptGeneratorScreen> createState() => _ScriptGeneratorScreenState();
}

class _ScriptGeneratorScreenState extends ConsumerState<ScriptGeneratorScreen> {
  final _promptController = TextEditingController();
  String _selectedGenre = 'Drama';
  final _genres = ['Drama', 'Sci-Fi', 'Horror', 'Comedy', 'Thriller', 'Romance', 'Action', 'Documentary'];

  @override
  void dispose() {
    _promptController.dispose();
    super.dispose();
  }

  Future<void> _generate() async {
    final prompt = _promptController.text.trim();
    if (prompt.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a story prompt.')),
      );
      return;
    }

    await ref.read(aiGenerationProvider.notifier).generate(
      module: AiModules.scriptDevelopment,
      task: AiModules.generateScreenplay,
      input: prompt,
      options: {'genre': _selectedGenre.toLowerCase()},
    );

    final state = ref.read(aiGenerationProvider);
    if (state.hasError && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.error ?? 'Generation failed.'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final aiState = ref.watch(aiGenerationProvider);
    final isLoading = aiState.isLoading;
    final result = aiState.response;

    // Extract script content from the response data map
    final scriptContent = result?.getValue<String>('content') ??
        result?.getValue<String>('screenplay') ??
        result?.data.values.whereType<String>().firstOrNull;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('AI Script Generator'),
        leading: const BackButton(),
        actions: [
          if (result != null)
            IconButton(
              icon: const Icon(Iconsax.refresh, size: 20),
              tooltip: 'Regenerate',
              onPressed: isLoading ? null : _generate,
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Info banner ────────────────────────────────
            GradientCard(
              gradient: const LinearGradient(
                colors: [Color(0xFF2D1B69), Color(0xFF1A1A26)],
              ),
              child: Row(
                children: [
                  const Icon(Iconsax.edit, color: AppColors.primary, size: 24),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(
                      'Describe your story idea and let AI generate a complete script.',
                      style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),

            // ── Genre selector ─────────────────────────────
            Text('Genre', style: AppTypography.labelLarge),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: _genres.map((g) => ChoiceChip(
                label: Text(g),
                selected: _selectedGenre == g,
                onSelected: isLoading ? null : (v) => setState(() => _selectedGenre = g),
                selectedColor: AppColors.primaryMuted,
                backgroundColor: AppColors.surfaceElevated,
                labelStyle: AppTypography.labelMedium.copyWith(
                  color: _selectedGenre == g ? AppColors.primary : AppColors.textSecondary,
                ),
                side: BorderSide(
                  color: _selectedGenre == g ? AppColors.primary : AppColors.border,
                  width: 0.5,
                ),
              )).toList(),
            ),
            const SizedBox(height: AppSpacing.xxl),

            // ── Prompt input ───────────────────────────────
            AppTextField(
              label: 'Story Prompt',
              hint: 'A detective in 2050 discovers that dreams are being stolen...',
              controller: _promptController,
              maxLines: 5,
            ),
            const SizedBox(height: AppSpacing.xxl),

            // ── Generate button ────────────────────────────
            PrimaryButton(
              label: isLoading ? 'Generating...' : 'Generate Script',
              icon: isLoading ? null : Iconsax.magic_star,
              isExpanded: true,
              isLoading: isLoading,
              onPressed: isLoading ? null : _generate,
            ),

            // ── Loading indicator ──────────────────────────
            if (isLoading) ...[
              const SizedBox(height: AppSpacing.xxl),
              AIGeneratingCard(
                status: 'Writing your ${_selectedGenre.toLowerCase()} script...',
                progress: 0.6,
                steps: const [
                  'Analyzing prompt',
                  'Building story structure',
                  'Writing scenes',
                  'Formatting output',
                ],
                currentStep: 2,
              ).animate().fadeIn(duration: 300.ms),
            ],

            // ── Script result ──────────────────────────────
            if (scriptContent != null && !isLoading) ...[
              const SizedBox(height: AppSpacing.xxl),
              AIResponseCard(
                title: 'Generated Script',
                content: scriptContent,
                onCopy: () => Clipboard.setData(ClipboardData(text: scriptContent)),
                onRegenerate: _generate,
              ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.02),
            ],

            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}
