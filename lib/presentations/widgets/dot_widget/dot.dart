import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:meory/presentations/widgets/base_widget.dart';

class Dot extends BaseWidget {
  final Color? color;
  final double? size;
  final double? strokeAlign;
  final Color? colorBorder;
  const Dot({this.color, this.size, this.colorBorder, this.strokeAlign, super.key});

  @override
  Widget build(BuildContext context, AppTheme theme, AppLocalizations tr) {
    return Container(
      height: size ?? 10,
      width: size ?? 10,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          border: Border.all(color: colorBorder ?? theme.colors.white, width: strokeAlign ?? 0)),
    );
  }
}
