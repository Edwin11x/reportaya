import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'features/reports/data/repositories/report_repository_impl.dart';
import 'features/reports/domain/repositories/report_repository.dart';
import 'features/reports/presentation/pages/create_report_page.dart';
import 'features/reports/presentation/pages/home_page.dart';
import 'features/reports/presentation/pages/placeholder_page.dart';

final reportRepositoryProvider = Provider<ReportRepository>(
  (ref) => ReportRepositoryImpl(),
);

void main() {
  runApp(const ProviderScope(child: ReportaYaApp()));
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
      MaterialPageRoute(builder: (_) => const CreateReportPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final reports = ref.watch(reportRepositoryProvider).getReports();

    final pages = [
      HomePage(onCreate: openCreate, reports: reports),
      const PlaceholderPage(title: 'Explorar reportes'),
      const PlaceholderPage(title: 'Ranking de reportes'),
    ];

    return Scaffold(
      body: IndexedStack(index: index, children: pages),
      floatingActionButton: index == 0
          ? FloatingActionButton(
              onPressed: openCreate,
              backgroundColor: AppTheme.primary,
              foregroundColor: Colors.white,
              child: const Icon(Icons.add_rounded, size: 32),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) => setState(() => index = value),
        height: 72,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_rounded),
            label: 'Explorar',
          ),
          NavigationDestination(
            icon: Icon(Icons.emoji_events_outlined),
            selectedIcon: Icon(Icons.emoji_events_rounded),
            label: 'Ranking',
          ),
        ],
      ),
    );
  }
}
