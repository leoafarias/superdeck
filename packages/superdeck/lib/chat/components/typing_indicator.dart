import 'dart:async';

import 'package:flutter/material.dart';

class WaitingIndicator extends StatefulWidget {
  final bool isTyping;

  const WaitingIndicator({super.key, required this.isTyping});

  @override
  State createState() => _WaitingIndicatorState();
}

class _WaitingIndicatorState extends State<WaitingIndicator> {
  late Timer _timer;
  final List<double> _dotSizes = [6, 8, 10];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 500), (_) {
      setState(() {
        _dotSizes.insert(0, _dotSizes.removeLast());
      });
    });
  }

  void _stopTimer() {
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isTyping
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final size in _dotSizes)
                Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    height: size,
                    width: size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[400],
                    ),
                  ),
                ),
            ],
          )
        : const SizedBox.shrink();
  }
}
