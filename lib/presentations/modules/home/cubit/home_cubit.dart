import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meory/app/app_cubit.dart';
import 'package:meory/presentations/routes.dart';
import 'package:meory/presentations/widgets/button_widget/primary_button.dart';

part 'home_state.dart';

class HomeCubit extends CoreCubit<HomeState> {
  HomeCubit() : super(const HomeState());

  int? selfId;
  int? clanId;
  int? taekwondoId;

  void showMenu(BuildContext context) {
    showDialog(
      context: context,
      builder: (c) {
        final theme = context.read<AppCubit>().state.theme;
        final tr = Utils.languageOf(context);
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text(tr.profile, textAlign: TextAlign.center),
                  onTap: () {},
                ),
                Divider(color: theme.colors.divider, height: 1),
                if (kDebugMode) ...[
                  Divider(color: theme.colors.divider, height: 1),
                  ListTile(
                    titleAlignment: ListTileTitleAlignment.center,
                    title: Text(
                      '${tr.logOut} (debug)',
                      textAlign: TextAlign.center,
                      style: AppTextStyle.s16w600.withColor(theme.colors.red),
                    ),
                    onTap: onTapLogout,
                  ),
                ],
                PrimaryButton(
                  title: tr.close,
                  onTap: () {
                    AppNavigator.pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showMenuRequesterList(BuildContext context) {
    showDialog(
      context: context,
      builder: (c) {
        final theme = context.read<AppCubit>().state.theme;
        final tr = Utils.languageOf(context);
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text(tr.certifierList, textAlign: TextAlign.center),
                  onTap: () {
                    AppNavigator.push(Routes.requesterList, {
                      'cardId': selfId,
                      'clanId': clanId,
                      'taekwondoId': taekwondoId,
                    });
                  },
                ),
                PrimaryButton(
                  title: tr.close,
                  onTap: () {
                    AppNavigator.pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  onTapLogout() {
    AppSecureStorage.resetToken();
    AppNavigator.go(Routes.signIn);
  }
}
