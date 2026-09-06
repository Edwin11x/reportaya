# ReportaYA

Aplicación móvil ciudadana para reportar problemas y situaciones que afectan a la comunidad de Somoto, Nicaragua.

## 📱 Descripción

ReportaYA permite a los ciudadanos registrar reportes sobre problemas de infraestructura y servicios públicos, incluyendo fotografías, ubicación GPS y una descripción del problema.

Los reportes son almacenados y gestionados mediante un backend compartido con la aplicación institucional de ReportaYA.

## ✨ Funcionalidades

- 📋 Consulta de reportes ciudadanos
- ➕ Creación de nuevos reportes
- 📷 Captura de fotografías mediante la cámara
- 📍 Obtención de ubicación mediante GPS
- 🗺️ Visualización de reportes en un mapa
- 🔎 Consulta de información del reporte
- 📌 Visualización de ubicación mediante Google Maps
- 🔄 Actualización automática de la lista de reportes
- 🏷️ Clasificación de reportes por categoría
- 📊 Visualización del estado de cada reporte

## 🏷️ Categorías

Actualmente se utilizan las siguientes categorías:

- Baches
- Basura
- Alumbrado público
- Agua potable
- Alcantarillado
- Árboles
- Otros

## 🔄 Estados de los reportes

- Reportado
- En revisión
- Asignado
- En proceso
- Resuelto
- Rechazado

## 🛠️ Tecnologías

- Flutter
- Dart
- Riverpod
- Supabase
- PostgreSQL
- OpenStreetMap
- flutter_map
- Geolocator
- Image Picker
- URL Launcher

## 🗄️ Backend

La aplicación utiliza **Supabase** como backend.

Principales recursos utilizados:

- `reports`
- `categories`
- `institutions`
- `profiles`
- `report_status_history`

También utiliza Supabase Storage para almacenar las fotografías de los reportes.

## 📱 Plataformas

- Android
- iOS

## 🏗️ Arquitectura

El proyecto utiliza una estructura basada en **Clean Architecture** y **Riverpod**.

```text
lib/
├── core/
│   ├── constants/
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
