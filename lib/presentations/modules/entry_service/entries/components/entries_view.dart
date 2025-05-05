import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meory/data/models/entry/entry_model.dart';
import 'package:meory/presentations/service/tts_service.dart';
import 'package:meory/presentations/utils/app_utils.dart';
import 'package:meory/presentations/widgets/base_widget.dart';
import 'package:meory/presentations/widgets/button_widget/primary_button.dart';
import 'package:meory/presentations/widgets/input_text/input_text.dart';

import '../cubit/entries_cubit.dart';

class EntriesView extends BaseWidget<EntriesCubit, EntriesState> {
  const EntriesView({super.key});

  @override
  void onInit(BuildContext context) {
    final cubit = context.read<EntriesCubit>();
    cubit.getEntries();
    super.onInit(context);
  }

  @override
  Widget build(BuildContext context, AppTheme theme, AppLocalizations tr) {
    final cubit = context.watch<EntriesCubit>();
    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        title: cubit.state.isSearching
            ? InputText(
                controller: cubit.searchController,
                hintText: 'Nhập từ khóa tìm kiếm',
                autofocus: true,
                onSubmitted: cubit.onSearch,
              )
            : Text(
                'Từ vựng của bạn',
                style: AppTextStyle.s18w600.copyWith(color: theme.colors.primary),
              ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              cubit.state.isSearching ? Icons.close : Icons.search,
              color: theme.colors.primary,
            ),
            onPressed: cubit.onTapIconSearch,
          ),
          IconButton(
            icon: Icon(Icons.add, color: theme.colors.primary),
            onPressed: cubit.onTapAdd,
          ),
        ],
      ),
      body: Column(
        children: [
          if (cubit.state.isLoading)
            const SizedBox()
          else if (cubit.state.entries.isEmpty)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.library_books,
                    size: 64,
                    color: theme.colors.primary.withOpacity(0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Chưa có từ vựng nào',
                    style: AppTextStyle.s16w500.copyWith(
                      color: theme.colors.primaryText,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: PrimaryButton(
                      onTap: cubit.onTapAdd,
                      title: "Thêm từ mới",
                      icon: Icon(Icons.add, color: theme.colors.white),
                    ),
                  ),
                ],
              ),
            )
          else
            Expanded(
              child: cubit.state.isSearched
                  ? ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      itemCount: cubit.state.entriesSearch.length,
                      itemBuilder: (context, index) {
                        final entry = cubit.state.entriesSearch[index];
                        return buildEntryItem(entry, theme, () => cubit.onTapItem(entry));
                      },
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      itemCount: cubit.state.entries.length,
                      itemBuilder: (context, index) {
                        final entry = cubit.state.entries[index];
                        return buildEntryItem(entry, theme, () => cubit.onTapItem(entry));
                      },
                    ),
            ),
        ],
      ),
    );
  }

  Widget buildEntryItem(EntryModel entry, AppTheme theme, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: theme.colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: theme.colors.primary.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entry.headword ?? '',
                            style: AppTextStyle.s20w600.copyWith(
                              color: theme.colors.primary,
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(
                            height: 18,
                            child: IconButton(
                              icon: Icon(
                                Icons.volume_up_rounded,
                                color: theme.colors.primary,
                                size: 20,
                              ),
                              onPressed: () {
                                TtsService().speak(entry.headword ?? '');
                              },
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ),
                        ],
                      ),
                      if (entry.pronunciation != null && entry.pronunciation!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            AppUtils.showPronunciation(entry.pronunciation),
                            style: AppTextStyle.s14w400.copyWith(
                              color: theme.colors.greyText,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                if (entry.score != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getScoreColor(entry.score!, theme).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      entry.score.toString(),
                      style: AppTextStyle.s16w600.copyWith(
                        color: _getScoreColor(entry.score!, theme),
                      ),
                    ),
                  ),
              ],
            ),
            if (entry.partsOfSpeech != null) ...[
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: theme.colors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  entry.partsOfSpeech!.short,
                  style: AppTextStyle.s12w400.copyWith(
                    color: theme.colors.primary,
                  ),
                ),
              ),
            ],
            const SizedBox(height: 8),
            Text(
              entry.definition ?? '',
              style: AppTextStyle.s16w400.copyWith(
                color: theme.colors.blackText,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.psychology,
                  size: 16,
                  color: theme.colors.greyText,
                ),
                const SizedBox(width: 4),
                Text(
                  '${entry.numberOfSuccess}/${entry.numberOfPlayed}',
                  style: AppTextStyle.s14w500.copyWith(
                    color: theme.colors.greyText,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getScoreColor(int score, AppTheme theme) {
    if (score < 0) return theme.colors.red;
    if (score < 30) return theme.colors.orange;
    if (score < 70) return theme.colors.yellow;
    return theme.colors.green;
  }
}
