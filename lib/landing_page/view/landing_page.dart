import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:resume_critiquer_app/framework/widgets/text_field_widget.dart';
import 'package:resume_critiquer_app/framework/widgets/text_widget.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  // backgroundColor: const Color(0xFF0B1020),
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        // color: Colors.amber,
        height: MediaQuery.of(context).size.height,
        child: Stack(children: [_topBar(context), _mainContent(context)]),
      ),
    );
  }

  Widget _mainContent(final BuildContext context) => Positioned(
    top: MediaQuery.sizeOf(context).height / 4,
    child: Container(
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          _uploadCard(context),
          const SizedBox(height: 18),
          _jobDescription('Company Applying for', context),
          const SizedBox(height: 18),
          _jobDescription('Job Appling for', context),
          const SizedBox(height: 24),
          _analyzeButton(context),
        ],
      ),
    ),
  );

  Widget _header(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        TextWidget(
          text: "Improve your resume\nwith AI insights",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: 26,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _topBar(final BuildContext context) => Container(
    padding: EdgeInsets.all(10),
    height: 280,
    width: MediaQuery.sizeOf(context).width,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF4A5CF3),
          Color(0xFF7B5CFF),
          Color(0xFF7B5CFF),
          Color(0xFF7B5CFF),
        ],
      ),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.menu, size: 22), // Icon Change
            SizedBox(width: 20),
            TextWidget(
              text: "Welcome!",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
          ],
        ),
        _header(context),
      ],
    ),
  );

  Widget _uploadCard(final BuildContext context) {
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
              // Row(
              //   children: [
              //     const Icon(Icons.description_outlined),
              //     const SizedBox(width: 8),
              //     TextWidget(
              //       text: "Upload Resume",
              //       style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              //         fontSize: 16,
              //         fontWeight: FontWeight.w500,
              //       ),
              //     ),
              //     const Spacer(),
              //     const Icon(Icons.cloud_upload_outlined),
              //   ],
              // ),
              const SizedBox(height: 4),
              TextWidget(
                text: "Supported files: PDF, DOC, DOCX",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 12,
                  color: Colors.white54,
                ),
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
                      TextWidget(
                        text: "Drag and drop your resume here",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 13,
                          color: Colors.white70,
                        ),
                      ),

                      const SizedBox(height: 4),
                      TextWidget(
                        text: "or Browse file",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
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

  Widget _jobDescription(final String title, final BuildContext context) {
    return InkWell(
      onTap: () {
        // showDialog(
        //   context: context,
        //   builder: (final context) {
        //     return _popUpTextField(context, title, 'Google');
        //   },
        // );
      },
      child: TextFieldWidget(
        label: title,
        hintText: 'Google',
        textFieldTheme: TextFieldTheme.light,
      ),
      // child: Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //     Row(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         TextWidget(
      //           text: "Optional: ",
      //           style: Theme.of(
      //             context,
      //           ).textTheme.bodyLarge?.copyWith(color: Colors.white54),
      //         ),
      //         TextWidget(
      //           text: title,
      //           style: Theme.of(
      //             context,
      //           ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
      //         ),
      //       ],
      //     ),
      //     Icon(Icons.chevron_right),
      //   ],
      // ),
    );
  }

  Widget _popUpTextField(
    final BuildContext context,
    final String title,
    final String hintText,
  ) {
    return AlertDialog(
      title: const Text('AlertDialog Title'),
      content: TextField(
        //  title,
        //         hintText: hintText,
        //         textFieldTheme: TextFieldTheme.light,
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Submit'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  Widget _analyzeButton(final BuildContext context) {
    return SizedBox(
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
            child: TextWidget(
              text: "Analyze Resume",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
