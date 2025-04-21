import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:meory/presentations/widgets/base_widget.dart';

class TitleWidget extends BaseWidget {
  final String? title;
  final String? actionTitle;
  final VoidCallback? onTapTitle;
  final VoidCallback? onTapActionTitle;
  final EdgeInsets? padding;

  const TitleWidget({
    this.title,
    this.actionTitle,
    this.onTapTitle,
    this.onTapActionTitle,
    this.padding,
    super.key,
  });

  @override
  Widget build(BuildContext context, AppTheme theme, AppLocalizations tr) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: onTapTitle,
            child: Text(
              title ?? '',
              style: AppTextStyle.s16w500CD,
            ),
          ),
          InkWell(
            onTap: onTapActionTitle,
            child: Text(
              actionTitle ?? '',
              style: AppTextStyle.s14w500CD.copyWith(
                color: theme.colors.blackText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
