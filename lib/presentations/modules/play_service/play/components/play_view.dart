import 'dart:ui';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meory/data/models/entry/entry_model.dart';
import 'package:meory/presentations/routes.dart';
import 'package:meory/presentations/utils/app_utils.dart';
import 'package:meory/presentations/widgets/base_widget.dart';
import 'package:meory/presentations/widgets/button_widget/primary_button.dart';
import 'package:meory/presentations/widgets/text_highlight.dart';

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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: [
                Icon(Icons.emoji_events, color: theme.colors.primary),
                const SizedBox(width: 8),
                Text(
                  'Score',
                  style: AppTextStyle.s16w600.copyWith(color: theme.colors.primary),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                if (cubit.state.isLoading)
                  const SizedBox()
                else if (cubit.state.entries.length < 4)
                  _buildEmptyState(cubit, theme)
                else ...[
                  _buildProgressIndicator(cubit, theme),
                  Expanded(
                    child: Column(
                      children: [
                        const Spacer(flex: 2),
                        _buildQuestionCard(currentEntry, theme),
                        const Spacer(flex: 1),
                        _buildCountdown(cubit.state.countdown, theme),
                        const Spacer(flex: 2),
                        _buildSpeakButton(cubit, theme),
                        const SizedBox(height: 8),
                        _buildAnswerOptions(cubit, currentEntry, theme, context),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ]
              ],
            ),
          ),
          if (cubit.state.isPause) _buildPauseOverlay(cubit, theme),
        ],
      ),
    );
  }

  Widget _buildPauseOverlay(PlayCubit cubit, AppTheme theme) {
    return Container(
      color: Colors.black.withOpacity(0.7),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: theme.colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: theme.colors.primary.withOpacity(0.2),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.pause_circle_outline,
                  size: 64,
                  color: theme.colors.primary,
                ),
                const SizedBox(height: 16),
                Text(
                  'Tạm dừng',
                  style: AppTextStyle.s24w600.copyWith(
                    color: theme.colors.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Bạn có muốn tiếp tục?',
                  style: AppTextStyle.s16w400.copyWith(
                    color: theme.colors.greyText,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: AppNavigator.pop,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Thoát',
                          style: AppTextStyle.s16w500.copyWith(
                            color: theme.colors.red,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: cubit.onResume,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              theme.colors.primary,
                              theme.colors.primary.withOpacity(0.8),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: theme.colors.primary.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Text(
                          'Tiếp tục',
                          style: AppTextStyle.s16w500.copyWith(
                            color: theme.colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(PlayCubit cubit, AppTheme theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.library_books,
            size: 64,
            color: theme.colors.primary.withOpacity(0.5),
          ),
          const SizedBox(height: 24),
          Text(
            'Số lượng từ không đủ để chơi (${cubit.state.entries.length}/4)',
            style: AppTextStyle.s16w500.copyWith(color: theme.colors.primaryText),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          PrimaryButton(
            onTap: cubit.onTapAdd,
            title: "Thêm từ mới",
            icon: Icon(Icons.add, color: theme.colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator(PlayCubit cubit, AppTheme theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          LinearProgressIndicator(
            value: (cubit.state.currentIndex + 1) / cubit.state.entries.length,
            backgroundColor: theme.colors.primary.withOpacity(0.1),
            valueColor: AlwaysStoppedAnimation<Color>(theme.colors.primary),
            borderRadius: BorderRadius.circular(10),
            minHeight: 8,
          ),
          if (cubit.state.countAdded > 0)
            Positioned(
              right: 0,
              top: 12,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: theme.colors.primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '+${cubit.state.countAdded}',
                  style: AppTextStyle.s14w500.copyWith(color: theme.colors.primary),
                ),
              ),
            )
        ],
      ),
    );
  }

  Widget _buildQuestionCard(EntryModel? currentEntry, AppTheme theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: theme.colors.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colors.primary.withOpacity(0.1),
        ),
      ),
      child: Column(
        children: [
          Text(
            currentEntry?.headword ?? '',
            style: AppTextStyle.s32w700.copyWith(
              color: theme.colors.primary,
              letterSpacing: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
          if (currentEntry?.pronunciation != null && currentEntry!.pronunciation!.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              AppUtils.showPronunciation(currentEntry.pronunciation),
              style: AppTextStyle.s16w400.copyWith(
                color: theme.colors.primary,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
          if (currentEntry?.partsOfSpeech != null) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: theme.colors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                currentEntry!.partsOfSpeech!.short,
                style: AppTextStyle.s14w500.copyWith(
                  color: theme.colors.primary,
                ),
              ),
            ),
          ],
          if (currentEntry?.example != null && currentEntry!.score! < MasteryE.expert.mark) ...[
            const SizedBox(height: 16),
            TextHighlight(
              text: '"${currentEntry.example}"',
              highlightText: currentEntry.headword ?? 'dsfsdfsdc',
              textStyle: AppTextStyle.s16w400.copyWith(
                color: theme.colors.primary,
                fontStyle: FontStyle.italic,
              ),
              highlightStyle: AppTextStyle.s16w600.copyWith(
                color: theme.colors.red,
                fontStyle: FontStyle.italic,
              ),
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildSpeakButton(PlayCubit cubit, AppTheme theme) {
    return GestureDetector(
      onTap: cubit.speak,
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.only(left: 12),
        decoration: BoxDecoration(
          color: theme.colors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          Icons.volume_up,
          color: theme.colors.primary,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildAnswerOptions(
    PlayCubit cubit,
    EntryModel? currentEntry,
    AppTheme theme,
    BuildContext context,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Text(
            'Choose the correct definition',
            style: AppTextStyle.s14w500.copyWith(
              color: theme.colors.greyText,
            ),
          ),
          const SizedBox(height: 16),
          Column(
            children: [
              ...List.generate(
                (cubit.state.randomAnswers.length / 2).ceil(),
                (index) {
                  return IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: cubit.state.randomAnswers
                          .sublist((index) * 2, (index) * 2 + 2)
                          .map((entry) {
                        final isCorrect = entry.id == currentEntry?.id;
                        final isSelected = entry.id == cubit.answerSelected.id;

                        return Expanded(
                          child: GestureDetector(
                            onTap: cubit.state.isShowAnswer ? null : () => cubit.onTapAnswer(entry),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                              margin: const EdgeInsets.only(bottom: 12, right: 6, left: 6),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: cubit.state.isShowAnswer
                                    ? isSelected
                                        ? isCorrect
                                            ? theme.colors.green.withOpacity(0.9)
                                            : theme.colors.red.withOpacity(0.9)
                                        : isCorrect
                                            ? theme.colors.green.withOpacity(0.9)
                                            : theme.colors.primary.withOpacity(0.9)
                                    : theme.colors.primary.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: theme.colors.primary.withOpacity(0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Text(
                                entry.definition ?? '',
                                textAlign: TextAlign.center,
                                style: AppTextStyle.s16w500.copyWith(
                                  color: theme.colors.white,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCountdown(int countdown, AppTheme theme) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 1.0, end: 0.0),
      duration: const Duration(seconds: 1),
      key: ValueKey(countdown),
      builder: (context, value, child) {
        return Opacity(
          opacity: countdown > 0 ? 1 : 0,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: theme.colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: theme.colors.primary.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: value,
                  strokeWidth: 4,
                  backgroundColor: theme.colors.primary.withOpacity(0.1),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    countdown <= 2 ? theme.colors.red.withOpacity(0.5) : theme.colors.primary,
                  ),
                ),
                Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return ScaleTransition(
                        scale: animation,
                        child: FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                      );
                    },
                    child: Text(
                      '$countdown',
                      key: ValueKey(countdown),
                      style: AppTextStyle.s24w600.copyWith(
                        color: countdown <= 2
                            ? theme.colors.red.withOpacity(0.5)
                            : theme.colors.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
