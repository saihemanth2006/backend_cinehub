import 'package:flutter/material.dart';

class CollaborateDialog extends StatefulWidget {
  final VoidCallback onConfirm;

  const CollaborateDialog({super.key, required this.onConfirm});

  @override
  State<CollaborateDialog> createState() => _CollaborateDialogState();
}

class _CollaborateDialogState extends State<CollaborateDialog> {
  String? _selectedType;
  final _msgCtrl = TextEditingController();

  final List<Map<String, dynamic>> _types = [
    {"label": "Short Film", "icon": Icons.movie_rounded},
    {"label": "Feature Film", "icon": Icons.theaters_rounded},
    {"label": "Commercial", "icon": Icons.campaign_rounded},
    {"label": "Music Video", "icon": Icons.music_video_rounded},
  ];

  @override
  void dispose() {
    _msgCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: const Color(0xff111111),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: Colors.white.withOpacity(0.07)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xffFF8C00).withOpacity(0.12),
                blurRadius: 40,
                spreadRadius: 4,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header ────────────────────────────────────────────────
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      gradient: const LinearGradient(
                        colors: [Color(0xffFF8C00), Color(0xffFF3D00)],
                      ),
                    ),
                    child: const Icon(Icons.handshake_rounded, size: 20),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Send Collaborate Request",
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                        ),
                        Text(
                          "Tell them what you have in mind",
                          style: TextStyle(fontSize: 12, color: Colors.white54),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close_rounded, color: Colors.white.withOpacity(0.4)),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ── Project type chips ─────────────────────────────────────
              const Text(
                "Project Type",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _types.map((t) {
                  final active = _selectedType == t["label"];
                  return GestureDetector(
                    onTap: () => setState(() => _selectedType = t["label"]),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: active
                            ? const LinearGradient(
                                colors: [Color(0xffFF8C00), Color(0xffFF3D00)],
                              )
                            : null,
                        color: active ? null : Colors.white.withOpacity(0.07),
                        border: active
                            ? null
                            : Border.all(color: Colors.white.withOpacity(0.08)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            t["icon"] as IconData,
                            size: 13,
                            color: active ? Colors.white : Colors.white.withOpacity(0.6),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            t["label"] as String,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: active ? Colors.white : Colors.white.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 16),

              // ── Optional message ───────────────────────────────────────
              const Text(
                "Message (optional)",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white.withOpacity(0.05),
                  border: Border.all(color: Colors.white.withOpacity(0.08)),
                ),
                child: TextField(
                  controller: _msgCtrl,
                  maxLines: 3,
                  style: const TextStyle(fontSize: 13, color: Colors.white),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(14),
                    hintText: "Hi! I'd love to work with you on...",
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.3),
                      fontSize: 13,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ── Send button ────────────────────────────────────────────
              GestureDetector(
                onTap: widget.onConfirm,
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: const LinearGradient(
                      colors: [Color(0xffFF8C00), Color(0xffFF3D00)],
                    ),
                  ),
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.send_rounded, size: 17),
                        SizedBox(width: 8),
                        Text(
                          "Send Request",
                          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
