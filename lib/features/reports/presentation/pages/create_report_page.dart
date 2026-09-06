import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/theme/app_theme.dart';
import '../../data/repositories/report_repository_impl.dart';

class CreateReportPage extends StatefulWidget {
  const CreateReportPage({super.key});

  @override
  State<CreateReportPage> createState() => _CreateReportPageState();
}

class _CreateReportPageState extends State<CreateReportPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  final _repository = ReportRepositoryImpl();
  final ImagePicker _picker = ImagePicker();

  List<Map<String, dynamic>> _categories = [];
  String? _selectedCategoryId;

  double? _latitude;
  double? _longitude;

  File? _photo;

  bool _loadingCategories = true;
  bool _gettingLocation = false;
  bool _takingPhoto = false;
  bool _sending = false;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // ============================================================
  // CARGAR CATEGORÍAS
  // ============================================================

  Future<void> _loadCategories() async {
    try {
      final response = await Supabase.instance.client
          .from('categories')
          .select('id, name')
          .order('name');

      if (!mounted) return;

      setState(() {
        _categories = List<Map<String, dynamic>>.from(response);
        _loadingCategories = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _loadingCategories = false;
      });

      _showMessage(
        'No se pudieron cargar las categorías: $e',
      );
    }
  }

  // ============================================================
  // OBTENER UBICACIÓN GPS
  // ============================================================

  Future<void> _getLocation() async {
    setState(() {
      _gettingLocation = true;
    });

    try {
      final serviceEnabled =
      await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        _showMessage(
          'Activa la ubicación del teléfono para continuar.',
        );
        return;
      }

      LocationPermission permission =
      await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied) {
          _showMessage(
            'Se necesita permiso para acceder a la ubicación.',
          );
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _showMessage(
          'El permiso de ubicación está bloqueado. '
              'Actívalo desde los ajustes del teléfono.',
        );
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      if (!mounted) return;

      setState(() {
        _latitude = position.latitude;
        _longitude = position.longitude;
      });

      _showMessage(
        'Ubicación obtenida correctamente.',
      );
    } catch (e) {
      if (!mounted) return;

      _showMessage(
        'No se pudo obtener la ubicación: $e',
      );
    } finally {
      if (mounted) {
        setState(() {
          _gettingLocation = false;
        });
      }
    }
  }

  // ============================================================
  // TOMAR FOTO CON LA CÁMARA
  // ============================================================

  Future<void> _takePhoto() async {
    setState(() {
      _takingPhoto = true;
    });

    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
      );

      if (image == null) {
        return;
      }

      if (!mounted) return;

      setState(() {
        _photo = File(image.path);
      });

      _showMessage(
        'Foto tomada correctamente.',
      );
    } catch (e) {
      if (!mounted) return;

      _showMessage(
        'No se pudo abrir la cámara: $e',
      );
    } finally {
      if (mounted) {
        setState(() {
          _takingPhoto = false;
        });
      }
    }
  }

  // ============================================================
  // ENVIAR REPORTE
  // ============================================================

  Future<void> _sendReport() async {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    if (title.isEmpty) {
      _showMessage(
        'Escribe un título para el reporte.',
      );
      return;
    }

    if (description.isEmpty) {
      _showMessage(
        'Escribe una descripción.',
      );
      return;
    }

    if (_selectedCategoryId == null) {
      _showMessage(
        'Selecciona una categoría.',
      );
      return;
    }

    if (_latitude == null || _longitude == null) {
      _showMessage(
        'Obtén tu ubicación antes de enviar el reporte.',
      );
      return;
    }

    if (_photo == null) {
      _showMessage(
        'Toma una foto del problema antes de enviar el reporte.',
      );
      return;
    }

    setState(() {
      _sending = true;
    });

    try {
      await _repository.createReport(
        title: title,
        description: description,
        categoryId: _selectedCategoryId!,
        latitude: _latitude!,
        longitude: _longitude!,
        photoUrl: null,
        photoFile: _photo,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Reporte enviado correctamente.',
          ),
        ),
      );

      Navigator.of(context).pop();
    } catch (e) {
      if (!mounted) return;

      _showMessage(
        'No se pudo enviar el reporte: $e',
      );
    } finally {
      if (mounted) {
        setState(() {
          _sending = false;
        });
      }
    }
  }

  // ============================================================
  // MENSAJES
  // ============================================================

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  // ============================================================
  // INTERFAZ
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Añadir reporte',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            20,
            8,
            20,
            24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ==================================================
              // TÍTULO
              // ==================================================

              const _Label('Título'),

              const SizedBox(height: 8),

              TextField(
                controller: _titleController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  hintText:
                  'Ej. Bache en la calle principal',
                ),
              ),

              const SizedBox(height: 20),

              // ==================================================
              // DESCRIPCIÓN
              // ==================================================

              const _Label('Breve descripción'),

              const SizedBox(height: 8),

              TextField(
                controller: _descriptionController,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText:
                  'Describe brevemente el problema...',
                  alignLabelWithHint: true,
                ),
              ),

              const SizedBox(height: 22),

              // ==================================================
              // CATEGORÍA
              // ==================================================

              const _Label('Categoría'),

              const SizedBox(height: 8),

              _loadingCategories
                  ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: CircularProgressIndicator(),
                ),
              )
                  : DropdownButtonFormField<String>(
                initialValue: _selectedCategoryId,
                decoration: const InputDecoration(
                  hintText:
                  'Selecciona una categoría',
                ),
                items: _categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category['id'] as String,
                    child: Text(
                      category['name'] as String,
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategoryId = value;
                  });
                },
              ),

              const SizedBox(height: 22),

              // ==================================================
              // UBICACIÓN
              // ==================================================

              const _Label('Ubicación del punto'),

              const SizedBox(height: 8),

              SizedBox(
                width: double.infinity,
                height: 58,
                child: OutlinedButton.icon(
                  onPressed:
                  _gettingLocation
                      ? null
                      : _getLocation,
                  icon: _gettingLocation
                      ? const SizedBox(
                    width: 20,
                    height: 20,
                    child:
                    CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                      : Icon(
                    _latitude == null
                        ? Icons.location_on_rounded
                        : Icons.check_circle_rounded,
                  ),
                  label: Text(
                    _gettingLocation
                        ? 'Obteniendo ubicación...'
                        : _latitude == null
                        ? 'Añadir coordenadas'
                        : 'Ubicación obtenida',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor:
                    AppTheme.primary,
                    side: const BorderSide(
                      color: AppTheme.primary,
                      width: 1.5,
                    ),
                    shape:
                    RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              Center(
                child: Text(
                  _latitude == null
                      ? 'Presiona el botón para obtener '
                      'tu ubicación actual.'
                      : 'Lat: ${_latitude!.toStringAsFixed(6)}  '
                      'Lon: ${_longitude!.toStringAsFixed(6)}',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 24),

              const Divider(),

              const SizedBox(height: 20),

              // ==================================================
              // FOTO
              // ==================================================

              const _Label('Foto del problema'),

              const SizedBox(height: 8),

              GestureDetector(
                onTap: _takingPhoto
                    ? null
                    : _takePhoto,
                child: Container(
                  width: double.infinity,
                  height: 220,
                  decoration: BoxDecoration(
                    color:
                    const Color(0xFFF0F8F3),
                    borderRadius:
                    BorderRadius.circular(18),
                    border: Border.all(
                      color:
                      const Color(0xFFD6EBDD),
                    ),
                  ),
                  child: _photo == null
                      ? Column(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [

                      _takingPhoto
                          ? const SizedBox(
                        width: 42,
                        height: 42,
                        child:
                        CircularProgressIndicator(),
                      )
                          : const Icon(
                        Icons
                            .camera_alt_rounded,
                        color:
                        AppTheme.primary,
                        size: 48,
                      ),

                      const SizedBox(height: 10),

                      Text(
                        _takingPhoto
                            ? 'Abriendo cámara...'
                            : 'Tomar foto',
                        style:
                        const TextStyle(
                          fontSize: 18,
                          fontWeight:
                          FontWeight.w800,
                        ),
                      ),

                      const SizedBox(height: 6),

                      const Text(
                        'La fotografía se tomará '
                            'en el momento.',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),

                      const Text(
                        'No se puede seleccionar '
                            'desde la galería.',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  )
                      : ClipRRect(
                    borderRadius:
                    BorderRadius.circular(17),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [

                        Image.file(
                          _photo!,
                          fit: BoxFit.cover,
                        ),

                        Positioned(
                          right: 12,
                          bottom: 12,
                          child: Container(
                            decoration:
                            BoxDecoration(
                              color:
                              Colors.black54,
                              borderRadius:
                              BorderRadius
                                  .circular(12),
                            ),
                            child: IconButton(
                              onPressed:
                              _takingPhoto
                                  ? null
                                  : _takePhoto,
                              icon: const Icon(
                                Icons
                                    .camera_alt_rounded,
                                color:
                                Colors.white,
                              ),
                              tooltip:
                              'Tomar otra foto',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              Center(
                child: Text(
                  _photo == null
                      ? 'Toca el recuadro para abrir la cámara.'
                      : 'Foto tomada. Puedes tocarla para tomar otra.',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 24),

              // ==================================================
              // ENVIAR
              // ==================================================

              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton.icon(
                  onPressed:
                  _sending
                      ? null
                      : _sendReport,
                  icon: _sending
                      ? const SizedBox(
                    width: 20,
                    height: 20,
                    child:
                    CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                      : const Icon(
                    Icons.send_rounded,
                  ),
                  label: Text(
                    _sending
                        ? 'Enviando...'
                        : 'Enviar reporte',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight:
                      FontWeight.w800,
                    ),
                  ),
                  style:
                  FilledButton.styleFrom(
                    backgroundColor:
                    AppTheme.primary,
                    shape:
                    RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(16),
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

// ================================================================
// ETIQUETA DE LOS CAMPOS
// ================================================================

class _Label extends StatelessWidget {
  final String text;

  const _Label(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}