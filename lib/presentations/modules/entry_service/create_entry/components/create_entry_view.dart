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
      appBar: AppBar(title: Text(cubit.isEdit ? 'Chỉnh sửa' : 'Thêm mới')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              InputText(
                hintText: 'Headword',
                controller: cubit.headwordController,
              ),
              const SizedBox(height: 8),
              InputText(
                hintText: 'Definition',
                controller: cubit.definitionController,
              ),
              const SizedBox(height: 8),
              InputDropdown<PartsOfSpeechE>(
                hintText: 'Parts of Speech',
                values: PartsOfSpeechE.values,
                controller: cubit.partsOfSpeechController,
                display: (item) => item.name,
              ),
              const SizedBox(height: 8),
              InputText(
                hintText: 'Pronunciation',
                controller: cubit.pronunciationController,
              ),
              const SizedBox(height: 8),
              InputText(
                hintText: 'Category',
                controller: cubit.categoryController,
              ),
              const SizedBox(height: 100),
              PrimaryButton(
                onTap: cubit.onTapSubmit,
                title: cubit.isEdit ? 'Sửa' : 'Thêm mới',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
