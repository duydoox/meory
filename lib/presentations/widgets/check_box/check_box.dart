import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meory/app/app_cubit.dart';

class CheckBoxWidget extends StatefulWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final String? title;

  const CheckBoxWidget({
    super.key,
    required this.value,
    required this.onChanged,
    this.title,
  });

  @override
  State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  late bool valueLocal;

  @override
  void initState() {
    valueLocal = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.read<AppCubit>().state.theme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          activeColor: theme.colors.primary,
          value: valueLocal,
          onChanged: (val) {
            setState(() {
              valueLocal = val!;
            });
            widget.onChanged.call(val);
          },
          visualDensity: VisualDensity.compact,
        ),
        if (widget.title != null) const SizedBox(width: 12),
        Text(
          widget.title ?? '',
          style: AppTextStyle.s14w600,
        )
      ],
    );
  }
}
