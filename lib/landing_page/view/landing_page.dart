import 'dart:ui';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  // backgroundColor: const Color(0xFF0B1020),
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            colors: [Color(0xFF141B34), Color(0xFF0B1020)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(),
            const SizedBox(height: 24),
            _uploadCard(),
            const SizedBox(height: 18),
            _jobDescription('Upload Job Description'),
            const SizedBox(height: 18),
            _jobDescription('Company Applying for'),
            const SizedBox(height: 18),
            _jobDescription('Job Appling for'),
            const SizedBox(height: 24),
            _analyzeButton(),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.menu, size: 22),
            SizedBox(width: 20),
            Text(
              "Welcome!",
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const Spacer(),
            // const Icon(Icons.notifications_none, size: 22),
          ],
        ),
        const SizedBox(height: 24),

        const SizedBox(height: 8),
        Text(
          "Improve your resume\nwith AI insights",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _uploadCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withOpacity(0.06),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.description_outlined),
                  const SizedBox(width: 8),
                  Text(
                    "Upload Resume",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  const Icon(Icons.cloud_upload_outlined),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                "Supported files: PDF, DOC, DOCX",
                style: TextStyle(fontSize: 12, color: Colors.white54),
              ),
              const SizedBox(height: 16),
              Container(
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Colors.white24,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.cloud, size: 32, color: Colors.white54),
                      const SizedBox(height: 8),
                      Text(
                        "Drag and drop your resume here",
                        style: TextStyle(fontSize: 13, color: Colors.white70),
                      ),

                      const SizedBox(height: 4),
                      Text(
                        "or Browse file",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _jobDescription(final String title) {
    return Row(
      children: [
        Text("Optional: ", style: TextStyle(color: Colors.white54)),
        Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
        const Spacer(),
        const Icon(Icons.chevron_right),
      ],
    );
  }

  Widget _analyzeButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF5B7CFF), Color(0xFF6A5BFF)],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              "Analyze Resume",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
