# ReportaYA

## README Técnico – Documentación del Proyecto

## 1. Información general

**Nombre:** ReportaYA

**Descripción:**  
ReportaYA es una plataforma para facilitar el reporte y seguimiento de incidencias ciudadanas. La solución está compuesta por una aplicación móvil ciudadana y una aplicación móvil institucional conectadas al mismo backend.

**Ubicación objetivo:** Somoto, Nicaragua.

---

## 2. Objetivo

El sistema permite:

- Registrar incidencias ciudadanas.
- Adjuntar evidencia fotográfica.
- Registrar la ubicación geográfica mediante GPS.
- Clasificar reportes por categorías.
- Consultar reportes.
- Visualizar reportes en un mapa.
- Dar seguimiento al estado de los reportes.
- Gestionar reportes desde la aplicación institucional.
- Registrar el historial de cambios de estado.

---

## 3. Aplicación ciudadana

**Proyecto:**

```text
C:\Users\Edwin\Desktop\ReporteYA\ReportaYA
Funciones principales
Visualización de reportes.
Creación de reportes.
Captura de fotografías mediante la cámara.
Obtención de ubicación mediante GPS.
Selección de categorías.
Registro de título y descripción.
Subida de fotografías a Supabase Storage.
Visualización de reportes en mapa.
Apertura de ubicaciones mediante Google Maps.
Visualización del estado de los reportes.
Actualización automática de la lista después de crear un reporte.
Splash Screen.
Identidad visual mediante logotipo.
Icono de aplicación.
4. Aplicación institucional

Proyecto:

C:\Users\Edwin\Desktop\ReporteYA\reportaya_institucional
Funciones principales
Inicio de sesión institucional.
Validación de pertenencia a una institución.
Gestión de sesión.
Dashboard institucional.
Estadísticas de reportes.
Consulta de reportes.
Gestión del estado de los reportes.
Visualización del historial.
Gestión del perfil institucional.
5. Tecnologías utilizadas
Aplicaciones móviles
Flutter
Dart
Android
iOS
Backend
Supabase
PostgreSQL
Supabase Auth
Supabase Storage
Row Level Security (RLS)
Mapas y ubicación
OpenStreetMap
flutter_map
Geolocator
Google Maps mediante enlaces externos
Gestión de estado
Flutter Riverpod
Otros paquetes
image_picker
url_launcher
flutter_launcher_icons
6. Arquitectura

El proyecto utiliza una estructura basada en separación de responsabilidades.

Aplicación ciudadana
lib/
├── core/
│   ├── constants/
│   ├── pages/
│   └── theme/
└── features/
    └── reports/
        ├── data/
        │   ├── models/
        │   └── repositories/
        ├── domain/
        │   ├── entities/
        │   └── repositories/
        └── presentation/
            ├── pages/
            └── widgets/
Aplicación institucional
lib/
├── core/
│   ├── constants/
│   └── theme/
└── features/
    ├── auth/
    │   ├── data/
    │   ├── domain/
    │   └── presentation/
    ├── dashboard/
    │   └── presentation/
    ├── reports/
    │   ├── data/
    │   ├── domain/
    │   └── presentation/
    └── profile/
        └── presentation/
7. Base de datos

La solución utiliza PostgreSQL mediante Supabase.

Tablas principales
categories
institutions
profiles
reports
report_status_history
institution_members
Relación general
categories
    │
    └──── reports
             │
             ├──── profiles
             │
             ├──── institutions
             │
             └──── report_status_history

institutions
    │
    └──── institution_members
8. Categorías

Las categorías utilizadas actualmente son:

Baches
Basura
Alumbrado público
Agua potable
Alcantarillado
Árboles
Otros
9. Tabla de reportes

La tabla reports contiene la información principal de cada incidencia.

Campos principales
Campo	Descripción
id	Identificador único
title	Título del reporte
description	Descripción de la incidencia
category_id	Categoría asociada
latitude	Latitud
longitude	Longitud
photo_url	URL de la fotografía
status	Estado actual
user_id	Usuario que creó el reporte
institution_id	Institución responsable
created_at	Fecha de creación
updated_at	Fecha de actualización
10. Estados de los reportes

Los estados disponibles son:

reportado
en_revision
asignado
en_proceso
resuelto
rechazado

Estos estados permiten representar el ciclo de atención de una incidencia.

11. Historial de estados

La tabla:

report_status_history

permite registrar los cambios de estado de cada reporte.

Se almacena información como:

Reporte asociado.
Estado anterior.
Estado nuevo.
Institución relacionada.
Usuario que realizó la operación.
Comentario.
Fecha del cambio.

El historial se genera mediante un trigger de PostgreSQL cuando se crea un reporte o cambia su estado.

12. Normalización de la base de datos

La estructura de la base de datos se diseñó buscando cumplir con la Tercera Forma Normal (3FN).

Las entidades principales se mantienen separadas:

Categorías.
Instituciones.
Perfiles.
Reportes.
Historial de estados.
Miembros institucionales.

Esto evita almacenar información repetida y permite mantener relaciones mediante claves foráneas.

13. Autenticación

La aplicación institucional utiliza Supabase Auth para controlar el acceso.

El flujo general es:

Usuario
   │
   ▼
Inicio de sesión
   │
   ▼
Supabase Auth
   │
   ▼
Validación de institution_members
   │
   ├── Usuario autorizado
   │        │
   │        ▼
   │    Dashboard
   │
   └── Usuario no autorizado
            │
            ▼
        Acceso rechazado

La aplicación ciudadana permite consultar reportes públicamente y crear reportes.

14. Seguridad

Se utilizan mecanismos de seguridad proporcionados por Supabase y PostgreSQL.

Medidas implementadas
Autenticación mediante Supabase Auth.
Row Level Security (RLS).
Políticas de acceso sobre las tablas.
Validación de pertenencia institucional.
Protección de las operaciones institucionales.
Gestión de sesiones.
Restricción de cambios de estado a usuarios institucionales autorizados.
Claves foráneas para mantener integridad referencial.

Las credenciales sensibles del backend no deben almacenarse en el código fuente ni publicarse en GitHub.

15. Almacenamiento de imágenes

Las fotografías de los reportes se almacenan en:

Supabase Storage

Bucket:

report-images

Las fotografías se utilizan como evidencia visual de las incidencias reportadas.

16. Geolocalización

La aplicación ciudadana utiliza el GPS del dispositivo para obtener:

Latitud
Longitud

Estas coordenadas se almacenan en la tabla reports.

La ubicación permite posteriormente visualizar el reporte en el mapa y abrir la posición mediante Google Maps.

17. Mapas

La aplicación utiliza:

OpenStreetMap

mediante el paquete:

flutter_map

Los reportes pueden visualizarse mediante marcadores asociados a sus coordenadas geográficas.

18. Validaciones

Los formularios deben validar los datos antes de enviarlos al backend.

Entre las validaciones utilizadas se encuentran:

Título obligatorio.
Descripción obligatoria.
Categoría obligatoria.
Ubicación válida.
Captura de fotografía mediante cámara.
Usuario autorizado para las operaciones institucionales.
19. Control de versiones

El proyecto utiliza:

Git
GitHub

Repositorio de la aplicación ciudadana:

https://github.com/Edwin11x/reportaya.git

Repositorio de la aplicación institucional:

https://github.com/Edwin11x/reportaya-institucional.git

El historial de Git permite mantener trazabilidad de los cambios realizados durante el desarrollo.

20. Pruebas

Durante el desarrollo se han realizado pruebas funcionales sobre:

Creación de reportes.
Carga de fotografías.
Obtención de ubicación GPS.
Consulta de reportes.
Visualización de imágenes.
Visualización en mapa.
Apertura de Google Maps.
Inicio de sesión institucional.
Validación de usuarios institucionales.
Actualización de estados.
Visualización del dashboard.

También se utiliza:

flutter analyze

para detectar problemas estáticos en el código.

21. Análisis del proyecto

Antes de generar versiones de entrega se verifica que el proyecto pueda analizarse correctamente mediante Flutter.

Comando:

flutter analyze

La aplicación ciudadana ha sido analizada durante el desarrollo sin errores estáticos pendientes.

22. Dependencias principales
Aplicación ciudadana
flutter_riverpod: ^2.6.1
flutter_map: ^8.3.2
latlong2: ^0.10.1
supabase_flutter: ^2.17.2
geolocator: ^14.0.3
image_picker: ^1.2.3
url_launcher: ^6.3.2
Aplicación institucional
flutter_riverpod: ^2.6.1
supabase_flutter: ^2.17.2
url_launcher: ^6.3.2
23. Configuración

Las aplicaciones utilizan Supabase como backend compartido.

La configuración del proyecto debe contener:

Supabase URL
Supabase Publishable Key

No se debe utilizar una service_role key dentro de las aplicaciones móviles.

24. CRUD

El sistema contempla operaciones de gestión de reportes.

Operaciones principales
Create
Read
Update
Delete

La implementación del CRUD completo se encuentra dentro de las actividades de desarrollo y mejora del proyecto.

25. Preparación para producción

Antes de una publicación definitiva se deben verificar:

Configuración de producción.
Variables de configuración.
Políticas RLS.
Permisos de almacenamiento.
Autenticación.
Pruebas funcionales.
Compilación de versión release.
Configuración de Android.
Configuración de iOS.
Documentación de despliegue.

La aplicación ciudadana ya cuenta con generación de APK en modo release para pruebas.

26. Evidencias del desarrollo

Como parte de la documentación del proyecto se recopilarán evidencias de:

Interfaz de la aplicación ciudadana.
Interfaz de la aplicación institucional.
Base de datos.
Supabase Storage.
Autenticación.
Creación de reportes.
Geolocalización.
Mapa.
Dashboard institucional.
Gestión de estados.
Historial.
Control de versiones.
Pruebas.
Generación de APK.
27. Video demostrativo

Se preparará un video demostrativo mostrando el flujo principal del sistema:

Inicio
   ↓
Visualización de reportes
   ↓
Crear reporte
   ↓
Tomar fotografía
   ↓
Obtener ubicación
   ↓
Seleccionar categoría
   ↓
Enviar reporte
   ↓
Visualizar reporte
   ↓
Inicio de sesión institucional
   ↓
Consultar reporte
   ↓
Actualizar estado
   ↓
Visualizar historial
28. Desarrollo avanzado

El proyecto se desarrolla considerando los requerimientos de la categoría Avanzado – Desarrollo.

Las principales áreas contempladas son:

README técnico.
Arquitectura del sistema.
Dependencias.
Configuración.
Servicios y endpoints.
Diseño y normalización de la base de datos.
Diagramas UML.
Operaciones CRUD.
Formularios.
Validaciones.
Estructura visual.
Control de versiones.
Seguridad.
Gestión de sesiones.
Protección de datos.
Preparación para producción.
Documentación de despliegue.
29. Estado actual
Aplicación ciudadana
 Conexión con Supabase
 Consulta de reportes
 Creación de reportes
 Captura mediante cámara
 GPS
 Categorías
 Fotografías en Storage
 Mapa
 Google Maps
 Estados
 Splash Screen
 Identidad visual
 Icono de aplicación
 APK release
Aplicación institucional
 Supabase
 Login
 Validación institucional
 Gestión de sesión
 Dashboard
 Estadísticas
 Consulta de reportes
 Gestión de estados
 Historial
 Perfil
Documentación y entregables
 README técnico
 Diagramas UML
 Evidencias finales
 Video demostrativo
 Documentación de despliegue final
 Revisión final de seguridad
 Flujo completo de control de versiones profesional
30. Regla de documentación

Cada funcionalidad importante implementada deberá contar con evidencia técnica cuando corresponda:

Código fuente.
Commit de Git.
Captura de pantalla.
Diagrama.
Prueba funcional.
Documentación.