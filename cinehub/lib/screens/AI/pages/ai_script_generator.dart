import 'package:flutter/material.dart';
import '../widgets/small_widgets.dart';

class AIScriptGeneratorPage extends StatefulWidget {
  const AIScriptGeneratorPage({super.key});

  @override
  State<AIScriptGeneratorPage> createState() => _AIScriptGeneratorPageState();
}

class _AIScriptGeneratorPageState extends State<AIScriptGeneratorPage> {
  final TextEditingController _promptCtrl = TextEditingController();
  final TextEditingController _charactersCtrl = TextEditingController();
  final TextEditingController _notesCtrl = TextEditingController();
  String _genre = 'Action';
  String _durationVal = '5 min';
  String _style = 'Cinematic';
  final String _tone = 'Dramatic';
  bool _isGenerating = false;
  final List<String> _results = [];

  @override
  void dispose() {
    _promptCtrl.dispose();
    _charactersCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _generate() async {
    final prompt = _promptCtrl.text.trim();
    if (prompt.isEmpty) return;
    setState(() => _isGenerating = true);
    await Future.delayed(const Duration(milliseconds: 900));

    final header = '${_genre.toUpperCase()} • $_durationVal • $_style • $_tone';
    final body = StringBuffer();
    body.writeln(header);
    body.writeln('');
    body.writeln('SCENE: A generated scene based on the prompt.');
    body.writeln(prompt);
    if (_charactersCtrl.text.trim().isNotEmpty) {
      body.writeln('');
      body.writeln('CHARACTERS: ${_charactersCtrl.text.trim()}');
    }
    if (_notesCtrl.text.trim().isNotEmpty) {
      body.writeln('');
      body.writeln('NOTES: ${_notesCtrl.text.trim()}');
    }

    setState(() {
      _results.insert(0, body.toString());
      _isGenerating = false;
    });
  }

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
          'AI Script Generator',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.help_outline_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TagChip(
                label: 'AI Script Generator',
                color: const Color(0xFF8B5CF6),
              ),
              const SizedBox(height: 12),
              const Text(
                'Fill in the fields below to generate a script.',
                style: TextStyle(color: Colors.white60),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Genre',
                        style: TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0F0F14),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.04),
                          ),
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: _genre,
                          dropdownColor: const Color(0xFF111118),
                          underline: const SizedBox.shrink(),
                          items: const [
                            DropdownMenuItem(
                              value: 'Action',
                              child: Text('Action'),
                            ),
                            DropdownMenuItem(
                              value: 'Drama',
                              child: Text('Drama'),
                            ),
                            DropdownMenuItem(
                              value: 'Comedy',
                              child: Text('Comedy'),
                            ),
                            DropdownMenuItem(
                              value: 'Horror',
                              child: Text('Horror'),
                            ),
                          ],
                          onChanged: (v) =>
                              setState(() => _genre = v ?? 'Action'),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Duration',
                        style: TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0F0F14),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.04),
                          ),
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: _durationVal,
                          dropdownColor: const Color(0xFF111118),
                          underline: const SizedBox.shrink(),
                          items: const [
                            DropdownMenuItem(
                              value: '1 min',
                              child: Text('1 min'),
                            ),
                            DropdownMenuItem(
                              value: '3 min',
                              child: Text('3 min'),
                            ),
                            DropdownMenuItem(
                              value: '5 min',
                              child: Text('5 min'),
                            ),
                            DropdownMenuItem(
                              value: '10 min',
                              child: Text('10 min'),
                            ),
                          ],
                          onChanged: (v) =>
                              setState(() => _durationVal = v ?? '5 min'),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Style',
                        style: TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0F0F14),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.04),
                          ),
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: _style,
                          dropdownColor: const Color(0xFF111118),
                          underline: const SizedBox.shrink(),
                          items: const [
                            DropdownMenuItem(
                              value: 'Cinematic',
                              child: Text('Cinematic'),
                            ),
                            DropdownMenuItem(
                              value: 'Documentary',
                              child: Text('Documentary'),
                            ),
                            DropdownMenuItem(
                              value: 'Experimental',
                              child: Text('Experimental'),
                            ),
                          ],
                          onChanged: (v) =>
                              setState(() => _style = v ?? 'Cinematic'),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Theme / Message *',
                        style: TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF0F0F14),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.04),
                          ),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: TextField(
                          controller: _promptCtrl,
                          maxLines: 5,
                          style: const TextStyle(color: Colors.white70),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText:
                                'e.g., A detective solving a mysterious crime',
                            hintStyle: TextStyle(color: Colors.white24),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Characters (comma-separated)',
                        style: TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF0F0F14),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.04),
                          ),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: TextField(
                          controller: _charactersCtrl,
                          maxLines: 2,
                          style: const TextStyle(color: Colors.white70),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText:
                                'e.g., Detective John, Suspect Sarah, Witness Tom',
                            hintStyle: TextStyle(color: Colors.white24),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Additional Notes',
                        style: TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF0F0F14),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.04),
                          ),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: TextField(
                          controller: _notesCtrl,
                          maxLines: 4,
                          style: const TextStyle(color: Colors.white70),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText:
                                'Any additional requirements or story elements',
                            hintStyle: TextStyle(color: Colors.white24),
                          ),
                        ),
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: _GlowButton(
                      label: _isGenerating
                          ? 'Generating...'
                          : '✨  Generate Script',
                      colors: const [Color(0xFF8B5CF6), Color(0xFF6366F1)],
                      onTap: _isGenerating ? () {} : _generate,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
