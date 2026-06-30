import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/theme.dart';
import '../../../../shared/widgets/media/cached_avatar.dart';
import 'chat_screen.dart';

/// Conversations list screen showing active collaborations and messages.
class ConversationsScreen extends StatefulWidget {
  const ConversationsScreen({super.key});

  @override
  State<ConversationsScreen> createState() => _ConversationsScreenState();
}

class _ConversationsScreenState extends State<ConversationsScreen> {
  final _searchCtrl = TextEditingController();
  String _searchQuery = '';

  final List<Map<String, dynamic>> _conversations = [
    {
      'id': '1',
      'name': 'Sarah Chen',
      'role': 'Cinematographer',
      'lastMessage': 'The color grading looks amazing! Let\'s discuss the final cut...',
      'lastTime': '5m ago',
      'unread': 2,
      'isOnline': true,
    },
    {
      'id': '2',
      'name': 'Marcus Dev',
      'role': 'VFX Artist',
      'lastMessage': 'I\'ve finished the visual effects for the final scene',
      'lastTime': '1h ago',
      'unread': 0,
      'isOnline': true,
    },
    {
      'id': '3',
      'name': 'Priya Kapoor',
      'role': 'Sound Designer',
      'lastMessage': 'When can we sync on the audio mix?',
      'lastTime': '3h ago',
      'unread': 0,
      'isOnline': false,
    },
    {
      'id': '4',
      'name': 'Alex Rodriguez',
      'role': 'Editor',
      'lastMessage': 'The rough cut is ready for your review',
      'lastTime': '1d ago',
      'unread': 0,
      'isOnline': true,
    },
  ];

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _conversations.where((c) {
      final q = _searchQuery.toLowerCase();
      return q.isEmpty ||
          c['name'].toLowerCase().contains(q) ||
          c['role'].toLowerCase().contains(q);
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // ── App Bar ──────────────────────────────────────────
          SliverAppBar(
            floating: true,
            backgroundColor: AppColors.background,
            surfaceTintColor: Colors.transparent,
            title: Text('Messages', style: AppTypography.h1),
            actions: [
              IconButton(
                icon: const Icon(Iconsax.setting_2, size: 22),
                onPressed: () {},
              ),
              const SizedBox(width: 8),
            ],
          ),

          // ── Search Bar ───────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.surfaceElevated,
                  borderRadius: AppRadii.borderMd,
                  border: Border.all(color: AppColors.border.withValues(alpha: 0.3)),
                ),
                child: TextField(
                  controller: _searchCtrl,
                  onChanged: (v) => setState(() => _searchQuery = v),
                  decoration: InputDecoration(
                    hintText: 'Search conversations...',
                    hintStyle: AppTypography.bodySmall.copyWith(color: AppColors.textTertiary),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    prefixIcon: Icon(Iconsax.search_normal_1, size: 18, color: AppColors.textTertiary),
                  ),
                ),
              ),
            ),
          ),

          // ── Conversations List ───────────────────────────────
          if (filtered.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Iconsax.message,
                      size: 64,
                      color: AppColors.textTertiary.withValues(alpha: 0.3),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No conversations yet',
                      style: AppTypography.labelLarge.copyWith(color: AppColors.textTertiary),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Collaborate with someone to start chatting',
                      style: AppTypography.bodySmall.copyWith(color: AppColors.textTertiary),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          else
            SliverList.separated(
              itemCount: filtered.length,
              separatorBuilder: (_, __) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Divider(color: AppColors.border.withValues(alpha: 0.2), height: 1),
              ),
              itemBuilder: (_, index) {
                final conv = filtered[index];
                return _ConversationTile(
                  conversation: conv,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatScreen(conversationId: conv['id']),
                    ),
                  ),
                ).animate(delay: Duration(milliseconds: index * 50)).fadeIn().slideX(begin: -0.02);
              },
            ),
        ],
      ),
    );
  }
}

class _ConversationTile extends StatelessWidget {
  final Map<String, dynamic> conversation;
  final VoidCallback onTap;

  const _ConversationTile({
    required this.conversation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // ── Avatar with online indicator ──────────────────
            Stack(
              children: [
                CachedAvatar(
                  name: conversation['name'],
                  size: 56,
                ),
                if (conversation['isOnline'])
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.success,
                        border: Border.all(color: AppColors.background, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),

            // ── Message Content ──────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              conversation['name'],
                              style: AppTypography.labelMedium.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              conversation['role'],
                              style: AppTypography.caption.copyWith(
                                color: AppColors.textTertiary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        conversation['lastTime'],
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          conversation['lastMessage'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                      if (conversation['unread'] > 0) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            gradient: AppGradients.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            conversation['unread'].toString(),
                            style: AppTypography.caption.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
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
}
