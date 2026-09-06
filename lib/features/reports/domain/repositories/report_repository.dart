import 'dart:io';

import '../entities/report.dart';

abstract class ReportRepository {
  List<Report> getReports();

  Future<List<Report>> getReportsFromSupabase();

  Future<void> createReport({
    required String title,
    required String description,
    required String categoryId,
    required double latitude,
    required double longitude,
    String? photoUrl,
    File? photoFile,
  });
}