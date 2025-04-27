import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                  return ListTile(
                    title: Text(entry.headword ?? ''),
                    subtitle: Text(
                        '${entry.definition} - Tỉ lệ: ${entry.numberOfSuccess}/${entry.numberOfPlayed} - Điểm: ${entry.score}'),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
