import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meory/data/models/entry/entry_model.dart';
import 'package:meory/presentations/widgets/base_widget.dart';

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
        title: const Text('Entries'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: cubit.onTapAdd,
          ),
        ],
      ),
      body: Column(
        children: [
          if (cubit.state.entries.isEmpty)
            const Center(child: Text('No entries found', textAlign: TextAlign.center))
          else
            Expanded(
              child: ListView.builder(
                itemCount: cubit.state.entries.length,
                itemBuilder: (context, index) {
                  final entry = cubit.state.entries[index];
                  return buildEntryItem(
                    entry,
                    theme,
                    () => cubit.onTapItem(entry),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  buildEntryItem(EntryModel entry, AppTheme theme, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: theme.colors.background,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: theme.colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  '${entry.headword} ${entry.partsOfSpeech == null ? '' : '(${entry.partsOfSpeech!.short})'}',
                  style: AppTextStyle.s20w500.withColor(theme.colors.blackText),
                ),
                const Spacer(),
                if (entry.score != null)
                  Text(
                    entry.score.toString(),
                    style: AppTextStyle.s20w500.withColor(entry.score! < 0
                        ? theme.colors.red
                        : entry.score! < 30
                            ? theme.colors.orange
                            : entry.score! < 70
                                ? theme.colors.yellow
                                : theme.colors.green),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(entry.definition ?? '',
                    style: AppTextStyle.s16w400.withColor(theme.colors.blackText)),
                const Spacer(),
                Text(
                  '${entry.numberOfSuccess} / ${entry.numberOfPlayed}',
                  style: AppTextStyle.s16w400.withColor(theme.colors.greyText),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
