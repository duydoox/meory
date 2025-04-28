import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meory/data/models/entry/entry_model.dart';
import 'package:meory/presentations/widgets/base_widget.dart';
import 'package:meory/presentations/widgets/button_widget/primary_button.dart';
import 'package:meory/presentations/widgets/input_dropdown/input_dropdown.dart';
import 'package:meory/presentations/widgets/input_text/input_text.dart';

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
      body: SingleChildScrollView(
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
              _buildSectionTitle('Mô tả', theme),
              const SizedBox(height: 4),
              InputText(
                hintText: 'Nhập mô tả',
                controller: cubit.descriptionController,
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

  InputDecoration _inputDecoration(AppTheme theme) {
    return InputDecoration(
      filled: true,
      fillColor: theme.colors.primary.withOpacity(0.05),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: theme.colors.primary.withOpacity(0.1),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: theme.colors.primary.withOpacity(0.1),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: theme.colors.primary,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
    );
  }
}
