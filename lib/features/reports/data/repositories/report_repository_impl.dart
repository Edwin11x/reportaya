import 'dart:io';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/report.dart';
import '../../domain/repositories/report_repository.dart';
import '../models/report_model.dart';

class ReportRepositoryImpl implements ReportRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  @override
  List<Report> getReports() {
    return const [];
  }

  @override
  Future<List<Report>> getReportsFromSupabase() async {
    final response = await _supabase
        .from('reports')
        .select('''
          id,
          title,
          description,
          latitude,
          longitude,
          photo_url,
          status,
          created_at,
          categories (
            name
          ),
          institutions (
            name
          )
        ''')
        .order('created_at', ascending: false);

    final data = response as List;

    return data.map((item) {
      final categoryData = item['categories'];

      final category = categoryData != null
          ? categoryData['name'] as String
          : 'Otros';

      final status = _formatStatus(
        item['status'] as String? ?? 'reportado',
      );

      final date = _formatDate(
        item['created_at'] as String?,
      );

      return ReportModel(
        title: item['title'] as String,
        description: item['description'] as String,
        imageUrl: (item['photo_url'] as String?) ?? '',
        status: status,
        date: date,
        icon: _getCategoryIcon(category),
        iconBackground: _getCategoryBackground(category),
        latitude: (item['latitude'] as num).toDouble(),
        longitude: (item['longitude'] as num).toDouble(),
        category: category,
      );
    }).toList();
  }

  // ============================================================
  // CREAR REPORTE + SUBIR FOTO
  // ============================================================

  @override
  Future<void> createReport({
    required String title,
    required String description,
    required String categoryId,
    required double latitude,
    required double longitude,
    String? photoUrl,
    File? photoFile,
  }) async {
    String? finalPhotoUrl;

    // ==========================================================
    // 1. CREAR NOMBRE ÚNICO PARA LA FOTO
    // ==========================================================

    if (photoFile != null) {
      final fileName =
          '${DateTime.now().microsecondsSinceEpoch}.jpg';

      final filePath = 'reports/$fileName';

      // ========================================================
      // 2. SUBIR FOTO A SUPABASE STORAGE
      // ========================================================

      await _supabase.storage
          .from('report-images')
          .upload(
        filePath,
        photoFile,
        fileOptions: const FileOptions(
          contentType: 'image/jpeg',
          upsert: false,
        ),
      );

      // ========================================================
      // 3. OBTENER URL PÚBLICA
      // ========================================================

      finalPhotoUrl = _supabase.storage
          .from('report-images')
          .getPublicUrl(filePath);
    }

    // ==========================================================
    // 4. GUARDAR REPORTE EN SUPABASE
    // ==========================================================

    await _supabase.from('reports').insert({
      'title': title,
      'description': description,
      'category_id': categoryId,
      'latitude': latitude,
      'longitude': longitude,
      'photo_url': finalPhotoUrl ?? photoUrl,
      'status': 'reportado',
    });
  }

  // ============================================================
  // ESTADO
  // ============================================================

  String _formatStatus(String status) {
    switch (status) {
      case 'reportado':
        return 'Reportado';
      case 'en_revision':
        return 'En revisión';
      case 'asignado':
        return 'Asignado';
      case 'en_proceso':
        return 'En proceso';
      case 'resuelto':
        return 'Resuelto';
      case 'rechazado':
        return 'Rechazado';
      default:
        return status;
    }
  }

  // ============================================================
  // FECHA
  // ============================================================

  String _formatDate(String? dateString) {
    if (dateString == null) {
      return '';
    }

    final date = DateTime.tryParse(dateString);

    if (date == null) {
      return '';
    }

    const months = [
      'ene.',
      'feb.',
      'mar.',
      'abr.',
      'may.',
      'jun.',
      'jul.',
      'ago.',
      'sep.',
      'oct.',
      'nov.',
      'dic.',
    ];

    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  // ============================================================
  // ICONO DE CATEGORÍA
  // ============================================================

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Baches':
        return Icons.signpost_rounded;

      case 'Basura':
        return Icons.delete_outline_rounded;

      case 'Alumbrado público':
        return Icons.lightbulb_outline_rounded;

      case 'Agua potable':
        return Icons.water_drop_outlined;

      case 'Alcantarillado':
        return Icons.warning_amber_rounded;

      case 'Árboles':
        return Icons.park_outlined;

      default:
        return Icons.report_problem_outlined;
    }
  }

  // ============================================================
  // FONDO DE CATEGORÍA
  // ============================================================

  Color _getCategoryBackground(String category) {
    switch (category) {
      case 'Agua potable':
        return const Color(0xFFE3F2FD);

      case 'Alumbrado público':
      case 'Alcantarillado':
        return const Color(0xFFFFF3CD);

      default:
        return const Color(0xFFE8F5E9);
    }
  }
}