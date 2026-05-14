import 'package:flutter/material.dart';
import '../models/script_models.dart';
import '../script_generator_service.dart';

class AIScriptGeneratorScreen extends StatefulWidget {
  final String apiKey;

  const AIScriptGeneratorScreen({
    required this.apiKey,
    super.key,
  });

  @override
  State<AIScriptGeneratorScreen> createState() =>
      _AIScriptGeneratorScreenState();
}

class _AIScriptGeneratorScreenState extends State<AIScriptGeneratorScreen> {
  late ScriptGeneratorService _service;
  
  ScriptGenre _selectedGenre = ScriptGenre.action;
  ScriptDuration _selectedDuration = ScriptDuration.fiveMin;
  ScriptStyle _selectedStyle = ScriptStyle.cinematic;
  
  final TextEditingController _themeController = TextEditingController();
  final TextEditingController _charactersController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  
  ScriptGenerationResponse? _generatedScript;
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _service = ScriptGeneratorService(apiKey: widget.apiKey);
  }

  @override
  void dispose() {
    _themeController.dispose();
    _charactersController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _generateScript() async {
    if (_themeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a theme')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final characters =
          _charactersController.text.isNotEmpty
              ? _charactersController.text.split(',').map((e) => e.trim()).toList()
              : null;

      final request = ScriptGenerationRequest(
        genre: _selectedGenre,
        duration: _selectedDuration,
        theme: _themeController.text,
        characters: characters,
        style: _selectedStyle,
        additionalNotes: _notesController.text.isNotEmpty
            ? _notesController.text
            : null,
      );

      final response = await _service.generateScript(request);

      setState(() {
        _generatedScript = response;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Script generated successfully!')),
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
        title: const Text('🎬 AI Script Generator'),
        elevation: 0,
      ),
      body: _isLoading
          ? _buildLoadingView()
          : (_generatedScript != null
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
          _buildSectionTitle('Script Parameters'),
          const SizedBox(height: 16),
          _buildGenreDropdown(),
          const SizedBox(height: 12),
          _buildDurationDropdown(),
          const SizedBox(height: 12),
          _buildStyleDropdown(),
          const SizedBox(height: 20),
          _buildThemeInput(),
          const SizedBox(height: 12),
          _buildCharactersInput(),
          const SizedBox(height: 12),
          _buildNotesInput(),
          const SizedBox(height: 24),
          _buildGenerateButton(),
        ],
      ),
    );
  }

  Widget _buildGenreDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Genre',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        DropdownButton<ScriptGenre>(
          isExpanded: true,
          value: _selectedGenre,
          items: ScriptGenre.values.map((genre) {
            return DropdownMenuItem(
              value: genre,
              child: Text(genre.label),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() => _selectedGenre = value);
            }
          },
        ),
      ],
    );
  }

  Widget _buildDurationDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Duration',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        DropdownButton<ScriptDuration>(
          isExpanded: true,
          value: _selectedDuration,
          items: ScriptDuration.values.map((duration) {
            return DropdownMenuItem(
              value: duration,
              child: Text(duration.label),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() => _selectedDuration = value);
            }
          },
        ),
      ],
    );
  }

  Widget _buildStyleDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Style',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        DropdownButton<ScriptStyle>(
          isExpanded: true,
          value: _selectedStyle,
          items: ScriptStyle.values.map((style) {
            return DropdownMenuItem(
              value: style,
              child: Text(style.label),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() => _selectedStyle = value);
            }
          },
        ),
      ],
    );
  }

  Widget _buildThemeInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Theme / Message *',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _themeController,
          maxLines: 2,
          decoration: InputDecoration(
            hintText: 'e.g., A detective solving a mysterious crime',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCharactersInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Characters (comma-separated)',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _charactersController,
          maxLines: 2,
          decoration: InputDecoration(
            hintText: 'e.g., Detective John, Suspect Sarah, Witness Tom',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNotesInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Additional Notes',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _notesController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Any additional requirements or story elements',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGenerateButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _isLoading ? null : _generateScript,
        icon: const Icon(Icons.auto_awesome),
        label: const Text('Generate Script'),
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
            'Generating your script...\nThis may take up to 2 minutes',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  Widget _buildResultView() {
    if (_generatedScript == null) return const SizedBox();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Generated Script',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _generatedScript = null;
                    _isLoading = false;
                  });
                },
                icon: const Icon(Icons.add),
                label: const Text('New Script'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildExpandableSection(
            title: '📖 Story Outline',
            content: _generatedScript!.storyOutline,
          ),
          const SizedBox(height: 16),
          _buildExpandableSection(
            title: '🎬 Screenplay',
            content: _generatedScript!.screenplay,
          ),
          const SizedBox(height: 16),
          _buildDialoguesSection(),
          const SizedBox(height: 16),
          _buildShotSuggestionsSection(),
          const SizedBox(height: 16),
          _buildExportOptions(),
        ],
      ),
    );
  }

  Widget _buildDialoguesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('💬 Dialogues'),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _generatedScript!.dialogues.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    _generatedScript!.dialogues[index],
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildShotSuggestionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('🎥 Shot Suggestions'),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _generatedScript!.shotSuggestions.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    _generatedScript!.shotSuggestions[index],
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildExpandableSection({
    required String title,
    required String content,
  }) {
    return Card(
      child: ExpansionTile(
        title: Text(title),
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              content,
              style: const TextStyle(fontSize: 14, height: 1.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExportOptions() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              // TODO: Implement copy to clipboard
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Copied to clipboard!')),
              );
            },
            icon: const Icon(Icons.copy),
            label: const Text('Copy'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              // TODO: Implement export to file
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Export feature coming soon!')),
              );
            },
            icon: const Icon(Icons.download),
            label: const Text('Export'),
          ),
        ),
      ],
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
