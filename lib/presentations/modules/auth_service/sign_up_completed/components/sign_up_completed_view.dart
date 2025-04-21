import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meory/generated/assets.gen.dart';
import 'package:meory/presentations/modules/auth_service/sign_up_completed/cubit/sign_up_completed_cubit.dart';
import 'package:meory/presentations/widgets/base_widget.dart';
import 'package:meory/presentations/widgets/button_widget/primary_button.dart';

class SignUpCompletedView extends BaseWidget {
  const SignUpCompletedView({super.key});

  @override
  Widget build(BuildContext context, AppTheme theme, AppLocalizations tr) {
    return Scaffold(
      backgroundColor: theme.colors.background,
      // appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 240.h, width: double.infinity),
            Assets.icons.icPersonGuitar.svg(),
            Text(
              tr.finishSigup,
              style: AppTextStyle.s32w700,
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: PrimaryButton(
          title: tr.goToHome,
          onTap: context.read<SignUpCompletedCubit>().onTapGotoHome,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
