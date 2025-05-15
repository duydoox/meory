import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meory/data/models/entry/entry_model.dart';
import 'package:meory/presentations/utils/app_utils.dart';
import 'package:meory/presentations/widgets/base_widget.dart';
import 'package:meory/presentations/widgets/button_widget/primary_button.dart';
import 'package:meory/presentations/widgets/input_dropdown/input_dropdown.dart';
import 'package:meory/presentations/widgets/input_text/input_text.dart';
import 'package:meory/presentations/widgets/text_highlight.dart';

import '../cubit/create_entry_cubit.dart';

class CreateEntryView extends BaseWidget<CreateEntryCubit, CreateEntryState> {
  const CreateEntryView({super.key});

  @override
  void onInit(BuildContext context) {
    final cubit = context.read<CreateEntryCubit>();
    cubit.init();
    super.onInit(context);
  }

  @override
  Widget build(BuildContext context, AppTheme theme, AppLocalizations tr) {
    final cubit = context.watch<CreateEntryCubit>();
    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        title: Text(
          cubit.isEdit ? 'Chỉnh sửa từ vựng' : 'Thêm từ vựng mới',
          style: AppTextStyle.s18w600,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocListener<CreateEntryCubit, CreateEntryState>(
        listenWhen: (previous, current) =>
            previous.prompts != current.prompts || previous.entriesExist != current.entriesExist,
        listener: (context, state) {
          if (state.prompts.isNotEmpty) {
            _showPromptsDialog(cubit, theme, context);
          }
          if (state.entriesExist.isNotEmpty) {
            _showEntriesExist(cubit, theme, context);
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle('Từ vựng *', theme),
                const SizedBox(height: 4),
                InputText(
                  hintText: 'Nhập từ vựng',
                  controller: cubit.headwordController,
                  suffixIcon: GestureDetector(
                    onTap: () => cubit.getPromptWord(),
                    child: const Icon(Icons.search),
                  ),
                ),
                const SizedBox(height: 8),
                _buildSectionTitle('Định nghĩa *', theme),
                const SizedBox(height: 4),
                InputText(
                  hintText: 'Nhập định nghĩa',
                  controller: cubit.definitionController,
                ),
                const SizedBox(height: 8),
                _buildSectionTitle('Loại từ', theme),
                const SizedBox(height: 4),
                InputDropdown<PartsOfSpeechE>(
                  hintText: 'Chọn loại từ',
                  values: PartsOfSpeechE.values,
                  controller: cubit.partsOfSpeechController,
                  display: (item) => item.name,
                ),
                const SizedBox(height: 8),
                _buildSectionTitle('Phát âm', theme),
                const SizedBox(height: 4),
                InputText(
                  hintText: 'Nhập phát âm',
                  controller: cubit.pronunciationController,
                ),
                const SizedBox(height: 8),
                _buildSectionTitle('Danh mục', theme),
                const SizedBox(height: 4),
                InputText(
                  hintText: 'Nhập danh mục',
                  controller: cubit.categoryController,
                ),
                const SizedBox(height: 8),
                _buildSectionTitle('Chủ đề', theme),
                const SizedBox(height: 4),
                InputText(
                  hintText: 'Nhập chủ đề',
                  controller: cubit.topicController,
                ),
                const SizedBox(height: 8),
                _buildSectionTitle('Ví dụ', theme),
                const SizedBox(height: 4),
                InputText(
                  hintText: 'Nhập ví dụ',
                  controller: cubit.exampleController,
                ),
                const SizedBox(height: 8),
                _buildSectionTitle('Ghi chú', theme),
                const SizedBox(height: 4),
                InputText(
                  hintText: 'Nhập ghi chú',
                  controller: cubit.noteController,
                ),
                const SizedBox(height: 32),
                PrimaryButton(
                  onTap: cubit.onTapSubmit,
                  title: cubit.isEdit ? 'Lưu thay đổi' : 'Thêm từ mới',
                  width: double.infinity,
                  height: 52,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, AppTheme theme) {
    return Text(
      title,
      style: AppTextStyle.s14w600.copyWith(
        color: theme.colors.primary,
        letterSpacing: 0.5,
      ),
    );
  }

  void _showPromptsDialog(CreateEntryCubit cubit, AppTheme theme, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.9,
            maxWidth: MediaQuery.of(context).size.width * 0.9,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Gợi ý',
                        style: AppTextStyle.s18w600.copyWith(
                          color: theme.colors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(color: theme.colors.primary.withOpacity(0.1)),
              Flexible(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: cubit.state.prompts.length,
                  itemBuilder: (context, index) {
                    final prompt = cubit.state.prompts[index];
                    return InkWell(
                      onTap: () {
                        cubit.onTapPrompt(prompt);
                        Navigator.pop(context);
                      },
                      child: _buildEntriesItem(prompt, cubit, theme),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEntriesExist(CreateEntryCubit cubit, AppTheme theme, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.9,
            maxWidth: MediaQuery.of(context).size.width * 0.9,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Tìm thấy từ vựng đã tồn tại',
                        style: AppTextStyle.s18w600.copyWith(
                          color: theme.colors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(color: theme.colors.primary.withOpacity(0.1)),
              Flexible(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: cubit.state.entriesExist.length,
                  itemBuilder: (context, index) {
                    final entry = cubit.state.entriesExist[index];
                    return _buildEntriesItem(entry, cubit, theme);
                  },
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: PrimaryButton(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        title: 'Đóng',
                        backgroundColor: theme.colors.white,
                        titleColor: theme.colors.primaryText,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: PrimaryButton(
                        onTap: () {
                          Navigator.pop(context);
                          cubit.createEntry();
                        },
                        title: 'Thêm mới',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  _buildEntriesItem(EntryModel entry, CreateEntryCubit cubit, AppTheme theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: theme.colors.primary.withOpacity(0.1),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  entry.headword ?? '',
                  style: AppTextStyle.s18w600.copyWith(
                    color: theme.colors.primary,
                  ),
                ),
              ),
              if (entry.partsOfSpeech != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    entry.partsOfSpeech!.short,
                    style: AppTextStyle.s12w400.copyWith(
                      color: theme.colors.primary,
                    ),
                  ),
                ),
            ],
          ),
          if (entry.pronunciation != null)
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
          if (entry.definition != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                entry.definition!,
                style: AppTextStyle.s14w400.copyWith(
                  color: theme.colors.blackText,
                  height: 1.4,
                ),
              ),
            ),
          if (entry.example != null)
            TextHighlight(
              text: '"${entry.example}"',
              highlightText: entry.headword ?? '',
              textStyle: AppTextStyle.s12w400
                  .copyWith(color: theme.colors.primary, fontStyle: FontStyle.italic),
              highlightStyle: AppTextStyle.s12w600
                  .copyWith(color: theme.colors.red, fontStyle: FontStyle.italic),
            ),
        ],
      ),
    );
  }
}
