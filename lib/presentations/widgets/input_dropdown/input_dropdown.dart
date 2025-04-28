import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meory/app/app_cubit.dart';

class InputController<T> extends ValueNotifier<T?> {
  InputController(T? value) : super(value);
}

class InputDropdown<T> extends StatefulWidget {
  final List<T> values;
  final InputController<T?>? controller;
  final String? hintText;
  final T? initialValue;
  final String Function(T item)? display;
  final bool enabled;
  const InputDropdown({
    super.key,
    required this.values,
    this.controller,
    this.initialValue,
    this.hintText,
    this.enabled = true,
    this.display,
  });

  @override
  State<InputDropdown<T>> createState() => _InputDropdownState<T>();
}

class _InputDropdownState<T> extends State<InputDropdown<T>> {
  late final ValueNotifier<T?> _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? ValueNotifier<T?>(null);
    if (widget.initialValue != null) {
      _controller.value = widget.initialValue;
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
    return DropdownButtonHideUnderline(
      child: IgnorePointer(
        ignoring: !widget.enabled,
        child: DropdownButton2<T>(
          isExpanded: true,
          hint: Row(
            children: [
              Expanded(
                child: Text(
                  widget.hintText ?? '',
                  style: TextStyle(
                    fontSize: 14,
                    color: theme.colors.hintText,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          items: widget.values
              .map((T item) => DropdownMenuItem<T>(
                    value: item,
                    child: Text(
                      widget.display != null ? widget.display!(item) : item.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        color: theme.colors.blackText,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
              .toList(),
          value: widget.values.contains(_controller.value) ? _controller.value : null,
          onChanged: (T? value) {
            _controller.value = value;
          },
          buttonStyleData: ButtonStyleData(
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: theme.colors.inputBackground,
            ),
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: theme.colors.inputBackground,
            ),
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(40),
              thickness: MaterialStateProperty.all<double>(6),
              thumbVisibility: MaterialStateProperty.all<bool>(true),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
            padding: EdgeInsets.only(left: 14, right: 14),
          ),
        ),
      ),
    );
  }
}
