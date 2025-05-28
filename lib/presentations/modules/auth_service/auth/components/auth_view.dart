import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meory/app/app_assets.dart';
import 'package:meory/generated/assets.gen.dart';
import 'package:meory/presentations/routes.dart';
import 'package:meory/presentations/widgets/base_widget.dart';
import 'package:meory/presentations/widgets/button_widget/custom_button.dart';

import '../cubit/auth_cubit.dart';

class AuthView extends BaseWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context, AppTheme theme, AppLocalizations tr) {
    final cubit = context.read<AuthCubit>();
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
                child: Assets.images.icLogo.image(
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(
                height: 29,
              ),
              Text(
                'Đăng nhập',
                style: AppTextStyle.s40w700,
              ),
              const SizedBox(
                height: 29,
              ),
              CustomButton(
                icon: AppIcon.icGoogle(),
                title: "Đăng nhập với Google",
                onTap: cubit.onTapSignInWithGoogle,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTapSignUp() {
    AppNavigator.push(Routes.signUp);
  }
}
