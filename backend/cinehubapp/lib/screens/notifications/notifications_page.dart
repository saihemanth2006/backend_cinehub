import 'package:flutter/material.dart';
import '../../models/models.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  String _filter = "All";
  final List<String> _filters = [
    "All",
    "Unread",
    "Collaborations",
    "Messages",
    "Projects",
  ];

  final List<NotificationItem> _notifications = [
    NotificationItem(
      id: "1",
      title: "Collaboration Request",
      subtitle:
          "Arjun Kumar wants to collaborate on your upcoming short film project.",
      time: "2 min ago",
      icon: Icons.handshake_rounded,
      color1: Color(0xffFF512F),
      color2: Color(0xffDD2476),
      type: NotificationType.collaboration,
    ),
    NotificationItem(
      id: "2",
      title: "New Message",
      subtitle:
          "Sneha Reddy: 'Hey! I reviewed the script. Let's connect over a call?'",
      time: "14 min ago",
      icon: Icons.chat_bubble_rounded,
      color1: Color(0xff396afc),
      color2: Color(0xff2948ff),
      type: NotificationType.message,
    ),
    NotificationItem(
      id: "3",
      title: "5-Star Rating Received",
      subtitle:
          "Rahul Verma gave you a 5-star rating for your work on 'Echoes of Dawn'.",
      time: "1 hr ago",
      icon: Icons.star_rounded,
      color1: Color(0xffF7971E),
      color2: Color(0xffFFD200),
      type: NotificationType.rating,
    ),
    NotificationItem(
      id: "4",
      title: "Project Milestone",
      subtitle:
          "'Urban Lens' project has reached 80% completion. Great progress!",
      time: "3 hr ago",
      icon: Icons.movie_creation_rounded,
      color1: Color(0xff11998e),
      color2: Color(0xff38ef7d),
      type: NotificationType.project,
      isRead: true,
    ),
    NotificationItem(
      id: "5",
      title: "New Crew Member Joined",
      subtitle:
          "Ananya Singh has joined the 'Shadows & Light' project as Lead Actress.",
      time: "5 hr ago",
      icon: Icons.person_add_rounded,
      color1: Color(0xff8E2DE2),
      color2: Color(0xff4A00E0),
      type: NotificationType.project,
      isRead: true,
    ),
    NotificationItem(
      id: "6",
      title: "Profile Viewed",
      subtitle:
          "Kiran Collective and 12 others viewed your profile in the last 24 hours.",
      time: "Yesterday",
      icon: Icons.visibility_rounded,
      color1: Color(0xffFF8C00),
      color2: Color(0xffFF3D00),
      type: NotificationType.system,
      isRead: true,
    ),
    NotificationItem(
      id: "7",
      title: "Deadline Reminder",
      subtitle:
          "Submission deadline for 'City Chronicles' is in 2 days. Stay on track!",
      time: "Yesterday",
      icon: Icons.alarm_rounded,
      color1: Color(0xffDD2476),
      color2: Color(0xffFF512F),
      type: NotificationType.system,
      isRead: true,
    ),
  ];

  List<NotificationItem> get _filtered {
    switch (_filter) {
      case "Unread":
        return _notifications.where((n) => !n.isRead).toList();
      case "Collaborations":
        return _notifications
            .where((n) => n.type == NotificationType.collaboration)
            .toList();
      case "Messages":
        return _notifications
            .where((n) => n.type == NotificationType.message)
            .toList();
      case "Projects":
        return _notifications
            .where((n) => n.type == NotificationType.project)
            .toList();
      default:
        return _notifications;
    }
  }

  int get _unread => _notifications.where((n) => !n.isRead).length;

  @override
  Widget build(BuildContext context) {
    final list = _filtered;
    return Scaffold(
      backgroundColor: const Color(0xff09090B),
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ─────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
              child: Row(
                children: [
                  _backBtn(context),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Notifications",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w800)),
                        if (_unread > 0)
                          Text(
                            "$_unread unread",
                            style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xffFF8C00),
                                fontWeight: FontWeight.w600),
                          ),
                      ],
                    ),
                  ),
                  if (_unread > 0)
                    GestureDetector(
                      onTap: () => setState(() {
                        for (final n in _notifications) {
                          n.isRead = true;
                        }
                      }),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                              colors: [Color(0xffFF8C00), Color(0xffFF3D00)]),
                        ),
                        child: const Text("Mark all read",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w700)),
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ── Filter chips ────────────────────────────────────────────
            SizedBox(
              height: 44,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _filters.length,
                itemBuilder: (_, i) {
                  final f = _filters[i];
                  final active = _filter == f;
                  return GestureDetector(
                    onTap: () => setState(() => _filter = f),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: active
                            ? const LinearGradient(colors: [
                                Color(0xffFF8C00),
                                Color(0xffFF3D00),
                              ])
                            : null,
                        color: active ? null : Colors.white.withOpacity(0.07),
                      ),
                      child: Text(
                        f,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            color: active
                                ? Colors.white
                                : Colors.white.withOpacity(0.65)),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            // ── Notification list ───────────────────────────────────────
            Expanded(
              child: list.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.notifications_off_outlined,
                              size: 56,
                              color: Colors.white.withOpacity(0.15)),
                          const SizedBox(height: 12),
                          Text(
                            "Nothing here",
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.white.withOpacity(0.3),
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 4, 20, 100),
                      physics: const BouncingScrollPhysics(),
                      itemCount: list.length,
                      itemBuilder: (_, i) {
                        final item = list[i];
                        return TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0, end: 1),
                          duration:
                              Duration(milliseconds: 280 + i * 50),
                          curve: Curves.easeOutCubic,
                          builder: (_, v, child) => Opacity(
                            opacity: v,
                            child: Transform.translate(
                              offset: Offset(0, 20 * (1 - v)),
                              child: child,
                            ),
                          ),
                          child: _notifCard(item),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _notifCard(NotificationItem item) {
    return Dismissible(
      key: Key(item.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) =>
          setState(() => _notifications.removeWhere((n) => n.id == item.id)),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.2),
          borderRadius: BorderRadius.circular(22),
        ),
        child: const Icon(Icons.delete_outline_rounded, color: Colors.red),
      ),
      child: GestureDetector(
        onTap: () => setState(() => item.isRead = true),
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: !item.isRead
                ? LinearGradient(colors: [
                    item.color1.withOpacity(0.15),
                    item.color2.withOpacity(0.08),
                  ])
                : null,
            color: item.isRead ? Colors.white.withOpacity(0.04) : null,
            border: Border.all(
              color: !item.isRead
                  ? item.color1.withOpacity(0.3)
                  : Colors.white.withOpacity(0.05),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(colors: [
                      item.color1.withOpacity(0.3),
                      item.color2.withOpacity(0.3),
                    ]),
                  ),
                  child: Icon(item.icon, color: Colors.white, size: 22),
                ),
                const SizedBox(width: 12),

                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.title,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: item.isRead
                                    ? FontWeight.w600
                                    : FontWeight.w800,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (!item.isRead)
                            Container(
                              width: 8,
                              height: 8,
                              margin:
                                  const EdgeInsets.only(left: 6, top: 3),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                    colors: [item.color1, item.color2]),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.subtitle,
                        style: TextStyle(
                            fontSize: 11.5,
                            color: Colors.white.withOpacity(0.55),
                            height: 1.5),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.access_time_rounded,
                              size: 11,
                              color: Colors.white.withOpacity(0.35)),
                          const SizedBox(width: 4),
                          Text(item.time,
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.white.withOpacity(0.35))),
                          const Spacer(),
                          if (item.type ==
                              NotificationType.collaboration) ...[
                            _chip("Accept", item.color1, item.color2),
                            const SizedBox(width: 6),
                            _chip(
                              "Decline",
                              Colors.transparent,
                              Colors.transparent,
                              bordered: true,
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
        ),
      ),
    );
  }

  Widget _chip(String label, Color c1, Color c2, {bool bordered = false}) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: !bordered ? LinearGradient(colors: [c1, c2]) : null,
        color: bordered ? Colors.transparent : null,
        border: bordered
            ? Border.all(color: Colors.white.withOpacity(0.2))
            : null,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: bordered ? Colors.white.withOpacity(0.6) : Colors.white,
        ),
      ),
    );
  }

  Widget _backBtn(BuildContext context) => GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.white.withOpacity(0.06),
          ),
          child: const Icon(Icons.arrow_back_ios_new_rounded, size: 16),
        ),
      );
}
