import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/report_repository_impl.dart';
import '../../domain/entities/report.dart';
import '../../domain/repositories/report_repository.dart';

final reportRepositoryProvider = Provider<ReportRepository>(
      (ref) => ReportRepositoryImpl(),
);

final reportsProvider = FutureProvider<List<Report>>((ref) async {
  final repository = ref.read(reportRepositoryProvider);

  return (repository as ReportRepositoryImpl).getReportsFromSupabase();
});