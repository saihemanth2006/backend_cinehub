import 'package:flutter/material.dart';

enum NotificationType { collaboration, message, rating, system, project }

class NotificationItem {
  final String id;
  final String title;
  final String subtitle;
  final String time;
  final IconData icon;
  final Color color1;
  final Color color2;
  final NotificationType type;
  bool isRead;

  NotificationItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.icon,
    required this.color1,
    required this.color2,
    required this.type,
    this.isRead = false,
  });
}
