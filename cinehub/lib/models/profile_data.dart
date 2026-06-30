import 'package:flutter/material.dart';

class ProfileData {
  final String id;
  final String name;
  final String role;
  final String type;
  final String location;
  final Color color1;
  final Color color2;
  final List<String> skills;
  final IconData icon;
  final double rating;
  final int projects;
  final int followers;
  final String bio;
  final bool isVerified;
  final String availability;

  const ProfileData({
    this.id = '',
    required this.name,
    required this.role,
    required this.type,
    required this.location,
    required this.color1,
    required this.color2,
    required this.skills,
    required this.icon,
    this.rating = 4.5,
    this.projects = 12,
    this.followers = 320,
    this.bio = '',
    this.isVerified = false,
    this.availability = 'Open',
  });
}
