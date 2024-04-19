import 'package:flutter/material.dart';

class ExceptionWidget extends StatelessWidget {
  final Exception exception;
  const ExceptionWidget(this.exception, {super.key, required this.onRetry});

  final void Function() onRetry;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('An error occurred'),
          Text(exception.toString()),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
