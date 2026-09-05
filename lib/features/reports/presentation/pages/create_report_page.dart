import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class CreateReportPage extends StatelessWidget {
  const CreateReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Añadir reporte',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _Label('Título'),
              const SizedBox(height: 8),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Ej. Bache en la calle principal',
                ),
              ),
              const SizedBox(height: 20),
              const _Label('Breve descripción'),
              const SizedBox(height: 8),
              const TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Describe brevemente el problema...',
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 22),
              const _Label('Ubicación del punto'),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                height: 58,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.location_on_rounded),
                  label: const Text(
                    'Añadir coordenadas',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.primary,
                    side: const BorderSide(color: AppTheme.primary, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  'Selecciona el punto donde ocurre el problema',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12.5),
                ),
              ),
              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 20),
              const _Label('Foto del problema'),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                height: 190,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F8F3),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFFD6EBDD)),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt_rounded, color: AppTheme.primary, size: 48),
                    SizedBox(height: 10),
                    Text(
                      'Tomar foto',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'La fotografía se tomará en el momento.',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      'No se puede seleccionar desde la galería.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.send_rounded),
                  label: const Text(
                    'Enviar reporte',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  final String text;
  const _Label(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
    );
  }
}
