import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/pages/splash_page.dart';
import 'core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://oftyidnjsfaujehlyvbh.supabase.co',
    publishableKey:
    'sb_publishable_DMFAn2u6oIsMfB8GcfbEhQ_rYbVfrX_',
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
      home: const SplashPage(),
    );
  }
}