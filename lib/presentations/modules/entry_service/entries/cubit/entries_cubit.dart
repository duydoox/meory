import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:meory/data/models/entry/entry_model.dart';
import 'package:meory/domain/usecases/entry/get_entries_usecase.dart';
import 'package:meory/presentations/routes.dart';

part 'entries_state.dart';

class EntriesCubit extends CoreCubit<EntriesState> {
  final GetEntriesUseCase _getEntriesUseCase = getIt<GetEntriesUseCase>();
  EntriesCubit() : super(const EntriesState());

  final searchController = TextEditingController();

  Future<void> getEntries() async {
    emit(state.copyWith(isLoading: true, errorMessage: ''));
    final result = await _getEntriesUseCase.execute(limit: 1000);
    result.ifSuccess(
      (data) {
        emit(state.copyWith(isLoading: false, entries: data));
        if (state.isSearched) {
          onSearch(searchController.text);
        }
      },
    );
    result.ifError(
      (error, dataError) {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: error ?? 'Error retrieving entries',
          ),
        );
      },
    );
  }

  onSearch(String value) {
    if (value.isEmpty) {
      emit(state.copyWith(entriesSearch: [], isSearched: true));
      return;
    }
    final filteredEntries = state.entries
        .where((entry) =>
            (entry.headword?.toLowerCase().contains(value.trim().toLowerCase()) ?? false) ||
            (entry.definition?.toLowerCase().contains(value.trim().toLowerCase()) ?? false))
        .toList();
    emit(state.copyWith(entriesSearch: filteredEntries, isSearched: true));
  }

  onTapItem(EntryModel entry) {
    AppNavigator.push(Routes.entryDetail, {
      'entry': entry,
      'callback': getEntries,
    });
  }

  onTapAdd() {
    AppNavigator.push(Routes.createEntry, {
      'callback': getEntries,
    });
  }

  onTapIconSearch() {
    if (state.isSearching) {
      searchController.clear();
      onSearch('');
      emit(state.copyWith(isSearched: false));
    }
    emit(state.copyWith(isSearching: !state.isSearching));
  }
}
