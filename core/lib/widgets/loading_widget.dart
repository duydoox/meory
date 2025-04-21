import 'package:flutter/material.dart';
import 'dart:math' as math;

class LoadingWidget extends StatefulWidget {
  final Widget? icon;
  final double size;
  final Color color;

  const LoadingWidget({
    Key? key,
    this.icon,
    this.size = 50.0,
    this.color = Colors.blue,
  }) : super(key: key);

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: false);

    _animation = Tween<double>(begin: 2.0, end: 0.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return RotationTransition(
                turns: _controller.drive(Tween(begin: _animation.value, end: 0.0)),
                child: CustomPaint(
                  size: Size(widget.size, widget.size),
                  painter: _LoadingPainter(widget.color),
                ),
              );
            },
          ),
          SizedBox(
            width: widget.size * 0.5,
            height: widget.size * 0.5,
            child: widget.icon,
          ),
        ],
      ),
    );
  }
}

class _LoadingPainter extends CustomPainter {
  final Color color;

  _LoadingPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color.withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final double radius = size.width / 2;
    const segmentCount = 12;

    for (int i = 0; i < segmentCount; i++) {
      final double angle = (i / segmentCount) * 2 * math.pi;
      final double startX = radius + radius * math.cos(angle);
      final double startY = radius + radius * math.sin(angle);
      final double endX = radius + (radius - 8) * math.cos(angle);
      final double endY = radius + (radius - 8) * math.sin(angle);

      paint.color = color.withOpacity(i / segmentCount);
      canvas.drawLine(Offset(startX, startY), Offset(endX, endY), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
