import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meory/generated/assets.gen.dart';
import 'package:meory/presentations/routes.dart';
import 'package:meory/presentations/widgets/base_widget.dart';
import 'package:meory/presentations/widgets/button_widget/primary_button.dart';
import 'package:meory/presentations/widgets/countdown/countdown.dart';
import 'package:meory/presentations/widgets/input_text/input_text.dart';

import '../cubit/otp_cubit.dart';
import '../cubit/otp_state.dart';

class OtpView extends BaseWidget<OtpCubit, OtpState> {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context, AppTheme theme, AppLocalizations tr) {
    final cubit = context.read<OtpCubit>();
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
        child: BlocBuilder<OtpCubit, OtpState>(
            buildWhen: (previous, current) => previous.verifying != current.verifying,
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 28,
                    width: MediaQuery.of(context).size.width,
                  ),

                  Text(
                    tr.otpRequired,
                    style: AppTextStyle.s24w600,
                  ),

                  /// IMAGE
                  SizedBox(
                    height: 28,
                    width: MediaQuery.of(context).size.width,
                  ),

                  SizedBox(
                    height: 20,
                    width: MediaQuery.of(context).size.width,
                  ),
                  InputText(
                    formInputText: cubit.formInputText,
                    controller: cubit.codeController,
                    height: 52,
                    hintText: '',
                    keyboardType: TextInputType.number,
                    //content: 'lethelu@gmail.com',
                    prefixIcon: const Icon(Icons.code),
                    textInputAction: TextInputAction.next,
                    onSubmitted: (code) {
                      FocusScope.of(context).nextFocus();
                    },
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Assets.icons.icClockFill.svg(),
                            const SizedBox(width: 8),
                            Countdown(seconds: cubit.state.verifying ? 180 : 0)
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: cubit.resend,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Assets.icons.icRefresh.svg(),
                            const SizedBox(width: 8),
                            Text(tr.resend)
                          ],
                        ),
                      ),
                    ],
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
