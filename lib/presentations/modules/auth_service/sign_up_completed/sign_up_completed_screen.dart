import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'components/sign_up_completed_view.dart';
import 'cubit/sign_up_completed_cubit.dart';

class SignUpCompletedScreen extends StatelessWidget {
  const SignUpCompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final extra = GoRouterState.of(context).extra as Map<String, dynamic>?;
    return BlocProvider(
      create: (context) => SignUpCompletedCubit(
        email: extra?['email'],
        password: extra?['password'],
      ),
      child: const SignUpCompletedView(),
    );
  }
}
