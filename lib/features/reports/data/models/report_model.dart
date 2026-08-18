import 'package:flutter/material.dart';
import '../../domain/entities/report.dart';

class ReportModel extends Report {
  const ReportModel({
    required super.title,
    required super.description,
    required super.imageUrl,
    required super.status,
    required super.date,
    required super.icon,
    required super.iconBackground,
  });
}
