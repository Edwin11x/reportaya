import 'package:flutter/material.dart';
import '../widgets/report_card.dart';
import 'create_report_page.dart';

class HomePage extends StatelessWidget {
  final VoidCallback onCreate;
  final List<dynamic> reports;

  const HomePage({super.key, required this.onCreate, required this.reports});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 8),
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F7EE),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.location_on_rounded, color: Color(0xFF08A84F), size: 27),
                  ),
                  const SizedBox(width: 10),
                  const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: 'Reporta', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xFF151A17))),
                        TextSpan(text: 'YA', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xFF08A84F))),
                      ],
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications_none_rounded),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 8, 20, 12),
              child: Text('Reportes de Somoto', style: TextStyle(fontSize: 27, fontWeight: FontWeight.w800)),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ReportCard(report: reports[index]),
              childCount: reports.length,
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 90)),
        ],
      ),
    );
  }
}
