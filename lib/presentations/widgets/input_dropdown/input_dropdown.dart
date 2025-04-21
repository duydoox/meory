import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meory/app/app_cubit.dart';

class InputDropdown extends StatefulWidget {
  final List<String> values;
  final TextEditingController? controller;
  final String? hintText;
  final String? initialValue;
  final bool enabled;
  const InputDropdown(
      {super.key,
      required this.values,
      this.controller,
      this.initialValue,
      this.hintText,
      this.enabled = true});

  @override
  State<InputDropdown> createState() => _InputDropdownState();
}

class _InputDropdownState extends State<InputDropdown> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    if (_controller.text.isEmpty) {
      _controller.text = widget.initialValue ?? '';
    }
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.read<AppCubit>().state.theme;
    return DropdownButtonHideUnderline(
      child: IgnorePointer(
        ignoring: !widget.enabled,
        child: DropdownButton2<String>(
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
              .map((String item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: 14,
                        color: theme.colors.blackText,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
              .toList(),
          value: widget.values.contains(_controller.text) ? _controller.text : null,
          onChanged: (String? value) {
            _controller.text = value ?? '';
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
