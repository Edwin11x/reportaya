import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/app_theme.dart';
import 'features/reports/data/repositories/report_repository_impl.dart';
import 'features/reports/domain/entities/report.dart';
import 'features/reports/domain/repositories/report_repository.dart';
import 'features/reports/presentation/pages/create_report_page.dart';
import 'features/reports/presentation/pages/home_page.dart';
import 'features/reports/presentation/pages/placeholder_page.dart';
import 'features/reports/presentation/pages/map_page.dart';

final reportRepositoryProvider = Provider<ReportRepository>(
      (ref) => ReportRepositoryImpl(),
);

final reportsProvider = FutureProvider<List<Report>>((ref) async {
  final repository = ref.read(reportRepositoryProvider);

  return (repository as ReportRepositoryImpl).getReportsFromSupabase();
});

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://oftyidnjsfaujehlyvbh.supabase.co',
    anonKey: 'sb_publishable_DMFAn2u6oIsMfB8GcfbEhQ_rYbVfrX_',
  );

  runApp(
    const ProviderScope(
      child: ReportaYaApp(),
    ),
  );
}

class ReportaYaApp extends StatelessWidget {
  const ReportaYaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ReportaYA Somoto',
      theme: AppTheme.light(),
      home: const MainShell(),
    );
  }
}

class MainShell extends ConsumerStatefulWidget {
  const MainShell({super.key});

  @override
  ConsumerState<MainShell> createState() => _MainShellState();
}

class _MainShellState extends ConsumerState<MainShell> {
  int index = 0;

  void openCreate() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const CreateReportPage(),
      ),
    );
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
            onCreate: openCreate,
            reports: reports,
          ),
          MapPage(
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