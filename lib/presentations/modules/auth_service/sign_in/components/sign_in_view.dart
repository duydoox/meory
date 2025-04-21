import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meory/generated/assets.gen.dart';
import 'package:meory/presentations/modules/auth_service/sign_in/cubit/sign_in_cubit.dart';
import 'package:meory/presentations/modules/auth_service/sign_in/cubit/sign_in_state.dart';
import 'package:meory/presentations/routes.dart';
import 'package:meory/presentations/widgets/base_widget.dart';
import 'package:meory/presentations/widgets/button_widget/primary_button.dart';
import 'package:meory/presentations/widgets/input_text/input_text.dart';

class SignInView extends BaseWidget<SignInCubit, SignInState> {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context, AppTheme theme, AppLocalizations tr) {
    final cubit = context.read<SignInCubit>();
    return Scaffold(
      // appBar: AppBar(
      //   leading: InkWell(
      //     onTap: () {
      //       AppNavigator.pop();
      //     },
      //     child: const Icon(Icons.arrow_back),
      //   ),
      // ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 220.h),

            /// LOGO
            SizedBox(
              height: 104.dg,
              width: 215.dg,
              child: Assets.images.icLogo.image(),
            ),

            SizedBox(height: 200.h),

            /// Input Account
            InputText(
              formInputText: cubit.formInputText,
              height: 52,
              hintText: tr.account,
              // content: '',
              prefixIcon: const Icon(Icons.mail),
              textInputAction: TextInputAction.next,
              onChangedText: (val) {
                context.read<SignInCubit>().onChangeUsername(val);
              },
              onSubmitted: (val) {
                FocusScope.of(context).nextFocus();
              },
              validator: (value) {
                if (value == null) {
                  return null;
                }
                if (value.isEmpty) {
                  return tr.emailRequired.replaceAll('\n', ' ');
                } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                  return tr.emailFormat;
                }
                return null;
              },
            ),

            const SizedBox(height: 20),

            /// Input Password
            InputText(
              formInputText: cubit.formInputText,
              height: 52,
              hintText: tr.password,
              // content: '',
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: const Icon(Icons.remove_red_eye),
              suffixIconChangeOnTap: const Icon(Icons.visibility_off),
              isPassword: true,
              textInputAction: TextInputAction.done,
              onChangedText: (val) {
                context.read<SignInCubit>().onChangePassword(val);
              },
              onSubmitted: (val) {
                FocusScope.of(context).unfocus();
              },
              validator: (value) {
                return value?.isEmpty == true ? tr.passwordRequired.replaceAll('\n', ' ') : null;
              },
            ),

            SizedBox(
              height: 20,
              width: MediaQuery.of(context).size.width,
            ),

            // /// REMEMBER ME
            // SizedBox(
            //   height: 24,
            //   child: CheckBoxWidget(
            //     title: 'Remember me',
            //     value: true,
            //     onChanged: (val) {},
            //   ),
            // ),

            // SizedBox(
            //   height: 20,
            //   width: MediaQuery.of(context).size.width,
            // ),

            PrimaryButton(
              title: tr.signIn,
              onTap: () {
                context.read<SignInCubit>().login();
              },
            ),

            const SizedBox(height: 20),
            InkWell(
              onTap: onTapSignUp,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    tr.signUp,
                    style: AppTextStyle.s14w400,
                  ),
                  const SizedBox(width: 2),
                  const Icon(Icons.arrow_forward_ios_rounded, size: 18)
                ],
              ),
            ),

            const SizedBox(height: 19.2),
          ],
        ),
      ),
    );
  }

  void onTapSignUp() {
    AppNavigator.push(Routes.signUpWithEmail);
  }

  void onTapForgot() {}
}
