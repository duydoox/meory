import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:meory/presentations/widgets/base_widget.dart';

class HomeButton extends BaseWidget {
  final String? title;
  final Widget? icon;
  final VoidCallback? onTap;

  const HomeButton({this.title, this.icon, this.onTap, super.key});

  @override
  Widget build(BuildContext context, AppTheme theme, AppLocalizations tr) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Ink(
          width: 130,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.colors.blueBackground,
                  ),
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 28,
                    width: 28,
                    child: icon,
                  ),
                ),
              ),
              Text(
                title ?? '',
                textAlign: TextAlign.center,
                style: AppTextStyle.s12w400.copyWith(
                  color: theme.colors.blackText,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
