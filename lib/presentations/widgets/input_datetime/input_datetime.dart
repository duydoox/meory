import 'package:meory/app/app_cubit.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class InputDatetime extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? initialValue;
  final DateFormat dateFormat;
  final bool enabled;
  const InputDatetime(
      {super.key,
      this.controller,
      this.hintText,
      this.initialValue,
      required this.dateFormat,
      this.enabled = true});

  @override
  State<InputDatetime> createState() => _InputDatetimeState();
}

class _InputDatetimeState extends State<InputDatetime> {
  late final TextEditingController _controller;
  DateTime? _dateTime;
  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.text = widget.initialValue ?? '';
    convertDate();
    _controller.addListener(() {
      convertDate();
      setState(() {});
    });
  }

  convertDate() {
    try {
      _dateTime = widget.dateFormat.parse(_controller.text);
    } catch (e) {
      _dateTime = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.read<AppCubit>().state.theme;

    return Column(
      children: [
        InkWell(
          onTap: widget.enabled ? _showDatePicker : null,
          child: Container(
            height: 48,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: theme.colors.inputBackground,
              borderRadius: BorderRadius.circular(10),
            ),
            child: _dateTime == null
                ? Text(
                    widget.hintText ?? '',
                    style: AppTextStyle.s14w400.copyWith(
                      color: theme.colors.hintText,
                    ),
                  )
                : Text(
                    _controller.text,
                    style: AppTextStyle.s14w400.copyWith(
                      color: theme.colors.blackText,
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  _showDatePicker() {
    final appState = context.read<AppCubit>().state;
    final theme = appState.theme;
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          child: SizedBox(
            height: 420,
            child: SingleChildScrollView(
              child: TableCalendar(
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: theme.colors.primary, width: 1),
                  ),
                  todayTextStyle: AppTextStyle.s14w400.copyWith(
                    color: Colors.black,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: theme.colors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
                locale: appState.locale?.languageCode,
                firstDay: DateTime.utc(2000, 1, 1),
                lastDay: DateTime.utc(2100, 1, 1),
                focusedDay: _dateTime ?? DateTime.now(),
                selectedDayPredicate: (day) => isSameDay(day, _dateTime),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _dateTime = selectedDay;
                    _controller.text = widget.dateFormat.format(selectedDay);
                  });
                  Navigator.pop(context);
                },
                availableCalendarFormats: const {
                  CalendarFormat.month: '',
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
