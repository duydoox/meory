import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meory/app/app_cubit.dart';
import 'package:meory/presentations/widgets/base_widget.dart';

class PrimaryButton extends BaseWidget {
  final Color? backgroundColor;
  final String? title;
  final VoidCallback? onTap;
  final bool disable;
  final Widget? icon;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final double? width;

  const PrimaryButton({
    this.title,
    this.onTap,
    this.disable = false,
    this.icon,
    this.borderRadius,
    this.padding,
    this.height,
    this.width,
    super.key,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context, AppTheme theme, AppLocalizations tr) {
    return BlocBuilder<AppCubit, AppState>(
        buildWhen: (previous, current) => previous.theme != current.theme,
        builder: (context, state) {
          final theme = state.theme;
          return Opacity(
            opacity: disable ? 0.3 : 1,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: disable ? null : onTap,
                borderRadius: BorderRadius.circular(borderRadius ?? 8),
                child: Ink(
                  height: height ?? 55,
                  width: width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(borderRadius ?? 8),
                      border: Border.all(color: theme.colors.border),
                      color: backgroundColor ?? theme.colors.primary),
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
                          style: AppTextStyle.s16w700.copyWith(
                            color: theme.colors.secondaryText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
