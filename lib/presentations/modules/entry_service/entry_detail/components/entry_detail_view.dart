import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meory/presentations/widgets/base_widget.dart';

import '../cubit/entry_detail_cubit.dart';

class EntryDetailView extends BaseWidget<EntryDetailCubit, EntryDetailState> {
  const EntryDetailView({super.key});

  @override
  Widget build(BuildContext context, AppTheme theme, AppLocalizations tr) {
    final cubit = context.watch<EntryDetailCubit>();

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        title: const Text('Chi tiết'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: cubit.onTapEdit,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => cubit.onTapDelete(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header section (existing code)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: theme.colors.primary.withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    cubit.entry.headword ?? '',
                    style: AppTextStyle.s32w700.copyWith(
                      color: theme.colors.primary,
                      letterSpacing: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  if (cubit.entry.pronunciation != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "/${cubit.entry.pronunciation}/",
                        style: AppTextStyle.s16w400.copyWith(
                          color: theme.colors.primary,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Content section
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow(
                    theme,
                    icon: Icons.category,
                    label: 'Loại từ:',
                    content: cubit.entry.partsOfSpeech?.name ?? '',
                  ),
                  const SizedBox(height: 24),
                  _buildInfoRow(
                    theme,
                    icon: Icons.description,
                    label: 'Định nghĩa:',
                    content: cubit.entry.definition ?? '',
                  ),
                  if (cubit.entry.description != null && cubit.entry.description!.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    _buildInfoRow(
                      theme,
                      icon: Icons.info_outline,
                      label: 'Mô tả:',
                      content: cubit.entry.description!,
                    ),
                  ],
                  if (cubit.entry.note != null && cubit.entry.note!.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    _buildInfoRow(
                      theme,
                      icon: Icons.sticky_note_2_outlined,
                      label: 'Ghi chú:',
                      content: cubit.entry.note!,
                      contentStyle: AppTextStyle.s16w400.copyWith(
                        color: theme.colors.primary,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      if (cubit.entry.category != null && cubit.entry.category!.isNotEmpty)
                        Expanded(
                          child: _buildCategoryChip(
                            theme,
                            icon: Icons.folder_outlined,
                            label: cubit.entry.category ?? '',
                          ),
                        ),
                      if (cubit.entry.topic != null && cubit.entry.topic!.isNotEmpty) ...[
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildCategoryChip(
                            theme,
                            icon: Icons.label_outline,
                            label: cubit.entry.topic ?? '',
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    AppTheme theme, {
    required IconData icon,
    required String label,
    required String content,
    TextStyle? contentStyle,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colors.primary.withOpacity(.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: theme.colors.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                label,
                style: AppTextStyle.s14w600.copyWith(
                  color: theme.colors.primaryText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 28),
            child: Text(
              content,
              style: contentStyle ??
                  AppTextStyle.s16w400.copyWith(
                    color: theme.colors.blackText,
                    height: 1.5,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(
    AppTheme theme, {
    required IconData icon,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: theme.colors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: theme.colors.primary,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: AppTextStyle.s14w500.copyWith(
                color: theme.colors.primary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
