import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:meory/app/app_assets.dart';
import 'package:meory/presentations/widgets/base_widget.dart';
import 'package:meory/presentations/widgets/dot_widget/dot.dart';

class IconBellNoti extends BaseWidget {
  final bool hasNoti;
  final VoidCallback? onTap;

  const IconBellNoti({
    super.key,
    this.hasNoti = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, AppTheme theme, AppLocalizations tr) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            height: 40,
            width: 40,
            alignment: Alignment.center,
            decoration:
                BoxDecoration(color: theme.colors.white, borderRadius: BorderRadius.circular(8)),
            child: AppIcon.icBell(),
          ),
          Positioned(
            right: 10,
            top: 10,
            child: Visibility(
              visible: hasNoti,
              child: Dot(
                size: 10,
                strokeAlign: 1,
                colorBorder: theme.colors.white,
                color: theme.colors.red,
              ),
            ),
          )
        ],
      ),
    );
  }
}
