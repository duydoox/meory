import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meory/generated/assets.gen.dart';
import 'package:meory/presentations/modules/auth_service/change_password/cubit/change_password_cubit.dart';
import 'package:meory/presentations/routes.dart';
import 'package:meory/presentations/widgets/base_widget.dart';
import 'package:meory/presentations/widgets/button_widget/primary_button.dart';
import 'package:meory/presentations/widgets/input_text/input_text.dart';

class ChangePasswordView extends BaseWidget<ChangePasswordCubit, ChangePasswordState> {
  const ChangePasswordView({super.key});

  @override
  void onInit(BuildContext context) {
    final cubit = context.read<ChangePasswordCubit>();
    cubit.passwordController.addListener(() {
      cubit.checkPassword();
    });
    cubit.confirmPasswordController.addListener(() {
      cubit.checkConfirmPassword();
    });
    super.onInit(context);
  }

  @override
  Widget build(BuildContext context, AppTheme theme, AppLocalizations tr) {
    final cubit = context.read<ChangePasswordCubit>();
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            AppNavigator.pop();
          },
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<ChangePasswordCubit, ChangePasswordState>(builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 28),

              Text(
                tr.passwordRequired,
                style: AppTextStyle.s24w600,
              ),

              const SizedBox(height: 40),

              /// Input Password
              InputText(
                controller: cubit.passwordController,
                height: 52,
                hintText: '',
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: const Icon(Icons.remove_red_eye),
                suffixIconChangeOnTap: const Icon(Icons.visibility_off),
                isPassword: true,
                textInputAction: TextInputAction.done,
                onChangedText: (val) {},
                onSubmitted: (val) {
                  FocusScope.of(context).unfocus();
                },
              ),
              const SizedBox(height: 8),
              Wrap(
                children: [
                  _buildRequireItem(
                      theme: theme, title: '8-16${tr.char}', isValid: state.isSatisfyLength),
                  const SizedBox(width: 12),
                  _buildRequireItem(
                      theme: theme,
                      title: tr.requireBothUpAndLowerCase,
                      isValid: state.isUpAndLowerCase),
                  const SizedBox(width: 12),
                  _buildRequireItem(
                      theme: theme, title: tr.requireSpecial, isValid: state.isSatisfySpecialChar),
                ],
              ),

              const SizedBox(height: 20),

              /// Input Password
              InputText(
                controller: cubit.confirmPasswordController,
                height: 52,
                hintText: tr.requireConfirmPassword,
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: const Icon(Icons.remove_red_eye),
                suffixIconChangeOnTap: const Icon(Icons.visibility_off),
                isPassword: true,
                textInputAction: TextInputAction.done,
                onChangedText: (val) {},
                onSubmitted: (val) {
                  FocusScope.of(context).unfocus();
                },
              ),
              const SizedBox(height: 8),
              Wrap(
                children: [
                  _buildRequireItem(
                      theme: theme, title: tr.passwordMatching, isValid: state.isMatchPassword),
                ],
              ),

              SizedBox(
                height: 20,
                width: MediaQuery.of(context).size.width,
              ),
            ],
          );
        }),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: PrimaryButton(
          title: tr.next,
          onTap: cubit.onTapConfirm,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildRequireItem({required String title, required AppTheme theme, bool isValid = false}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Assets.icons.icCheck
            .svg(color: isValid ? theme.colors.greenEnable : theme.colors.greyBackground2),
        const SizedBox(width: 4),
        Text(
          title,
          style: AppTextStyle.s14w400,
          textHeightBehavior: const TextHeightBehavior(
            applyHeightToFirstAscent: false,
            applyHeightToLastDescent: false,
          ),
        ),
      ],
    );
  }
}
