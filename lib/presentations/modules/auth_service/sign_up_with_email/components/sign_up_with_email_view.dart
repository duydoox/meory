import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meory/presentations/routes.dart';
import 'package:meory/presentations/widgets/base_widget.dart';
import 'package:meory/presentations/widgets/button_widget/primary_button.dart';
import 'package:meory/presentations/widgets/input_text/input_text.dart';

import '../cubit/sign_up_with_email_cubit.dart';
import '../cubit/sign_up_with_email_state.dart';

class SignUpWithEmailView extends BaseWidget<SignUpWithEmailCubit, SignUpWithEmailState> {
  const SignUpWithEmailView({super.key});

  @override
  Widget build(BuildContext context, AppTheme theme, AppLocalizations tr) {
    final cubit = context.read<SignUpWithEmailCubit>();
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
        child: BlocBuilder<SignUpWithEmailCubit, SignUpWithEmailState>(builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 28,
                width: MediaQuery.of(context).size.width,
              ),

              Text(
                tr.emailRequired,
                style: AppTextStyle.s24w600,
              ),

              /// IMAGE
              SizedBox(
                height: 28,
                width: MediaQuery.of(context).size.width,
              ),

              /// Input Account
              InputText(
                formInputText: cubit.formInputText,
                controller: cubit.emailController,
                hintText: tr.account,
                height: 52,
                //content: 'lethelu@gmail.com',
                prefixIcon: const Icon(Icons.mail),
                textInputAction: TextInputAction.next,
                onSubmitted: (email) {
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
              SizedBox(
                height: 20,
                width: MediaQuery.of(context).size.width,
              ),

              const SizedBox(
                height: 28,
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
}
