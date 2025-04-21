import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:meory/presentations/widgets/base_widget.dart';

class IconButtonWidget extends BaseWidget {
  final Widget? icon;

  const IconButtonWidget({super.key, this.icon});

  @override
  Widget build(BuildContext context, AppTheme theme, AppLocalizations tr) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 32,
        vertical: 18,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.colors.border),
      ),
      child: icon,
    );
  }
}
