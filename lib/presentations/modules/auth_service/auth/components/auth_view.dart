import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:meory/app/app_assets.dart';
import 'package:meory/presentations/routes.dart';
import 'package:meory/presentations/widgets/base_widget.dart';
import 'package:meory/presentations/widgets/button_widget/custom_button.dart';

class AuthView extends BaseWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context, AppTheme theme, AppLocalizations tr) {
    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(),
      body: SizedBox(
        height: MediaQuery.of(context).size.height -
            AppBar().preferredSize.height -
            MediaQuery.of(context).padding.top,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 29,
              ),
              SizedBox(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: AppImage.icLetsYouIn(),
              ),
              const SizedBox(
                height: 29,
              ),
              Text(
                'Let’s sign in',
                style: AppTextStyle.s40w700,
              ),
              const SizedBox(
                height: 29,
              ),
              CustomButton(
                icon: AppIcon.icGoogle(),
                title: "Continue with email",
                onTap: onTapSignInWithEmail,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "If not registered yet, go to ",
              style: AppTextStyle.s14w400.copyWith(
                color: theme.colors.greyText,
              ),
            ),
            const SizedBox(
              width: 2,
            ),
            InkWell(
              onTap: onTapSignUp,
              child: Text(
                'Sign up',
                style: AppTextStyle.s14w400.copyWith(color: theme.colors.primaryText),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onTapSignUp() {
    AppNavigator.push(Routes.signUp);
  }

  void onTapSignInWithEmail() {
    AppNavigator.push(Routes.signIn);
  }
}
