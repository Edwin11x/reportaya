import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/report.dart';

class ReportCard extends StatelessWidget {
  final Report report;

  const ReportCard({
    super.key,
    required this.report,
  });

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

      case 'Rechazado':
        return const Color(0xFFD32F2F);

      case 'Reportado':
      default:
        return const Color(0xFF707070);
    }
  }

  Future<void> _openGoogleMaps() async {
    final latitude = report.latitude;
    final longitude = report.longitude;

    // Intentar abrir la aplicación Google Maps.
    final googleMapsUri = Uri.parse(
      'geo:$latitude,$longitude?q=$latitude,$longitude',
    );

    try {
      final opened = await launchUrl(
        googleMapsUri,
        mode: LaunchMode.externalApplication,
      );

      if (opened) {
        return;
      }
    } catch (_) {
      // Si falla, usamos la versión web.
    }

    // Abrir Google Maps mediante navegador.
    final webUri = Uri.parse(
      'https://www.google.com/maps/search/?api=1'
          '&query=$latitude,$longitude',
    );

    try {
      await launchUrl(
        webUri,
        mode: LaunchMode.externalApplication,
      );
    } catch (_) {
      // No se pudo abrir Google Maps.
    }
  }

  Widget _buildImage() {
    if (report.imageUrl.trim().isEmpty) {
      return Container(
        color: const Color(0xFFF0F4F2),
        child: const Center(
          child: Icon(
            Icons.image_not_supported_outlined,
            size: 40,
            color: Colors.grey,
          ),
        ),
      );
    }

    return Image.network(
      report.imageUrl,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
      loadingBuilder: (
          context,
          child,
          loadingProgress,
          ) {
        if (loadingProgress == null) {
          return child;
        }

        return Container(
          color: const Color(0xFFF0F4F2),
          child: const Center(
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
              ),
            ),
          ),
        );
      },
      errorBuilder: (
          context,
          error,
          stackTrace,
          ) {
        return Container(
          color: const Color(0xFFF0F4F2),
          child: const Center(
            child: Icon(
              Icons.broken_image_outlined,
              size: 40,
              color: Colors.grey,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor();

    return Card(
      margin: const EdgeInsets.fromLTRB(
        16,
        7,
        16,
        9,
      ),
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        height: 210,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            // =====================================================
            // FOTO
            // =====================================================

            SizedBox(
              width: 125,
              child: _buildImage(),
            ),

            // =====================================================
            // INFORMACIÓN
            // =====================================================

            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  14,
                  14,
                  14,
                  12,
                ),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [

                    // =============================================
                    // ICONO + ESTADO
                    // =============================================

                    Row(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [

                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: report.iconBackground,
                            borderRadius:
                            BorderRadius.circular(12),
                          ),
                          child: Icon(
                            report.icon,
                            size: 23,
                          ),
                        ),

                        const Spacer(),

                        Container(
                          padding:
                          const EdgeInsets.symmetric(
                            horizontal: 9,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withValues(
                              alpha: .10,
                            ),
                            borderRadius:
                            BorderRadius.circular(20),
                          ),
                          child: Text(
                            report.status,
                            style: TextStyle(
                              color: statusColor,
                              fontWeight:
                              FontWeight.w700,
                              fontSize: 11.5,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // =============================================
                    // TÍTULO
                    // =============================================

                    Text(
                      report.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        height: 1.15,
                      ),
                    ),

                    const SizedBox(height: 5),

                    // =============================================
                    // FECHA
                    // =============================================

                    Text(
                      report.date,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // =============================================
                    // DESCRIPCIÓN
                    // =============================================

                    Expanded(
                      child: Text(
                        report.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          height: 1.3,
                          fontSize: 13.5,
                        ),
                      ),
                    ),

                    const SizedBox(height: 6),

                    // =============================================
                    // GOOGLE MAPS
                    // =============================================

                    InkWell(
                      onTap: _openGoogleMaps,
                      borderRadius:
                      BorderRadius.circular(10),
                      child: Padding(
                        padding:
                        const EdgeInsets.symmetric(
                          vertical: 5,
                        ),
                        child: Row(
                          mainAxisSize:
                          MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.location_on_rounded,
                              color: AppTheme.primary,
                              size: 19,
                            ),
                            const SizedBox(width: 5),
                            Flexible(
                              child: Text(
                                'Abrir Google Maps',
                                overflow:
                                TextOverflow.ellipsis,
                                style: TextStyle(
                                  color:
                                  AppTheme.primary,
                                  fontWeight:
                                  FontWeight.w700,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}