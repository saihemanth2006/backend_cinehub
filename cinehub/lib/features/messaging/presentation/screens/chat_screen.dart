import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/theme.dart';
import '../../../../shared/widgets/media/cached_avatar.dart';

class ChatMessage {
  final String id;
  final String text;
  final bool isSent;
  final DateTime time;
  bool isRead;

  ChatMessage({
    required this.id,
    required this.text,
    required this.isSent,
    required this.time,
    this.isRead = false,
  });
}

class ChatScreen extends StatefulWidget {
  final String conversationId;
  const ChatScreen({super.key, required this.conversationId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _ctrl = TextEditingController();
  final _scrollCtrl = ScrollController();
  late List<ChatMessage> _messages;

  @override
  void initState() {
    super.initState();
    _messages = [
      ChatMessage(
        id: '1',
        text: 'Hey! How\'s the project coming along?',
        isSent: false,
        time: DateTime.now().subtract(const Duration(hours: 2)),
        isRead: true,
      ),
      ChatMessage(
        id: '2',
        text: 'Almost done with the cinematography! The lighting setup looks great.',
        isSent: true,
        time: DateTime.now().subtract(const Duration(hours: 2)),
        isRead: true,
      ),
      ChatMessage(
        id: '3',
        text: 'That\'s awesome! When can we schedule the review session?',
        isSent: false,
        time: DateTime.now().subtract(const Duration(hours: 1, minutes: 30)),
        isRead: true,
      ),
      ChatMessage(
        id: '4',
        text: 'How about tomorrow at 3 PM? I can share the raw footage beforehand.',
        isSent: true,
        time: DateTime.now().subtract(const Duration(hours: 1)),
        isRead: true,
      ),
      ChatMessage(
        id: '5',
        text: 'Perfect! I\'ll send you my feedback after reviewing.',
        isSent: false,
        time: DateTime.now().subtract(const Duration(minutes: 30)),
        isRead: true,
      ),
    ];

    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom(animated: false));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
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

  void _sendMessage() {
    if (_ctrl.text.trim().isEmpty) return;
    
    setState(() {
      _messages.add(
        ChatMessage(
          id: DateTime.now().toString(),
          text: _ctrl.text,
          isSent: true,
          time: DateTime.now(),
          isRead: false,
        ),
      );
    });
    
    _ctrl.clear();
    Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);

    // Simulate reply
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() {
        _messages.add(
          ChatMessage(
            id: DateTime.now().toString(),
            text: 'Sounds good! I\'ll prepare everything for the meeting. 🎬',
            isSent: false,
            time: DateTime.now(),
            isRead: false,
          ),
        );
      });
      _scrollToBottom();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sarah Chen', style: AppTypography.labelLarge),
            const SizedBox(height: 2),
            Text(
              'Cinematographer • Active now',
              style: AppTypography.caption.copyWith(color: AppColors.textTertiary),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.call, size: 22),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Iconsax.video, size: 22),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Iconsax.info_circle, size: 22),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // ── Messages ─────────────────────────────────────────
          Expanded(
            child: ListView.builder(
              controller: _scrollCtrl,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: _messages.length,
              itemBuilder: (_, index) {
                final msg = _messages[index];
                return _MessageBubble(
                  message: msg,
                  showAvatar: index == 0 || _messages[index - 1].isSent != msg.isSent,
                ).animate(delay: Duration(milliseconds: index * 50)).fadeIn().slideY(begin: 0.02);
              },
            ),
          ),

          // ── Divider ──────────────────────────────────────────
          Divider(color: AppColors.border.withValues(alpha: 0.2), height: 1),

          // ── Message Input ────────────────────────────────────
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // ── Action buttons ──────────────────────────────
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceElevated,
                      borderRadius: AppRadii.borderMd,
                      border: Border.all(color: AppColors.border.withValues(alpha: 0.3)),
                    ),
                    child: Icon(Iconsax.add, size: 20, color: AppColors.textSecondary),
                  ),
                ),
                const SizedBox(width: 8),

                // ── Text input ──────────────────────────────────
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.surfaceElevated,
                      borderRadius: AppRadii.borderMd,
                      border: Border.all(color: AppColors.border.withValues(alpha: 0.3)),
                    ),
                    child: TextField(
                      controller: _ctrl,
                      maxLines: 3,
                      minLines: 1,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        hintStyle: AppTypography.bodySmall.copyWith(color: AppColors.textTertiary),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      ),
                      style: AppTypography.bodySmall,
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // ── Send button ─────────────────────────────────
                GestureDetector(
                  onTap: _sendMessage,
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      gradient: AppGradients.primary,
                      borderRadius: AppRadii.borderMd,
                    ),
                    child: Icon(
                      Iconsax.send_1,
                      size: 20,
                      color: Colors.white,
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
}

class _MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final bool showAvatar;

  const _MessageBubble({
    required this.message,
    required this.showAvatar,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: message.isSent ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!message.isSent && showAvatar) ...[
            const CachedAvatar(name: 'Sarah Chen', size: 32),
            const SizedBox(width: 8),
          ] else if (!message.isSent)
            const SizedBox(width: 40),
          Flexible(
            child: Column(
              crossAxisAlignment: message.isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: message.isSent ? AppGradients.primary : null,
                    color: message.isSent ? null : AppColors.surfaceElevated,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                      bottomLeft: Radius.circular(message.isSent ? 16 : 4),
                      bottomRight: Radius.circular(message.isSent ? 4 : 16),
                    ),
                    border: message.isSent
                        ? null
                        : Border.all(color: AppColors.border.withValues(alpha: 0.2)),
                  ),
                  child: Text(
                    message.text,
                    style: AppTypography.bodySmall.copyWith(
                      color: message.isSent ? Colors.white : AppColors.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _formatTime(message.time),
                  style: AppTypography.caption.copyWith(color: AppColors.textTertiary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    if (now.day == time.day && now.month == time.month && now.year == time.year) {
      return '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
    }
    return '${time.day}/${time.month}';
  }
}
