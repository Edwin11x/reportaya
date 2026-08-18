import 'package:flutter/material.dart';
import '../../domain/entities/report.dart';
import '../../../../core/theme/app_theme.dart';

class ReportCard extends StatelessWidget {
  final Report report;

  const ReportCard({super.key, required this.report});

  Color _statusColor() {
    switch (report.status) {
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

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor();

    return Card(
      margin: const EdgeInsets.fromLTRB(16, 7, 16, 9),
      elevation: 1.2,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 170,
            width: double.infinity,
            child: Image.network(
              report.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Center(
                child: Icon(Icons.image_outlined, size: 55),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: report.iconBackground,
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Icon(report.icon, size: 25),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        report.title,
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                Text(
                  report.description,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    height: 1.35,
                    fontSize: 14.5,
                  ),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.location_on_rounded, size: 19),
                  label: const Text('Abrir Google Maps'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.primary,
                    side: const BorderSide(color: AppTheme.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: .10),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        report.status,
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.5,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      report.date,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
