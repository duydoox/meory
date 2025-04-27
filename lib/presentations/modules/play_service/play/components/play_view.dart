import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meory/presentations/widgets/base_widget.dart';

import '../cubit/play_cubit.dart';

class PlayView extends BaseWidget<PlayCubit, PlayState> {
  const PlayView({super.key});

  @override
  void onInit(BuildContext context) {
    final cubit = context.read<PlayCubit>();
    cubit.getEntries();
    super.onInit(context);
  }

  @override
  Widget build(BuildContext context, AppTheme theme, AppLocalizations tr) {
    final cubit = context.watch<PlayCubit>();
    final currentEntry = cubit.state.entries.elementAtOrNull(cubit.state.currentIndex);
    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            if (cubit.state.entries.isEmpty)
              const Center(child: Text('No entries available'))
            else ...[
              Container(
                alignment: Alignment.center,
                height: 200,
                child: Text(currentEntry?.headword ?? '',
                    style: AppTextStyle.s32w700.withColor(theme.colors.primaryText)),
              ),
              const Spacer(),
              Wrap(
                children: cubit.state.randomAnswers.map((entry) {
                  final isCorrect = entry.id == currentEntry?.id;
                  final isSelected = entry.id == cubit.answerSelected.id;
                  return GestureDetector(
                    onTap: cubit.state.isShowAnswer ? null : () => cubit.onTapAnswer(entry),
                    child: Container(
                      width: Utils.getWidth(context) / 2 - 20,
                      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
                      decoration: BoxDecoration(
                        color: cubit.state.isShowAnswer
                            ? isSelected
                                ? isCorrect
                                    ? theme.colors.green
                                    : theme.colors.red
                                : theme.colors.primary
                            : theme.colors.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        entry.definition ?? '',
                        textAlign: TextAlign.center,
                        style: AppTextStyle.s16w500.withColor(theme.colors.white),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 50),
            ]
          ],
        ),
      ),
    );
  }
}
