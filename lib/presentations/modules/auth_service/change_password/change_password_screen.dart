import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'components/change_password_view.dart';
import 'cubit/change_password_cubit.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final extra = GoRouterState.of(context).extra as Map<String, dynamic>?;
    return BlocProvider(
      create: (context) => ChangePasswordCubit(
        email: extra?['email'] ?? '',
        tokenVerifyOTP: extra?['tokenVerifyOTP'] ?? '',
      ),
      child: const ChangePasswordView(),
    );
  }
}
