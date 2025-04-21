import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:meory/presentations/widgets/base_widget.dart';

class CardView extends BaseWidget {
  final VoidCallback? onTap;
  final Widget? body;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const CardView({
    super.key,
    this.onTap,
    this.body,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context, AppTheme theme, AppLocalizations tr) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Ink(
          padding: padding ?? const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: theme.colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: theme.colors.grey.withOpacity(0.3),
                  blurRadius: 4,
                  offset: const Offset(1, 1), // Shadow position
                ),
              ]),
          child: body ?? const SizedBox(),
        ),
      ),
    );
  }
}
