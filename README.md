# REPORTAYA README TÉCNICO – DOCUMENTACIÓN DEL PROYECTO

# 

# 1\.  INFORMACIÓN GENERAL Nombre: ReportaYA Descripción: Plataforma para

# &#x20;   facilitar el reporte y seguimiento de incidencias ciudadanas. La

# &#x20;   solución está compuesta por una aplicación móvil ciudadana y una

# &#x20;   aplicación móvil institucional conectadas al mismo backend.

# &#x20;   Ubicación objetivo: Somoto, Nicaragua.

# 

# 2\.  OBJETIVO

# 

# \-   Registrar incidencias.

# \-   Adjuntar evidencia fotográfica.

# \-   Registrar ubicación geográfica.

# \-   Clasificar reportes por categorías.

# \-   Consultar reportes.

# \-   Visualizar reportes en mapa.

# \-   Dar seguimiento al estado.

# \-   Gestionar reportes institucionalmente.

# \-   Registrar historial de cambios.

# 

# 3\.  APLICACIÓN CIUDADANA Proyecto: C: Funciones:

# 

# \-   Visualización y creación de reportes.

# \-   Captura de fotografía mediante cámara.

# \-   GPS.

# \-   Categorías.

# \-   Título y descripción.

# \-   Supabase Storage.

# \-   Mapa con OpenStreetMap.

# \-   Google Maps.

# \-   Estados.

# \-   Actualización de la lista.

# \-   Splash Screen.

# \-   Logo.

# \-   Icono.

# 

# 4\.  APLICACIÓN INSTITUCIONAL Proyecto: C:\_institucional Funciones:

# 

# \-   Inicio de sesión institucional.

# \-   Validación de pertenencia a institución.

# \-   Gestión de sesión.

# \-   Dashboard.

# \-   Estadísticas.

# \-   Consulta y gestión de reportes.

# \-   Estados.

# \-   Historial.

# \-   Perfil.

# 

# 5\.  TECNOLOGÍAS Frontend: Flutter, Dart, Material 3, Riverpod. Backend:

# &#x20;   Supabase, PostgreSQL, Supabase Authentication, Supabase Storage,

# &#x20;   RLS. Paquetes: flutter\_riverpod, flutter\_map, latlong2,

# &#x20;   supabase\_flutter, geolocator, image\_picker, url\_launcher. Control de

# &#x20;   versiones: Git y GitHub.

# 

# 6\.  ARQUITECTURA Clean Architecture:

# 

# \-   Presentation

# \-   Domain

# \-   Data

# 

# Flujo: Ciudadano -> App Ciudadana -> Supabase -> App Institucional ->

# Institución.

# 

# 7\.  ESTRUCTURA CIUDADANA lib/ core/ constants/ pages/ theme/ features/

# &#x20;   reports/ data/ models/ repositories/ domain/ entities/ repositories/

# &#x20;   presentation/ pages/ widgets/

# 

# 8\.  ESTRUCTURA INSTITUCIONAL lib/ core/ constants/ theme/ features/

# &#x20;   auth/ data/ domain/ presentation/ dashboard/ presentation/ reports/

# &#x20;   data/ domain/ presentation/ profile/ presentation/

# 

# 9\.  BASE DE DATOS PostgreSQL mediante Supabase. Tablas:

# 

# \-   profiles

# \-   categories

# \-   institutions

# \-   institution\_members

# \-   reports

# \-   report\_status\_history

# 

# 10\. CATEGORÍAS

# 

# \-   Baches

# \-   Basura

# \-   Alumbrado público

# \-   Agua potable

# \-   Alcantarillado

# \-   Árboles

# \-   Otros

# 

# 11\. REPORTES Campos principales:

# 

# \-   id

# \-   title

# \-   description

# \-   category\_id

# \-   latitude

# \-   longitude

# \-   photo\_url

# \-   status

# \-   user\_id

# \-   institution\_id

# \-   created\_at

# \-   updated\_at

# 

# 12\. ESTADOS

# 

# \-   reportado

# \-   en\_revision

# \-   asignado

# \-   en\_proceso

# \-   resuelto

# \-   rechazado

# 

# Flujo principal: REPORTADO -> EN REVISIÓN -> ASIGNADO -> EN PROCESO ->

# RESUELTO También: EN REVISIÓN -> RECHAZADO.

# 

# 13\. HISTORIAL report\_status\_history registra:

# 

# \-   reporte

# \-   estado anterior

# \-   estado nuevo

# \-   institución

# \-   usuario

# \-   comentario

# \-   fecha Los cambios se registran mediante un trigger de PostgreSQL.

# 

# 14\. NORMALIZACIÓN 3FN Documentar:

# 

# \-   Entidades.

# \-   Claves primarias.

# \-   Claves foráneas.

# \-   Relaciones.

# \-   Eliminación de datos repetidos.

# \-   Dependencias funcionales.

# \-   Justificación de la Tercera Forma Normal.

# 

# 15\. UML Y DIAGRAMAS Entregar:

# 

# \-   Diagrama de arquitectura.

# \-   Diagrama entidad-relación.

# \-   UML de entidades.

# \-   Flujo de creación de reportes.

# \-   Flujo de gestión institucional.

# \-   Flujo de estados.

# 

# 16\. AUTENTICACIÓN Proceso institucional:

# 

# 17\. Usuario introduce correo y contraseña.

# 

# 18\. Supabase verifica credenciales.

# 

# 19\. Se obtiene usuario autenticado.

# 

# 20\. Se consulta institution\_members.

# 

# 21\. Se verifica pertenencia institucional.

# 

# 22\. Se obtiene institución y rol.

# 

# 23\. Se permite el acceso.

# 

# 24\. SEGURIDAD

# 

# \-   Supabase Authentication.

# \-   Row Level Security.

# \-   Control de acceso institucional.

# \-   Restricción por usuario.

# \-   Restricción por institución.

# \-   Claves foráneas.

# \-   Validación de formularios.

# \-   Roles admin y gestor.

# \-   Protección de operaciones institucionales.

# \-   No utilizar service\_role en la aplicación móvil.

# 

# 18\. STORAGE Bucket: report-images Proceso:

# 

# 19\. Capturar fotografía.

# 

# 20\. Obtener archivo.

# 

# 21\. Subir a Storage.

# 

# 22\. Obtener URL.

# 

# 23\. Guardar URL en reports.photo\_url.

# 

# 24\. GEOLOCALIZACIÓN Se obtienen latitude y longitude mediante GPS. La

# &#x20;   ubicación se guarda junto con el reporte y puede abrirse en Google

# &#x20;   Maps.

# 

# 25\. MAPA

# 

# \-   flutter\_map

# \-   OpenStreetMap

# \-   latlong2 Los reportes se representan mediante marcadores.

# 

# 21\. VALIDACIONES Ciudadano:

# 

# \-   título obligatorio

# \-   descripción obligatoria

# \-   categoría obligatoria

# \-   fotografía obligatoria

# \-   ubicación obligatoria

# 

# Institucional: - correo obligatorio - formato de correo válido -

# contraseña obligatoria

# 

# También documentar manejo de errores de conexión, autenticación y base

# de datos.

# 

# 22\. CONTROL DE VERSIONES Repositorio ciudadano:

# &#x20;   https://github.com/Edwin11x/reportaya

# 

# Repositorio institucional:

# https://github.com/Edwin11x/reportaya-institucional

# 

# Buenas prácticas: - commits descriptivos - ramas cuando corresponda -

# Pull Requests - revisión de cambios - trazabilidad - evitar archivos

# innecesarios

# 

# 23\. PRUEBAS Ciudadano:

# 

# \-   inicio

# \-   formulario

# \-   validaciones

# \-   cámara

# \-   GPS

# \-   categorías

# \-   creación

# \-   fotografía

# \-   mapa

# \-   Google Maps

# 

# Institucional: - login correcto - login incorrecto - usuario sin

# permisos - dashboard - reportes - cambio de estado - historial - cierre

# de sesión

# 

# 24\. ANÁLISIS flutter pub get flutter analyze flutter run

# 

# 25\. PRODUCCIÓN flutter clean flutter pub get flutter analyze flutter

# &#x20;   build apk –release

# 

# APK: build/app/outputs/flutter-apk/app-release.apk

# 

# 26\. EVIDENCIAS Capturas de:

# 

# \-   Splash.

# \-   Pantalla principal.

# \-   Crear reporte.

# \-   Validaciones.

# \-   Cámara.

# \-   GPS.

# \-   Categorías.

# \-   Reporte creado.

# \-   Mapa.

# \-   Google Maps.

# \-   Login institucional.

# \-   Dashboard.

# \-   Reporte institucional.

# \-   Cambio de estado.

# \-   Historial.

# \-   Supabase.

# \-   Tablas.

# \-   Relaciones.

# \-   RLS.

# \-   Storage.

# \-   GitHub.

# \-   Commits.

# 

# 27\. VIDEO DEMO Orden recomendado:

# 

# 28\. Presentación de ReportaYA.

# 

# 29\. Abrir app ciudadana.

# 

# 30\. Mostrar Splash.

# 

# 31\. Crear reporte.

# 

# 32\. Capturar fotografía.

# 

# 33\. Obtener GPS.

# 

# 34\. Seleccionar categoría.

# 

# 35\. Enviar.

# 

# 36\. Mostrar reporte.

# 

# 37\. Mostrar mapa.

# 

# 38\. Abrir Google Maps.

# 

# 39\. Abrir app institucional.

# 

# 40\. Iniciar sesión.

# 

# 41\. Mostrar dashboard.

# 

# 42\. Consultar reporte.

# 

# 43\. Cambiar estado.

# 

# 44\. Mostrar historial.

# 

# 45\. CRITERIO AVANZADO – DESARROLLO Preparar evidencia para:

# 

# \-   README técnico completo.

# \-   Arquitectura.

# \-   Dependencias.

# \-   Variables/configuración.

# \-   Scripts.

# \-   Endpoints/servicios.

# \-   Base de datos en 3FN.

# \-   UML.

# \-   CRUD.

# \-   Interfaces y formularios.

# \-   Validaciones.

# \-   Control de versiones profesional.

# \-   Seguridad y buenas prácticas.

# \-   Ejecución y despliegue.

# 

# 29\. ESTADO Implementado:

# 

# \-   Supabase.

# \-   Base de datos.

# \-   Categorías.

# \-   Instituciones.

# \-   Perfiles.

# \-   Reportes.

# \-   Historial.

# \-   Autenticación institucional.

# \-   RLS inicial.

# \-   Storage.

# \-   Fotografías.

# \-   GPS.

# \-   Mapa.

# \-   Google Maps.

# \-   Dashboard.

# \-   GitHub.

# 

# Pendiente/en desarrollo: - Completar Splash y navegación. - Icono

# definitivo. - Logo dentro de la app. - CRUD institucional completo. -

# Filtros. - Detalle institucional. - Validaciones finales. - Pruebas

# completas. - Documentación 3FN. - Diagramas. - Capturas. - Video demo. -

# Revisión final de seguridad. - Preparación final para producción.

# 

# 30\. REGLA DE DOCUMENTACIÓN No marcar un requisito como implementado

# &#x20;   hasta probarlo. Cada requisito importante debe tener:

# 

# \-   implementación

# \-   prueba

# \-   captura

# \-   documentación

# 

# NOTA: El documento de la Hackathon indica para Desarrollo – Avanzado la

# necesidad de README técnico completo, base de datos en 3FN/UML/CRUD,

# interfaces y validaciones, control de versiones profesional, seguridad y

# ejecución de la solución.



