import 'dart:async';

import 'package:flutter/material.dart';

class Countdown extends StatefulWidget {
  final int seconds;
  final TextStyle? textStyle;
  final VoidCallback? onFinished;
  const Countdown({super.key, required this.seconds, this.textStyle, this.onFinished});

  @override
  State<Countdown> createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> {
  late int _remainingSeconds;
  late int _endTimeMs;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.seconds;
    _endTimeMs = DateTime.now().add(Duration(seconds: _remainingSeconds)).millisecondsSinceEpoch;
    _startTimer();
  }

  String _formatTime(int seconds) {
    final int minutes = (seconds ~/ 60);
    final int hours = (minutes ~/ 60);
    final int remainingMinutes = (minutes % 60);
    final int remainingSeconds = (seconds % 60);
    if (hours == 0) {
      return '${remainingMinutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
    }
    return '${hours.toString().padLeft(2, '0')}:${remainingMinutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void _startTimer() {
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final currentTimeMs = DateTime.now().millisecondsSinceEpoch;
      _remainingSeconds = (_endTimeMs - currentTimeMs) ~/ 1000;
      if (_remainingSeconds < 0) {
        _remainingSeconds = 0;
      }
      setState(() {});
      if (_remainingSeconds <= 0) {
        _timer?.cancel();
        if (widget.seconds > 0) {
          widget.onFinished?.call();
        }
      }
    });
  }

  @override
  void didUpdateWidget(Countdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.seconds != widget.seconds) {
      setState(() {
        _remainingSeconds = widget.seconds;
        _endTimeMs =
            DateTime.now().add(Duration(seconds: _remainingSeconds)).millisecondsSinceEpoch;
      });
      _startTimer();
    }
  }

  @override
  void dispose() {
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(_formatTime(_remainingSeconds), style: widget.textStyle);
  }
}
