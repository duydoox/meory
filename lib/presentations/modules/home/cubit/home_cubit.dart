import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meory/app/app_cubit.dart';
import 'package:meory/presentations/routes.dart';
import 'package:meory/presentations/widgets/button_widget/primary_button.dart';

part 'home_state.dart';

class HomeCubit extends CoreCubit<HomeState> {
  HomeCubit() : super(const HomeState());

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
                  title: const Text("Thư viện", textAlign: TextAlign.center),
                  onTap: () {
                    AppNavigator.pop();
                    AppNavigator.push(Routes.entries);
                  },
                ),
                Divider(color: theme.colors.divider, height: 1),
                ListTile(
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text(
                    tr.logOut,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.s16w600.withColor(theme.colors.red),
                  ),
                  onTap: onTapLogout,
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
    FirebaseAuth.instance.signOut().then((value) => AppNavigator.go(Routes.auth));
  }
}
