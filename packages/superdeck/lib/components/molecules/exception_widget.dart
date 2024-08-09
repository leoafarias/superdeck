import 'package:flutter/material.dart';

class ExceptionWidget extends StatelessWidget {
  final Object? error;
  const ExceptionWidget(this.error, {super.key, required this.onRetry});

  final void Function() onRetry;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('An error occurred'),
            Text(error.toString()),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
