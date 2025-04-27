import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:meory/presentations/widgets/base_widget.dart';
import 'package:meory/presentations/widgets/nav_bar_custom/screen_empty.dart';

import '../cubit/example_cubit.dart';

class ExampleView extends BaseWidget<ExampleCubit, ExampleState> {
  const ExampleView({super.key});

  @override
  Widget build(BuildContext context, AppTheme theme, AppLocalizations tr) {
    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(title: const Text('Example')),
      body: const ScreenEmpty(),
    );
  }
}
