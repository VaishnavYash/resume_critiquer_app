import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:resume_critiquer_app/analysis_page/view/section_analysis_page.dart';
import 'package:resume_critiquer_app/analysis_page/widget/analysis_card_widget.dart';
import 'package:resume_critiquer_app/model/card_content.dart';

class ResumeAnalysisSection extends StatelessWidget {
  const ResumeAnalysisSection({super.key, required this.jsonData});

  final Map<String, Map<String, List<String>>> jsonData;

  @override
  Widget build(BuildContext context) {
    final data = _organizeData();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0B1220), Color(0xFF0E1627)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...data,
          // const SizedBox(height: 24),

          // // View Details Button
          // Center(
          //   child: ElevatedButton(
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: const Color(0xFF1F3C88),
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(24),
          //       ),
          //       padding: const EdgeInsets.symmetric(
          //         horizontal: 28,
          //         vertical: 12,
          //       ),
          //     ),
          //     onPressed: () {},
          //     child: const Text("View Details", style: TextStyle(fontSize: 14)),
          //   ),
          // ),
        ],
      ),
    );
  }

  List<Widget> _organizeData() {
    final data = <Widget>[];
    for (var entry in jsonData.entries) {
      final list = <CardContent>[];
      for (var entryData in entry.value.entries) {
        list.add(CardContent(title: entryData.key, points: entryData.value));
      }
      data.add(
        Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: AnalysisCard(
            icon: Icons.work_outline,
            title: entry.key,
            cardContent:list,
            // strengths: list[0].points.length,
            // improvements: list[1].points.length,
          ),
        ),
      );
    }
    return data;
  }
}
