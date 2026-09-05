import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../domain/entities/report.dart';
import '../../../../core/theme/app_theme.dart';

class MapPage extends StatelessWidget {
  final List<Report> reports;

  const MapPage({super.key, required this.reports});

  Color _statusColor(String status) {
    switch (status) {
      case 'Resuelto':
        return const Color(0xFF168A47);
      case 'En proceso':
        return const Color(0xFFED8A00);
      case 'En revisión':
        return const Color(0xFF3F78C5);
      case 'Asignado':
        return const Color(0xFFB27A00);
      default:
        return const Color(0xFF707070);
    }
  }

  void _showReport(BuildContext context, Report report) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: _statusColor(report.status).withValues(alpha: .10),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      report.status,
                      style: TextStyle(
                        color: _statusColor(report.status),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(report.category, style: TextStyle(color: Colors.grey.shade600)),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                report.title,
                style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 6),
              Text(
                report.description,
                style: TextStyle(color: Colors.grey.shade700, height: 1.35),
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F7F6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.location_on_rounded, color: AppTheme.primary),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '${report.latitude.toStringAsFixed(5)}, ${report.longitude.toStringAsFixed(5)}',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const somoto = LatLng(13.485, -86.582);

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F7EE),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(Icons.map_rounded, color: AppTheme.primary, size: 25),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Mapa de reportes',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
              child: FlutterMap(
                options: const MapOptions(
                  initialCenter: somoto,
                  initialZoom: 14.5,
                  minZoom: 12,
                  maxZoom: 18,
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.reportaya.somoto',
                  ),
                  MarkerLayer(
                    markers: reports
                        .map(
                          (report) => Marker(
                            point: LatLng(report.latitude, report.longitude),
                            width: 48,
                            height: 48,
                            child: GestureDetector(
                              onTap: () => _showReport(context, report),
                              child: Icon(
                                Icons.location_on_rounded,
                                size: 44,
                                color: _statusColor(report.status),
                                shadows: const [
                                  Shadow(blurRadius: 3, offset: Offset(0, 2)),
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  RichAttributionWidget(
                    attributions: [
                      TextSourceAttribution('OpenStreetMap contributors'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
