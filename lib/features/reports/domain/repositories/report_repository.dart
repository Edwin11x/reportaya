import '../entities/report.dart';

abstract class ReportRepository {
  List<Report> getReports();
}
