import 'package:flutter/material.dart';
import '../../models/models.dart';

class ChatPage extends StatefulWidget {
  final ProfileData profile;
  final List<ChatMessage> messages;
  final void Function(ChatMessage) onSend;

  const ChatPage({
    super.key,
    required this.profile,
    required this.messages,
    required this.onSend,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final TextEditingController _ctrl = TextEditingController();
  final ScrollController _scrollCtrl = ScrollController();
  late List<ChatMessage> _msgs;
  bool _showEmojis = false;
  late AnimationController _sendAnim;

  final List<String> _quickEmojis = [
    "🎬", "👏", "🔥", "💡", "✅", "🎥", "🌟", "🤝",
  ];

  @override
  void initState() {
    super.initState();
    _msgs = List.from(widget.messages);
    _sendAnim = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _scrollToBottom(animated: false));
    for (final m in _msgs) {
      if (!m.isSent) m.isRead = true;
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _scrollCtrl.dispose();
    _sendAnim.dispose();
    super.dispose();
  }

  void _send() {
    final text = _ctrl.text.trim();
    if (text.isEmpty) return;

    final msg = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
      isSent: true,
      time: DateTime.now(),
      isRead: false,
    );
    setState(() {
      _msgs.add(msg);
      _showEmojis = false;
    });
    widget.onSend(msg);
    _ctrl.clear();
    _sendAnim.forward().then((_) => _sendAnim.reverse());
    Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);

    // Simulate reply
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      final replies = [
        "That sounds great! 🎬",
        "Absolutely, let's make it happen!",
        "Love the idea 🔥",
        "Can we schedule a call soon?",
        "Definitely interested. Tell me more!",
      ];
      replies.shuffle();
      final reply = ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: replies.first,
        isSent: false,
        time: DateTime.now(),
        isRead: true,
      );
      setState(() => _msgs.add(reply));
      widget.onSend(reply);
      _scrollToBottom();
    });
  }

  void _scrollToBottom({bool animated = true}) {
    if (!_scrollCtrl.hasClients) return;
    if (animated) {
      _scrollCtrl.animateTo(
        _scrollCtrl.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } else {
      _scrollCtrl.jumpTo(_scrollCtrl.position.maxScrollExtent);
    }
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  String _formatTime(DateTime t) {
    final h = t.hour > 12 ? t.hour - 12 : (t.hour == 0 ? 12 : t.hour);
    final m = t.minute.toString().padLeft(2, '0');
    return "$h:$m ${t.hour >= 12 ? 'PM' : 'AM'}";
  }

  String _formatDate(DateTime t) {
    final now = DateTime.now();
    if (_isSameDay(t, now)) return "Today";
    if (_isSameDay(t, now.subtract(const Duration(days: 1)))) return "Yesterday";
    return "${t.day}/${t.month}/${t.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff09090B),
      body: Column(
        children: [
          // ── App bar ──────────────────────────────────────────────────
          Container(
            decoration: BoxDecoration(
              color: const Color(0xff0f0f0f),
              border:
                  Border(bottom: BorderSide(color: Colors.white.withOpacity(0.06))),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 16, 12),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white.withOpacity(0.05),
                        ),
                        child: const Icon(Icons.arrow_back_ios_new_rounded, size: 16),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            colors: [widget.profile.color1, widget.profile.color2]),
                      ),
                      child: Icon(widget.profile.icon, color: Colors.white, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                widget.profile.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 15),
                                overflow: TextOverflow.ellipsis,
                              ),
                              if (widget.profile.isVerified) ...[
                                const SizedBox(width: 4),
                                const Icon(Icons.verified_rounded,
                                    size: 13, color: Color(0xffFF8C00)),
                              ],
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: 7,
                                height: 7,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xff38ef7d),
                                ),
                              ),
                              const SizedBox(width: 5),
                              const Text("Online",
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Color(0xff38ef7d),
                                      fontWeight: FontWeight.w600)),
                              Text(" · ${widget.profile.role}",
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.white.withOpacity(0.4))),
                            ],
                          ),
                        ],
                      ),
                    ),
                    _headerAction(Icons.videocam_outlined),
                    const SizedBox(width: 8),
                    _headerAction(Icons.call_outlined),
                    const SizedBox(width: 4),
                    _headerAction(Icons.more_vert_rounded),
                  ],
                ),
              ),
            ),
          ),

          // ── Messages list ────────────────────────────────────────────
          Expanded(
            child: ListView.builder(
              controller: _scrollCtrl,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              physics: const BouncingScrollPhysics(),
              itemCount: _msgs.length,
              itemBuilder: (_, i) {
                final msg = _msgs[i];
                final showDate =
                    i == 0 || !_isSameDay(msg.time, _msgs[i - 1].time);
                final showAvatar = !msg.isSent &&
                    (i == _msgs.length - 1 || _msgs[i + 1].isSent);

                return Column(
                  children: [
                    if (showDate) _dateDivider(_formatDate(msg.time)),
                    _bubble(msg, showAvatar),
                  ],
                );
              },
            ),
          ),

          // ── Emoji quick picks ────────────────────────────────────────
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutCubic,
            height: _showEmojis ? 52 : 0,
            color: const Color(0xff0f0f0f),
            child: _showEmojis
                ? ListView(
                    scrollDirection: Axis.horizontal,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    children: _quickEmojis
                        .map((e) => GestureDetector(
                              onTap: () {
                                _ctrl.text += e;
                                _ctrl.selection = TextSelection.collapsed(
                                    offset: _ctrl.text.length);
                              },
                              child: Container(
                                width: 36,
                                height: 36,
                                margin: const EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white.withOpacity(0.06),
                                ),
                                child: Center(
                                    child: Text(e,
                                        style:
                                            const TextStyle(fontSize: 18))),
                              ),
                            ))
                        .toList(),
                  )
                : null,
          ),

          // ── Input bar ────────────────────────────────────────────────
          Container(
            color: const Color(0xff0f0f0f),
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 10,
              bottom: MediaQuery.of(context).padding.bottom + 10,
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => setState(() => _showEmojis = !_showEmojis),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: _showEmojis
                          ? const Color(0xffFF8C00).withOpacity(0.15)
                          : Colors.white.withOpacity(0.06),
                    ),
                    child: const Center(
                        child: Text("😊", style: TextStyle(fontSize: 18))),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: Colors.white.withOpacity(0.06),
                      border:
                          Border.all(color: Colors.white.withOpacity(0.07)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _ctrl,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.white),
                            maxLines: 4,
                            minLines: 1,
                            textCapitalization:
                                TextCapitalization.sentences,
                            onChanged: (_) => setState(() {}),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              hintText: "Type a message...",
                              hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.3),
                                  fontSize: 14),
                            ),
                          ),
                        ),
                        if (_ctrl.text.isEmpty)
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Icon(Icons.attach_file_rounded,
                                color: Colors.white.withOpacity(0.3),
                                size: 20),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: _send,
                  child: ScaleTransition(
                    scale: Tween(begin: 1.0, end: 0.85).animate(
                        CurvedAnimation(
                            parent: _sendAnim, curve: Curves.easeInOut)),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: _ctrl.text.trim().isEmpty
                            ? LinearGradient(colors: [
                                Colors.white.withOpacity(0.1),
                                Colors.white.withOpacity(0.1),
                              ])
                            : const LinearGradient(colors: [
                                Color(0xffFF8C00),
                                Color(0xffFF3D00),
                              ]),
                      ),
                      child: Icon(
                        _ctrl.text.trim().isEmpty
                            ? Icons.mic_rounded
                            : Icons.send_rounded,
                        color: _ctrl.text.trim().isEmpty
                            ? Colors.white.withOpacity(0.4)
                            : Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _headerAction(IconData icon) => Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white.withOpacity(0.05),
        ),
        child: Icon(icon, color: Colors.white.withOpacity(0.8), size: 18),
      );

  Widget _dateDivider(String label) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(children: [
          Expanded(child: Divider(color: Colors.white.withOpacity(0.08))),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white.withOpacity(0.06),
              ),
              child: Text(
                label,
                style: TextStyle(
                    fontSize: 11,
                    color: Colors.white.withOpacity(0.45),
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Expanded(child: Divider(color: Colors.white.withOpacity(0.08))),
        ]),
      );

  Widget _bubble(ChatMessage msg, bool showAvatar) {
    final isSent = msg.isSent;
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment:
            isSent ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isSent) ...[
            SizedBox(
              width: 30,
              child: showAvatar
                  ? Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(colors: [
                          widget.profile.color1,
                          widget.profile.color2,
                        ]),
                      ),
                      child: Icon(widget.profile.icon,
                          color: Colors.white, size: 14),
                    )
                  : null,
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: isSent
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.68),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(18),
                      topRight: const Radius.circular(18),
                      bottomLeft: Radius.circular(isSent ? 18 : 4),
                      bottomRight: Radius.circular(isSent ? 4 : 18),
                    ),
                    gradient: isSent
                        ? const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xffFF8C00), Color(0xffFF3D00)],
                          )
                        : null,
                    color: isSent ? null : Colors.white.withOpacity(0.09),
                  ),
                  child: Text(
                    msg.text,
                    style: TextStyle(
                      fontSize: 14,
                      color: isSent
                          ? Colors.white
                          : Colors.white.withOpacity(0.9),
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _formatTime(msg.time),
                      style: TextStyle(
                          fontSize: 10, color: Colors.white.withOpacity(0.3)),
                    ),
                    if (isSent) ...[
                      const SizedBox(width: 4),
                      Icon(
                        msg.isRead
                            ? Icons.done_all_rounded
                            : Icons.done_rounded,
                        size: 13,
                        color: msg.isRead
                            ? const Color(0xff38ef7d)
                            : Colors.white.withOpacity(0.35),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          if (isSent) const SizedBox(width: 4),
        ],
      ),
    );
  }
}
