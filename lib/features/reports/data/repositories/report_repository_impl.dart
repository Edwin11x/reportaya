import 'package:flutter/material.dart';
import '../../domain/entities/report.dart';
import '../../domain/repositories/report_repository.dart';
import '../models/report_model.dart';

class ReportRepositoryImpl implements ReportRepository {
  @override
  List<Report> getReports() {
    return const [
      ReportModel(
        title: 'Bache en la vía principal',
        description: 'Bache grande que dificulta el paso de vehículos en la zona.',
        imageUrl: 'https://images.unsplash.com/photo-1519681393784-d120267933ba?w=900',
        status: 'En proceso',
        date: '17 ago. 2026',
        icon: Icons.signpost_rounded,
        iconBackground: Color(0xFFE8F5E9),
      ),
      ReportModel(
        title: 'Acumulación de basura',
        description: 'Basura acumulada en la calle y cerca de las viviendas.',
        imageUrl: 'https://images.unsplash.com/photo-1532996122724-e3c354a0b15b?w=900',
        status: 'En revisión',
        date: '16 ago. 2026',
        icon: Icons.delete_outline_rounded,
        iconBackground: Color(0xFFE8F5E9),
      ),
      ReportModel(
        title: 'Luminaria dañada',
        description: 'Poste sin iluminación durante la noche en el barrio.',
        imageUrl: 'https://images.unsplash.com/photo-1513506003901-1e6a229e2d15?w=900',
        status: 'Asignado',
        date: '15 ago. 2026',
        icon: Icons.lightbulb_outline_rounded,
        iconBackground: Color(0xFFFFF3CD),
      ),
      ReportModel(
        title: 'Tubería con fuga de agua',
        description: 'Se observa salida constante de agua sobre la calle.',
        imageUrl: 'https://images.unsplash.com/photo-1547683905-f686c993aae5?w=900',
        status: 'Reportado',
        date: '14 ago. 2026',
        icon: Icons.water_drop_outlined,
        iconBackground: Color(0xFFE3F2FD),
      ),
      ReportModel(
        title: 'Árbol caído',
        description: 'Árbol bloqueando parcialmente el paso peatonal.',
        imageUrl: 'https://images.unsplash.com/photo-1513836279014-a89f7a76ae86?w=900',
        status: 'En proceso',
        date: '13 ago. 2026',
        icon: Icons.park_outlined,
        iconBackground: Color(0xFFE8F5E9),
      ),
      ReportModel(
        title: 'Alcantarilla deteriorada',
        description: 'Tapa de alcantarilla dañada cerca de una esquina.',
        imageUrl: 'https://images.unsplash.com/photo-1519501025264-65ba15a82390?w=900',
        status: 'Resuelto',
        date: '12 ago. 2026',
        icon: Icons.warning_amber_rounded,
        iconBackground: Color(0xFFFFF3CD),
      ),
    ];
  }
}
