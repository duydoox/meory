import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:meory/presentations/widgets/base_widget.dart';

class ScreenEmpty extends BaseWidget {
  const ScreenEmpty({super.key});

  @override
  Widget build(BuildContext context, AppTheme theme, AppLocalizations tr) {
    return const Center(
      child: Text("Tính năng này sẽ được phát triển trong tương lai!"),
    );
  }
}
