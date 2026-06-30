import 'package:flutter/material.dart';

class TextToVideoPage extends StatefulWidget {
  const TextToVideoPage({super.key});

  @override
  State<TextToVideoPage> createState() => _TextToVideoPageState();
}

class _TextToVideoPageState extends State<TextToVideoPage> {
  final TextEditingController _prompt = TextEditingController();
  String _quality = 'High';
  int _qualityNumber = 75;
  String _resolution = '1080p';
  final double _duration = 12.0;
  bool _isGenerating = false;
  final List<Map<String, String>> _videos = [];

  @override
  void dispose() {
    _prompt.dispose();
    super.dispose();
  }

  Future<void> _generateVideo() async {
    final text = _prompt.text.trim();
    if (text.isEmpty) return;
    setState(() => _isGenerating = true);
    await Future.delayed(const Duration(milliseconds: 1000));

    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final title =
        '$_quality ($_qualityNumber) • $_resolution • ${_duration.toInt()}s';
    final url = 'https://cinehub.local/generated/$id.mp4';

    setState(() {
      _videos.insert(0, {'id': id, 'title': title, 'url': url, 'prompt': text});
      _isGenerating = false;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Generated video: $title')));
  }

  @override
  Widget build(BuildContext context) {
    final double bottomInset = MediaQuery.of(context).viewInsets.bottom;
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
          'Text → Video',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 16.0 + bottomInset),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFF43F5E).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFFF43F5E).withOpacity(0.4),
                    width: 0.8,
                  ),
                ),
                child: const Text(
                  'Text to Video',
                  style: TextStyle(
                    color: Color(0xFFF43F5E),
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Describe the scene or shot you want to create.',
                style: TextStyle(color: Colors.white60),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF0F0F14),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.white.withOpacity(0.04)),
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    TextField(
                      controller: _prompt,
                      maxLines: 4,
                      style: const TextStyle(color: Colors.white70),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText:
                            'e.g. A misty coastal sunrise, a lone boat...',
                        hintStyle: TextStyle(color: Colors.white24),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Quality',
                              style: TextStyle(color: Colors.white70),
                            ),
                            const SizedBox(width: 12),
                            DropdownButton<String>(
                              value: _quality,
                              dropdownColor: const Color(0xFF111118),
                              items: const [
                                DropdownMenuItem(
                                  value: 'Low',
                                  child: Text('Low'),
                                ),
                                DropdownMenuItem(
                                  value: 'Medium',
                                  child: Text('Medium'),
                                ),
                                DropdownMenuItem(
                                  value: 'High',
                                  child: Text('High'),
                                ),
                              ],
                              onChanged: (v) =>
                                  setState(() => _quality = v ?? 'High'),
                            ),
                            const SizedBox(width: 18),
                            const Text(
                              'Resolution',
                              style: TextStyle(color: Colors.white70),
                            ),
                            const SizedBox(width: 12),
                            DropdownButton<String>(
                              value: _resolution,
                              dropdownColor: const Color(0xFF111118),
                              items: const [
                                DropdownMenuItem(
                                  value: '720p',
                                  child: Text('720p'),
                                ),
                                DropdownMenuItem(
                                  value: '1080p',
                                  child: Text('1080p'),
                                ),
                                DropdownMenuItem(
                                  value: '4K',
                                  child: Text('4K'),
                                ),
                              ],
                              onChanged: (v) =>
                                  setState(() => _resolution = v ?? '1080p'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Text(
                              'Quality Number',
                              style: TextStyle(color: Colors.white70),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: SliderTheme(
                                data: SliderThemeData(
                                  trackHeight: 6,
                                  thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 10,
                                  ),
                                ),
                                child: Slider(
                                  value: _qualityNumber.toDouble(),
                                  min: 1,
                                  max: 100,
                                  divisions: 99,
                                  label: '$_qualityNumber',
                                  activeColor: const Color(0xFFF97316),
                                  onChanged: (v) => setState(
                                    () => _qualityNumber = v.toInt(),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF111118),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '$_qualityNumber',
                                style: const TextStyle(color: Colors.white70),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: _isGenerating ? () {} : _generateVideo,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFF43F5E), Color(0xFFF97316)],
                          ),
                          borderRadius: BorderRadius.circular(22),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFF43F5E).withOpacity(0.45),
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _isGenerating
                                  ? 'Generating...'
                                  : 'Generate Video',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            if (!_isGenerating) ...[
                              const SizedBox(width: 6),
                              const Icon(
                                Icons.arrow_forward_rounded,
                                color: Colors.white,
                                size: 14,
                              ),
                            ]
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFF111118),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.refresh_rounded,
                        color: Colors.white54,
                      ),
                      onPressed: () {
                        setState(() {
                          _prompt.clear();
                          _videos.clear();
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              const Text(
                'Generated',
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              _videos.isEmpty
                  ? Center(
                      child: Text(
                        'No videos yet — generate one.',
                        style: TextStyle(color: Colors.white24),
                      ),
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _videos.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (_, i) {
                        final v = _videos[i];
                        return Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF0F0F14),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.03),
                            ),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 92,
                                    height: 56,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFFF43F5E),
                                          Color(0xFFF97316),
                                        ],
                                      ),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.play_arrow_rounded,
                                        color: Colors.white,
                                        size: 28,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          v['title'] ?? '',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          v['prompt'] ?? '',
                                          style: const TextStyle(
                                            color: Colors.white70,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
