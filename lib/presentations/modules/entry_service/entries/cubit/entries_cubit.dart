import 'package:core/core.dart';
import 'package:meory/data/models/entry/entry_model.dart';
import 'package:meory/domain/usecases/entry/get_entries_usecase.dart';
import 'package:meory/presentations/routes.dart';

part 'entries_state.dart';

class EntriesCubit extends CoreCubit<EntriesState> {
  final GetEntriesUseCase _getEntriesUseCase = getIt<GetEntriesUseCase>();
  EntriesCubit() : super(const EntriesState());

  Future<void> getEntries() async {
    emit(state.copyWith(isLoading: true, errorMessage: ''));
    final result = await _getEntriesUseCase.execute();
    result.ifSuccess(
      (data) {
        emit(state.copyWith(isLoading: false, entries: data));
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
}
