import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:meory/presentations/widgets/base_widget.dart';

class CustomButton extends BaseWidget {
  final String? title;
  final TextStyle? titleTextStyle;
  final Color? backgroundColor;
  final Color? borderColor;
  final VoidCallback? onTap;
  final Widget? icon;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final double? width;

  const CustomButton({
    this.title,
    this.titleTextStyle,
    this.backgroundColor,
    this.borderColor,
    this.onTap,
    this.icon,
    this.borderRadius,
    this.padding,
    this.height,
    this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context, AppTheme theme, AppLocalizations tr) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius ?? 8),
        child: Ink(
          height: height ?? 48,
          width: width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
              border: Border.all(color: borderColor ?? theme.colors.border),
              color: backgroundColor ?? theme.colors.white),
          //alignment: Alignment.center,
          padding: padding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              icon ?? const SizedBox.shrink(),
              if (icon != null && title != null)
                const SizedBox(
                  width: 12,
                ),
              Center(
                child: Text(
                  title ?? '',
                  style: titleTextStyle ??
                      AppTextStyle.s16w600.copyWith(
                        color: theme.colors.blackText,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
