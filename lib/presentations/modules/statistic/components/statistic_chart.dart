import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meory/app/app_cubit.dart';
import 'package:meory/data/models/statistical_week/statistical_day_model.dart';

class StatisticChart extends StatefulWidget {
  final List<StatisticalDayModel> listStatisticalByDay;
  const StatisticChart({super.key, required this.listStatisticalByDay});

  @override
  State<StatisticChart> createState() => _StatisticChartState();
}

class _StatisticChartState extends State<StatisticChart> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutCubic,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(StatisticChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.listStatisticalByDay != widget.listStatisticalByDay) {
      _animationController.reset();
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.read<AppCubit>().state.theme;
    return AspectRatio(
      aspectRatio: 1.7,
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        padding: const EdgeInsets.only(top: 20, left: 24, right: 4, bottom: 12),
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return CustomPaint(
              painter: ChartPainter(
                statistics: widget.listStatisticalByDay,
                theme: theme,
                progress: _animation.value,
              ),
            );
          },
        ),
      ),
    );
  }
}

class ChartPainter extends CustomPainter {
  final List<StatisticalDayModel> statistics;
  final AppTheme theme;
  final double progress;

  ChartPainter({
    required this.statistics,
    required this.theme,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width;
    final double height = size.height;
    const double padding = 0.0;
    final double chartWidth = width - padding * 2;
    final double chartHeight = height - padding * 2;

    // Calculate max value for scaling
    final maxPlayed =
        statistics.map((e) => e.numberOfPlayed ?? 0).reduce((a, b) => a > b ? a : b).toDouble();
    final scale = chartHeight / (maxPlayed > 0 ? maxPlayed : 1);

    // Draw background grid
    _drawGrid(canvas, size, padding, chartWidth, chartHeight, maxPlayed);

    // Draw dates
    _drawDates(canvas, size, padding, chartWidth);

    // Draw played line
    _drawLine(
      canvas,
      statistics.map((e) => e.numberOfPlayed?.toDouble() ?? 0).toList(),
      padding,
      chartWidth,
      chartHeight,
      scale,
      theme.colors.primary,
    );

    // Draw success line
    _drawLine(
      canvas,
      statistics.map((e) => e.numberOfSuccess?.toDouble() ?? 0).toList(),
      padding,
      chartWidth,
      chartHeight,
      scale,
      theme.colors.green,
    );

    // Draw legend
    _drawLegend(canvas, size, padding);
  }

  void _drawGrid(Canvas canvas, Size size, double padding, double chartWidth, double chartHeight,
      double maxPlayed) {
    final paint = Paint()
      ..color = theme.colors.hintText
      ..strokeWidth = 1;

    final int labelScale = (maxPlayed / 4).floor();
    final double gridScale = chartHeight / (maxPlayed > 0 ? maxPlayed : 1) * labelScale;

    // Horizontal lines
    for (int i = 0; i <= 4; i++) {
      final y = padding + chartHeight - gridScale * (4 - i);
      canvas.drawLine(
        Offset(padding, y),
        Offset(padding + chartWidth, y),
        paint,
      );

      // Draw labels
      final textStyle = TextStyle(
        color: theme.colors.hintText,
        fontSize: 12,
      );
      final textSpan = TextSpan(
        text: (labelScale * (4 - i)).toStringAsFixed(0),
        style: textStyle,
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(padding - textPainter.width - 8, y - textPainter.height / 2),
      );
    }
  }

  void _drawDates(Canvas canvas, Size size, double padding, double chartWidth) {
    final textStyle = TextStyle(
      color: theme.colors.hintText,
      fontSize: 12,
    );

    for (int i = 0; i < statistics.length; i++) {
      final x = padding +
          (statistics.length > 1 ? (chartWidth * i / (statistics.length - 1)) : chartWidth / 2);
      final day = statistics[i].toDate?.day.toString() ?? '';
      final month = statistics[i].toDate?.month.toString() ?? '';
      final date = '$day/$month';

      final textSpan = TextSpan(text: date, style: textStyle);
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(x - textPainter.width / 2, size.height - padding + 8),
      );
    }
  }

  void _drawLine(Canvas canvas, List<double> values, double padding, double chartWidth,
      double chartHeight, double scale, Color color) {
    if (values.isEmpty) return;

    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();
    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          color.withOpacity(0.3),
          color.withOpacity(0.05),
        ],
      ).createShader(Rect.fromLTWH(0, padding, chartWidth, chartHeight));

    final points = <Offset>[];

    // Calculate all points with animation
    for (int i = 0; i < values.length; i++) {
      final x =
          padding + (values.length > 1 ? (chartWidth * i / (values.length - 1)) : chartWidth / 2);
      final y = padding + chartHeight - (values[i] * scale * progress);
      points.add(Offset(x, y));
    }

    // Draw smooth curve
    path.moveTo(points.first.dx, points.first.dy);

    for (int i = 0; i < points.length - 1; i++) {
      final current = points[i];
      final next = points[i + 1];
      final controlPoint1 = Offset(
        current.dx + (next.dx - current.dx) / 2,
        current.dy,
      );
      final controlPoint2 = Offset(
        current.dx + (next.dx - current.dx) / 2,
        next.dy,
      );

      path.cubicTo(
        controlPoint1.dx,
        controlPoint1.dy,
        controlPoint2.dx,
        controlPoint2.dy,
        next.dx,
        next.dy,
      );
    }

    // Draw fill
    final fillPath = Path.from(path);
    fillPath.lineTo(points.last.dx, padding + chartHeight);
    fillPath.lineTo(points.first.dx, padding + chartHeight);
    fillPath.close();
    canvas.drawPath(fillPath, fillPaint);

    // Draw line
    canvas.drawPath(path, paint);

    // Draw points
    for (final point in points) {
      canvas.drawCircle(
        point,
        4,
        Paint()..color = theme.colors.white,
      );
      canvas.drawCircle(
        point,
        3,
        Paint()..color = color,
      );
    }
  }

  void _drawLegend(Canvas canvas, Size size, double padding) {
    final textStyle = TextStyle(
      color: theme.colors.primaryText,
      fontSize: 12,
      fontWeight: FontWeight.w500,
    );

    // Played legend
    _drawLegendItem(
      canvas,
      Offset(padding, padding - 20),
      'Played',
      theme.colors.primary,
      textStyle,
    );

    // Success legend
    _drawLegendItem(
      canvas,
      Offset(padding + 80, padding - 20),
      'Success',
      theme.colors.green,
      textStyle,
    );
  }

  void _drawLegendItem(
    Canvas canvas,
    Offset offset,
    String text,
    Color color,
    TextStyle style,
  ) {
    // Draw dot
    canvas.drawCircle(
      offset.translate(0, 0),
      4,
      Paint()..color = color,
    );

    // Draw text
    final textSpan = TextSpan(text: text, style: style);
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      offset.translate(12, -6),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
