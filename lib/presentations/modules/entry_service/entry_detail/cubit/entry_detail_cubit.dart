import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:meory/data/models/entry/entry_model.dart';
import 'package:meory/domain/usecases/entry/delete_entry_usecase.dart';
import 'package:meory/presentations/modules/home/cubit/home_cubit.dart';
import 'package:meory/presentations/routes.dart';
import 'package:meory/presentations/widgets/toast_widget.dart';

part 'entry_detail_state.dart';

class EntryDetailCubit extends CoreCubit<EntryDetailState> {
  final _deleteEntryUseCase = getIt<DeleteEntryUseCase>();
  EntryDetailCubit({required this.entry, this.callback}) : super(const EntryDetailState());

  final EntryModel entry;
  final VoidCallback? callback;

  Future<void> deleteEntry() async {
    emit(state.copyWith(isLoading: true, errorMessage: ''));
    final result = await _deleteEntryUseCase.execute(entryId: entry.id ?? '');
    result.ifSuccess(
      (data) {
        HomeCubit.neededRefreshData = true;
        Toast.showSuccess(
          "Entry deleted successfully",
        );
        callback?.call();
        emit(state.copyWith(isLoading: false));
        AppNavigator.pop();
      },
    );
    result.ifError(
      (error, dataError) {
        emit(state.copyWith(isLoading: false, errorMessage: error));
      },
    );
  }

  void onTapEdit() {
    AppNavigator.push(Routes.createEntry, {
      'entry': entry,
      'callback': callback,
    });
  }

  void onTapDelete(BuildContext context) {
    showConfirmDialog(context, content: 'Bạn có chắc chắn muốn xóa mục này?').then((value) {
      if (value == true) {
        deleteEntry();
      }
    });
  }

  Future<bool?> showConfirmDialog(
    BuildContext context, {
    String title = 'Xác nhận',
    String content = 'Bạn có chắc chắn muốn tiếp tục?',
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Không'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Có'),
          ),
        ],
      ),
    );
  }
}
