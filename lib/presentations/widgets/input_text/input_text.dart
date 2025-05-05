import 'package:core/core.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meory/app/app_cubit.dart';
import 'package:meory/generated/assets.gen.dart';

class InputText extends StatefulWidget {
  final TextEditingController? controller;
  final TextEditingController? countryController;
  final FocusNode? focusNode;
  final String? hintText;
  final String? initValue;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? suffixIconChangeOnTap;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? minLines;
  final bool? isPassword;
  final double? height;
  final bool enabled;
  final bool autofocus;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChangedText;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onBlur;
  final String? Function(String? value)? validator;
  final FormInputText? formInputText;

  const InputText({
    super.key,
    this.hintText,
    this.initValue,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixIconChangeOnTap,
    this.keyboardType,
    this.maxLines = 1,
    this.minLines,
    this.isPassword,
    this.height,
    this.enabled = true,
    this.autofocus = false,
    this.textInputAction,
    this.onChangedText,
    this.onSubmitted,
    this.onBlur,
    this.controller,
    this.focusNode,
    this.validator,
    this.formInputText,
    this.countryController,
  });

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  late final FocusNode _focusNode;
  late final TextEditingController _textEditingController;

  bool obscureText = false;

  final _errorText = ValueNotifier<String?>(null);

  bool _isFirstValidate = true;

  @override
  void initState() {
    _textEditingController = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    widget.formInputText?._registerValidate(_registerValidate);
    obscureText = widget.isPassword ?? false;
    if (widget.initValue != null) {
      _textEditingController.text = widget.initValue ?? '';
    }
    _textEditingController.addListener(() {
      widget.onChangedText?.call(_textEditingController.text);
    });
    if (widget.countryController?.text == '') {
      widget.countryController?.text = '+00';
    }

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        widget.onBlur?.call(_textEditingController.text);
      }
    });

    super.initState();
  }

  String? _registerValidate() {
    if (_isFirstValidate) {
      _textEditingController.addListener(_validate);
      _isFirstValidate = false;
    }
    _errorText.value = widget.validator?.call(_textEditingController.text);
    return _validate();
  }

  String? _validate() {
    _errorText.value = widget.validator?.call(_textEditingController.text);
    return _errorText.value;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
        buildWhen: (previous, current) => previous.theme != current.theme,
        builder: (context, state) {
          final theme = state.theme;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: widget.height ?? 48,
                child: TextField(
                  enabled: widget.enabled,
                  controller: _textEditingController,
                  textInputAction: widget.textInputAction,
                  onSubmitted: widget.onSubmitted,
                  autofocus: widget.autofocus,
                  onTapOutside: (val) {
                    _focusNode.unfocus();
                  },
                  style: AppTextStyle.s16w400.copyWith(
                    color: theme.colors.blackText,
                  ),
                  focusNode: _focusNode,
                  obscureText: obscureText,
                  keyboardType: widget.keyboardType,
                  maxLines: widget.maxLines,
                  minLines: widget.minLines,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    prefixIcon: widget.prefixIcon ?? buildCountryPicker(),
                    suffixIcon: widget.isPassword == true
                        ? InkWell(
                            onTap: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                            child: obscureText ? widget.suffixIconChangeOnTap : widget.suffixIcon,
                          )
                        : widget.suffixIcon,
                    suffixIconConstraints: const BoxConstraints(
                        minWidth: 46, minHeight: 15, maxHeight: 15, maxWidth: 46),
                    fillColor: theme.colors.inputBackground,
                    hoverColor: theme.colors.white,
                    hintText: widget.hintText,
                    hintStyle: AppTextStyle.s14w400.copyWith(color: theme.colors.hintText),
                    focusColor: theme.colors.primary,
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: theme.colors.primary),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    prefixIconColor: MaterialStateColor.resolveWith(
                      (states) => states.contains(MaterialState.focused)
                          ? theme.colors.primary
                          : _textEditingController.text.trim() == ''
                              ? theme.colors.grey
                              : theme.colors.black,
                    ),
                    suffixIconColor: MaterialStateColor.resolveWith(
                      (states) => states.contains(MaterialState.focused)
                          ? theme.colors.primary
                          : _textEditingController.text.trim() == ''
                              ? theme.colors.grey
                              : theme.colors.black,
                    ),
                  ),
                ),
              ),
              buildError(theme),
            ],
          );
        });
  }

  buildError(AppTheme theme) {
    return ValueListenableBuilder<String?>(
      valueListenable: _errorText,
      builder: (context, errorText, child) {
        return errorText != null
            ? Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Assets.icons.icWarning.svg(),
                    const SizedBox(width: 8),
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        errorText,
                        style: AppTextStyle.s14w400.copyWith(
                          color: theme.colors.blackText,
                        ),
                        textHeightBehavior: const TextHeightBehavior(
                          applyHeightToFirstAscent: false,
                          applyHeightToLastDescent: false,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : const SizedBox();
      },
    );
  }

  buildCountryPicker() {
    if (widget.countryController == null) {
      return null;
    }
    final theme = context.read<AppCubit>().state.theme;
    return InkWell(
      onTap: () {
        showCountry();
      },
      child: ValueListenableBuilder(
          valueListenable: widget.countryController!,
          builder: (context, value, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value.text,
                  style: AppTextStyle.s16w400.copyWith(
                    color: theme.colors.blackText,
                  ),
                ),
              ],
            );
          }),
    );
  }

  showCountry() {
    final theme = context.read<AppCubit>().state.theme;
    showCountryPicker(
      context: context,
      countryListTheme: CountryListThemeData(
        flagSize: 25,
        backgroundColor: Colors.white,
        textStyle: const TextStyle(fontSize: 16, color: Colors.blueGrey),
        bottomSheetHeight: 500, // Optional. Country list modal height
        //Optional. Sets the border radius for the bottomsheet.
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        //Optional. Styles the search field.
        inputDecoration: InputDecoration(
          hintText: 'Start typing to search',
          prefixIcon: const Icon(Icons.search),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: theme.colors.grey, width: 0.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: theme.colors.grey, width: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: theme.colors.grey, width: 0.5),
          ),
        ),
      ),
      onSelect: (Country country) {
        widget.countryController?.text = '+${country.phoneCode}';
      },
    );
  }
}

class FormInputText {
  final List<ValueGetter<String?>> _validators = [];

  void _registerValidate(ValueGetter<String?> onValidate) {
    _validators.add(onValidate);
  }

  bool validate() {
    bool hasError = false;
    for (var validator in _validators) {
      final result = validator();
      if (result != null) {
        hasError = true;
      }
    }
    return !hasError;
  }
}
