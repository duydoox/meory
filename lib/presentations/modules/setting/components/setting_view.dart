import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meory/app/app_cubit.dart';
import 'package:meory/presentations/widgets/base_widget.dart';

import '../cubit/setting_cubit.dart';

class SettingView extends BaseWidget<SettingCubit, SettingState> {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context, AppTheme theme, AppLocalizations tr) {
    final cubit = context.watch<SettingCubit>();
    final appCubit = context.watch<AppCubit>();

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        title: Text(
          'Cài đặt',
          style: AppTextStyle.s18w600.copyWith(
            color: theme.colors.primary,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTitle('Giao diện', theme),
          const SizedBox(height: 16),
          _buildThemeSelector(appCubit, theme),
          const SizedBox(height: 24),
          // Add more settings sections here
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, AppTheme theme) {
    return Text(
      title,
      style: AppTextStyle.s16w600.copyWith(
        color: theme.colors.primary,
      ),
    );
  }

  Widget _buildThemeSelector(AppCubit cubit, AppTheme theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.colors.primary.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.palette_outlined,
                color: theme.colors.primary,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Chọn chủ đề',
                style: AppTextStyle.s16w500.copyWith(
                  color: theme.colors.primaryText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: AppThemeMode.values.map((themeMode) {
                final isSelected = cubit.state.themeMode == themeMode;
                final colors = AppTheme(themeMode).colors;
                return GestureDetector(
                  onTap: () => cubit.changeThemeMode(themeMode),
                  child: Container(
                    width: 80,
                    margin: const EdgeInsets.only(right: 12),
                    child: Column(
                      children: [
                        Container(
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: colors.primary.withOpacity(isSelected ? 1 : 0.2),
                              width: 2,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Stack(
                              children: [
                                if (isSelected)
                                  Container(
                                    color: theme.colors.primary.withOpacity(0.2),
                                    child: Center(
                                      child: Icon(
                                        Icons.check_circle,
                                        color: theme.colors.primary,
                                        size: 28,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          themeMode.name,
                          style: AppTextStyle.s14w400.copyWith(
                            color: isSelected ? theme.colors.primary : theme.colors.greyText,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

extension ThemeModeName on AppThemeMode {
  String get name {
    switch (this) {
      case AppThemeMode.light:
        return 'Hồng';
      case AppThemeMode.dark:
        return 'Tối';
      case AppThemeMode.blueLight:
        return 'Xanh';
      default:
        return 'Mặc định';
    }
  }
}
