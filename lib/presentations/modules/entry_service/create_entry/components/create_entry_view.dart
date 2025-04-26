import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meory/data/models/entry/entry_model.dart';
import 'package:meory/presentations/widgets/base_widget.dart';
import 'package:meory/presentations/widgets/input_dropdown/input_dropdown.dart';
import 'package:meory/presentations/widgets/input_text/input_text.dart';

import '../cubit/create_entry_cubit.dart';

class CreateEntryView extends BaseWidget<CreateEntryCubit, CreateEntryState> {
  const CreateEntryView({super.key});

  @override
  Widget build(BuildContext context, AppTheme theme, AppLocalizations tr) {
    final cubit = context.watch<CreateEntryCubit>();
    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(title: const Text('Example')),
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
              InputDropdown(
                hintText: 'Parts of Speech',
                values: PartsOfSpeechE.values.map((e) => e.index.toString()).toList(),
                controller: cubit.partsOfSpeechController,
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
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  cubit.createEntry();
                },
                child: const Text("Thêm mới"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
