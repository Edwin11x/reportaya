import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import 'create_report_page.dart';
import 'home_page.dart';
import 'map_page.dart';
import 'placeholder_page.dart';
import '../providers/reports_provider.dart';

class MainShell extends ConsumerStatefulWidget {
  const MainShell({super.key});

  @override
  ConsumerState<MainShell> createState() => _MainShellState();
}

class _MainShellState extends ConsumerState<MainShell> {
  int index = 0;

  Future<void> openCreate() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const CreateReportPage(),
      ),
    );

    if (!mounted) return;

    ref.invalidate(reportsProvider);
  }

  @override
  Widget build(BuildContext context) {
    final reportsAsync = ref.watch(reportsProvider);

    return reportsAsync.when(
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (error, stack) => Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 48,
                ),
                const SizedBox(height: 16),
                const Text(
                  'No se pudieron cargar los reportes',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  error.toString(),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    ref.invalidate(reportsProvider);
                  },
                  child: const Text('Reintentar'),
                ),
              ],
            ),
          ),
        ),
      ),
      data: (reports) {
        final pages = [
          HomePage(
            key: ValueKey('home-${reports.length}'),
            onCreate: openCreate,
            reports: reports,
          ),
          MapPage(
            key: ValueKey('map-${reports.length}'),
            reports: reports,
          ),
          const PlaceholderPage(
            title: 'Ranking de reportes',
          ),
        ];

        return Scaffold(
          body: IndexedStack(
            index: index,
            children: pages,
          ),
          floatingActionButton: index == 0
              ? FloatingActionButton(
            onPressed: openCreate,
            backgroundColor: AppTheme.primary,
            foregroundColor: Colors.white,
            child: const Icon(
              Icons.add_rounded,
              size: 32,
            ),
          )
              : null,
          bottomNavigationBar: NavigationBar(
            selectedIndex: index,
            onDestinationSelected: (value) {
              setState(() {
                index = value;
              });
            },
            height: 72,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home_rounded),
                label: 'Inicio',
              ),
              NavigationDestination(
                icon: Icon(Icons.map_outlined),
                selectedIcon: Icon(Icons.map_rounded),
                label: 'Mapa',
              ),
              NavigationDestination(
                icon: Icon(Icons.emoji_events_outlined),
                selectedIcon: Icon(Icons.emoji_events_rounded),
                label: 'Ranking',
              ),
            ],
          ),
        );
      },
    );
  }
}