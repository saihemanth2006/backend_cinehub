import 'package:flutter/material.dart';
import '../../models/models.dart';
import 'chat_page.dart';

class MessagesPage extends StatefulWidget {
  final List<ProfileData> allProfiles;
  final Set<int> collaborated;
  final Map<String, List<ChatMessage>> conversations;
  final void Function(String profileName, ChatMessage msg) onSendMessage;

  const MessagesPage({
    super.key,
    required this.allProfiles,
    required this.collaborated,
    required this.conversations,
    required this.onSendMessage,
  });

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  String _searchQuery = "";

  List<ProfileData> get _collaboratedProfiles =>
      widget.collaborated.map((i) => widget.allProfiles[i]).toList();

  @override
  Widget build(BuildContext context) {
    final profiles = _collaboratedProfiles.where((p) {
      final q = _searchQuery.toLowerCase();
      return q.isEmpty ||
          p.name.toLowerCase().contains(q) ||
          p.role.toLowerCase().contains(q);
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xff09090B),
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ─────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Messages",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w800)),
                        Text(
                          "${_collaboratedProfiles.length} active collaborations",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withOpacity(0.45)),
                        ),
                      ],
                    ),
                  ),
                  _glass(Icons.edit_outlined),
                ],
              ),
            ),

            // ── Search bar ─────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 46,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white.withOpacity(0.06)),
                ),
                child: Row(children: [
                  const SizedBox(width: 14),
                  Icon(Icons.search_rounded,
                      color: Colors.white.withOpacity(0.4), size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      onChanged: (v) => setState(() => _searchQuery = v),
                      style:
                          const TextStyle(fontSize: 13, color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search messages...",
                        hintStyle: TextStyle(
                            fontSize: 13,
                            color: Colors.white.withOpacity(0.3)),
                      ),
                    ),
                  ),
                ]),
              ),
            ),

            const SizedBox(height: 16),

            // ── Stories row ────────────────────────────────────────────
            if (_collaboratedProfiles.isNotEmpty) ...[
              SizedBox(
                height: 92,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _collaboratedProfiles.length,
                  itemBuilder: (_, i) {
                    final p = _collaboratedProfiles[i];
                    final unread = _unreadCount(p.name);
                    return GestureDetector(
                      onTap: () => _openChat(p),
                      child: Container(
                        width: 66,
                        margin: const EdgeInsets.only(right: 14),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: 56,
                                  height: 56,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                        colors: [p.color1, p.color2]),
                                    boxShadow: [
                                      BoxShadow(
                                          color: p.color1.withOpacity(0.4),
                                          blurRadius: 10),
                                    ],
                                  ),
                                  child: Icon(p.icon,
                                      color: Colors.white, size: 24),
                                ),
                                if (unread > 0)
                                  Positioned(
                                    right: 0,
                                    top: 0,
                                    child: Container(
                                      width: 18,
                                      height: 18,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xffFF3D00),
                                      ),
                                      child: Center(
                                          child: Text('$unread',
                                              style: const TextStyle(
                                                  fontSize: 9,
                                                  fontWeight:
                                                      FontWeight.w800))),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              p.name.split(' ').first,
                              style: const TextStyle(
                                  fontSize: 11, fontWeight: FontWeight.w600),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(children: [
                  Text(
                    "Recent",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white.withOpacity(0.8)),
                  ),
                  const Spacer(),
                  Text(
                    "See all",
                    style: TextStyle(
                        fontSize: 12,
                        color: const Color(0xffFF8C00).withOpacity(0.9),
                        fontWeight: FontWeight.w600),
                  ),
                ]),
              ),
              const SizedBox(height: 8),
            ],

            // ── Conversation list ──────────────────────────────────────
            Expanded(
              child: profiles.isEmpty
                  ? _emptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 4, 20, 100),
                      physics: const BouncingScrollPhysics(),
                      itemCount: profiles.length,
                      itemBuilder: (_, i) => _convoTile(profiles[i]),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Helpers ──────────────────────────────────────────────────────────

  int _unreadCount(String name) {
    final msgs = widget.conversations[name] ?? [];
    return msgs.where((m) => !m.isSent && !m.isRead).length;
  }

  String _lastMessage(String name) {
    final msgs = widget.conversations[name] ?? [];
    if (msgs.isEmpty) return "Collaboration started 🎬";
    final last = msgs.last;
    return (last.isSent ? "You: " : "") + last.text;
  }

  String _lastTime(String name) {
    final msgs = widget.conversations[name] ?? [];
    if (msgs.isEmpty) return "";
    final diff = DateTime.now().difference(msgs.last.time);
    if (diff.inMinutes < 60) return "${diff.inMinutes}m";
    if (diff.inHours < 24) return "${diff.inHours}h";
    return "${diff.inDays}d";
  }

  void _openChat(ProfileData p) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChatPage(
          profile: p,
          messages: widget.conversations[p.name] ?? [],
          onSend: (msg) => widget.onSendMessage(p.name, msg),
        ),
      ),
    );
  }

  // ── Widgets ──────────────────────────────────────────────────────────

  Widget _convoTile(ProfileData p) {
    final unread = _unreadCount(p.name);
    return GestureDetector(
      onTap: () => _openChat(p),
      child: Container(
        margin: const EdgeInsets.only(bottom: 4),
        padding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: unread > 0
              ? Colors.white.withOpacity(0.04)
              : Colors.transparent,
        ),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient:
                        LinearGradient(colors: [p.color1, p.color2]),
                  ),
                  child: Icon(p.icon, color: Colors.white, size: 22),
                ),
                Positioned(
                  bottom: 2,
                  right: 2,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: p.availability == "Open"
                          ? const Color(0xff38ef7d)
                          : Colors.orange,
                      border: Border.all(
                          color: const Color(0xff09090B), width: 2),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          p.name,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: unread > 0
                                  ? FontWeight.w800
                                  : FontWeight.w600),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        _lastTime(p.name),
                        style: TextStyle(
                          fontSize: 11,
                          color: unread > 0
                              ? const Color(0xffFF8C00)
                              : Colors.white.withOpacity(0.35),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _lastMessage(p.name),
                          style: TextStyle(
                            fontSize: 12,
                            color: unread > 0
                                ? Colors.white.withOpacity(0.7)
                                : Colors.white.withOpacity(0.4),
                            fontWeight: unread > 0
                                ? FontWeight.w500
                                : FontWeight.w400,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      if (unread > 0)
                        Container(
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(colors: [
                              Color(0xffFF8C00),
                              Color(0xffFF3D00),
                            ]),
                          ),
                          child: Center(
                            child: Text('$unread',
                                style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800)),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emptyState() => Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.chat_bubble_outline_rounded,
              size: 60, color: Colors.white.withOpacity(0.1)),
          const SizedBox(height: 16),
          const Text("No messages yet",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white24)),
          const SizedBox(height: 8),
          Text("Collaborate with someone to start chatting",
              style: TextStyle(
                  fontSize: 13, color: Colors.white.withOpacity(0.25))),
        ]),
      );

  Widget _glass(IconData icon) => Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: Colors.white.withOpacity(0.06),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      );
}
