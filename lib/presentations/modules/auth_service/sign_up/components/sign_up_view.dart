import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:meory/generated/assets.gen.dart';
import 'package:meory/presentations/routes.dart';
import 'package:meory/presentations/widgets/base_widget.dart';
import 'package:meory/presentations/widgets/button_widget/custom_button.dart';

class SignUpView extends BaseWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context, AppTheme theme, AppLocalizations tr) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: InkWell(
          onTap: () {
            AppNavigator.pop();
          },
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 28,
              width: MediaQuery.of(context).size.width,
            ),

            /// IMAGE
            SizedBox(
              height: 140,
              width: 140,
              child: Assets.icons.icGoogle.svg(),
            ),
            SizedBox(
              height: 28,
              width: MediaQuery.of(context).size.width,
            ),

            Text(
              'Create New Account',
              style: AppTextStyle.s32w700,
            ),

            SizedBox(
              height: 28,
              width: MediaQuery.of(context).size.width,
            ),

            CustomButton(
              icon: Assets.icons.icGoogle.svg(),
              title: "Sign up with email",
              onTap: onTapSignInWithEmail,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "If already registered, go to ",
              style: AppTextStyle.s14w400.copyWith(
                color: theme.colors.greyText,
              ),
            ),
            const SizedBox(
              width: 2,
            ),
            InkWell(
              onTap: onTapSignIn,
              child: Text(
                'Sign in',
                style: AppTextStyle.s14w400.copyWith(
                  color: theme.colors.primaryText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onTapSignIn() {
    AppNavigator.replace(Routes.signIn);
  }

  void onTapSignInWithEmail() {
    AppNavigator.push(Routes.signUpWithEmail);
  }
}
