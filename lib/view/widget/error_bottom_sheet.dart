import 'package:flutter/material.dart';

class ErrorBottomSheet extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback? onRetry;

  const ErrorBottomSheet({
    super.key,
    required this.title,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// drag handle
            Center(
              child: Container(
                height: 4,
                width: 40,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

            Row(
              children: [
                const Icon(
                  Icons.error_outline_rounded,
                  color: Colors.red,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Dismiss"),
                  ),
                ),
                if (onRetry != null) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onRetry!();
                      },
                      child: const Text("Retry"),
                    ),
                  ),
                ]
              ],
            )
          ],
        ),
      ),
    );
  }
}
