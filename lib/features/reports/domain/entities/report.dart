import 'package:flutter/material.dart';

class Report {
  final String title;
  final String description;
  final String imageUrl;
  final String status;
  final String date;
  final IconData icon;
  final Color iconBackground;
  final double latitude;
  final double longitude;
  final String category;

  const Report({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.status,
    required this.date,
    required this.icon,
    required this.iconBackground,
    required this.latitude,
    required this.longitude,
    required this.category,
  });
}
