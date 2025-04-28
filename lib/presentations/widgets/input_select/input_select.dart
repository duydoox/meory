import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meory/app/app_cubit.dart';

class InputSelect extends StatefulWidget {
  final List<String> values;
  final TextEditingController? controller;
  final String? initialValue;
  final bool enabled;
  final EdgeInsetsGeometry? itemPadding;
  const InputSelect({
    super.key,
    required this.values,
    this.controller,
    this.initialValue,
    this.enabled = true,
    this.itemPadding,
  });

  @override
  State<InputSelect> createState() => _InputSelectState();
}

class _InputSelectState extends State<InputSelect> {
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: widget.values.fold([], (list, e) {
          final isSelected = _controller.text == e;
          if (widget.values.indexOf(e) > 0) {
            list.add(VerticalDivider(color: theme.colors.divider, width: 1));
          }
          list.add(InkWell(
            onTap: widget.enabled
                ? () {
                    _controller.text = e;
                  }
                : null,
            child: Container(
              height: 48,
              alignment: Alignment.center,
              padding:
                  widget.itemPadding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(12),
                color: isSelected ? theme.colors.primary : theme.colors.inputBackground,
              ),
              child: Text(
                e,
                style: AppTextStyle.s14w400.copyWith(
                  color: isSelected ? theme.colors.whiteText : theme.colors.blackText,
                ),
              ),
            ),
          ));
          return list;
        }),
      ),
    );
  }
}
