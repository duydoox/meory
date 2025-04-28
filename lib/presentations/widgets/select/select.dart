import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meory/app/app_cubit.dart';
import 'package:meory/generated/assets.gen.dart';
import 'package:meory/presentations/widgets/button_widget/tile_button.dart';

class Select extends StatefulWidget {
  final List<SelectData> values;
  final TextEditingController? controller;
  final String? initialValue;
  final EdgeInsetsGeometry? padding;
  const Select({
    super.key,
    required this.values,
    this.controller,
    this.initialValue,
    this.padding,
  });

  @override
  State<Select> createState() => _SelectState();
}

class _SelectState extends State<Select> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    if (widget.initialValue != null) {
      _controller.text = widget.initialValue!;
    }
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.read<AppCubit>().state.theme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: widget.values.map((e) {
        final isSelected = _controller.text == e.title;
        return TileButton(
          padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          onTap: () {
            _controller.text = e.title;
          },
          leading: e.leading,
          subtitle: e.subtitle,
          trailing: Container(
            width: 24,
            height: 24,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? theme.colors.primary : theme.colors.greyBackground2,
            ),
            child: Assets.icons.icCheck.svg(color: theme.colors.whiteText),
          ),
          backgroundColor: isSelected ? theme.colors.greyBackground2 : theme.colors.greyBackground,
          title: Text(e.title, style: AppTextStyle.s14w600),
        );
      }).toList(),
    );
  }
}

class SelectData {
  final Widget? leading;
  final String title;
  final Widget? subtitle;

  const SelectData({
    this.leading,
    required this.title,
    this.subtitle,
  });
}
