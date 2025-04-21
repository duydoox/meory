import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'components/otp_view.dart';
import 'cubit/otp_cubit.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final extra = GoRouterState.of(context).extra as Map<String, dynamic>?;
    return BlocProvider(
      create: (context) => OtpCubit(email: extra?['email'], tokenVerify: extra?['tokenVerify']),
      child: const OtpView(),
    );
  }
}
