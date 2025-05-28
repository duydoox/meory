import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meory/app/app_cubit.dart';
import 'package:meory/presentations/modules/home/components/home_listener.dart';
import 'package:meory/presentations/modules/home/cubit/home_cubit.dart';
import 'package:meory/presentations/modules/statistic/components/statistic_chart.dart';
import 'package:meory/presentations/routes.dart';
import 'package:meory/presentations/widgets/base_widget.dart';
import 'package:meory/presentations/widgets/button_widget/primary_button.dart';

class HomeView extends BaseWidget<HomeCubit, HomeState> {
  const HomeView({super.key});

  @override
  void onInit(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    cubit.getHomeData();
    super.onInit(context);
  }

  @override
  Widget build(BuildContext context, AppTheme theme, AppLocalizations tr) {
    final cubit = context.read<HomeCubit>();
    final appCubit = context.read<AppCubit>();

    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      return Scaffold(
        backgroundColor: theme.colors.background,
        appBar: _buildAppBar(appCubit, theme, cubit, context),
        body: PopScope(
          canPop: false,
          child: RefreshIndicator(
            onRefresh: cubit.getHomeData,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HomeListener(),
                    _buildStatsCard(theme, cubit),
                    const SizedBox(height: 24),
                    _buildQuickActions(theme, context, cubit),
                    if (cubit.state.listStatisticalByDay.isNotEmpty) ...[
                      const SizedBox(height: 24),
                      Text(
                        'Statistical',
                        style: AppTextStyle.s18w600.copyWith(color: theme.colors.primaryText),
                      ),
                      StatisticChart(listStatisticalByDay: cubit.state.listStatisticalByDay),
                    ],

                    const SizedBox(height: 60), // Space for FAB
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: _buildPlayButton(theme, context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
    });
  }

  PreferredSize _buildAppBar(
      AppCubit appCubit, AppTheme theme, HomeCubit cubit, BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colors.white,
          boxShadow: [
            BoxShadow(
              color: theme.colors.primary.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: AppBar(
          backgroundColor: theme.colors.white,
          elevation: 0,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome back,",
                style: AppTextStyle.s14w400.copyWith(color: theme.colors.greyText),
              ),
              Text(
                appCubit.state.firebaseUser?.displayName ?? "User",
                style: AppTextStyle.s18w600.copyWith(color: theme.colors.primary),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () => cubit.showMenu(context),
              icon: Icon(
                Icons.menu,
                color: theme.colors.primary,
                size: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCard(AppTheme theme, HomeCubit cubit) {
    final stats = cubit.state.statisticalModel;
    final successRate = stats.numberOfPlayed != null && stats.numberOfPlayed! > 0
        ? ((stats.numberOfSuccess ?? 0) / stats.numberOfPlayed! * 100).toStringAsFixed(1)
        : '0';

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colors.primary,
            theme.colors.primary.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: theme.colors.primary.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                  'Words', cubit.state.homeData.totalEntries.toString(), Icons.book, theme),
              _buildStatItem('Mastered', cubit.state.homeData.masteredEntries.toString(),
                  Icons.psychology, theme),
              _buildStatItem('Streak', cubit.state.statisticalModel.streak?.toString() ?? '0',
                  Icons.local_fire_department, theme),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            height: 1,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            color: theme.colors.white.withOpacity(0.2),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                'Total Plays',
                stats.numberOfPlayed?.toString() ?? '0',
                Icons.sports_esports,
                theme,
                small: true,
              ),
              _buildStatItem(
                'Success Rate',
                '$successRate%',
                Icons.analytics,
                theme,
                small: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, AppTheme theme,
      {bool small = false}) {
    return Column(
      children: [
        Icon(icon, color: theme.colors.white, size: small ? 24 : 28),
        const SizedBox(height: 8),
        Text(
          value,
          style: (small ? AppTextStyle.s20w500 : AppTextStyle.s24w500)
              .copyWith(color: theme.colors.white),
        ),
        Text(
          label,
          style: (small ? AppTextStyle.s12w400 : AppTextStyle.s14w400)
              .copyWith(color: theme.colors.white.withOpacity(0.8)),
        ),
      ],
    );
  }

  Widget _buildQuickActions(AppTheme theme, BuildContext context, HomeCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: AppTextStyle.s18w600.copyWith(color: theme.colors.primaryText),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                'Add Word',
                Icons.add_circle_outline,
                theme,
                () => AppNavigator.push(Routes.createEntry),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildActionCard(
                'Review',
                Icons.list_alt,
                theme,
                () => AppNavigator.push(Routes.entries),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard(String title, IconData icon, AppTheme theme, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: theme.colors.primary.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: theme.colors.primary, size: 32),
            const SizedBox(height: 8),
            Text(
              title,
              style: AppTextStyle.s14w500.copyWith(color: theme.colors.primaryText),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentWords(AppTheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Words',
          style: AppTextStyle.s18w600.copyWith(color: theme.colors.primaryText),
        ),
        const SizedBox(height: 16),
        // Add your recent words list here
      ],
    );
  }

  Widget _buildPlayButton(AppTheme theme, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      width: double.infinity,
      child: PrimaryButton(
        title: 'Start Quiz',
        onTap: () => AppNavigator.push(Routes.play),
        height: 48,
        icon: Icon(Icons.play_arrow_rounded, color: theme.colors.white),
      ),
    );
  }
}
