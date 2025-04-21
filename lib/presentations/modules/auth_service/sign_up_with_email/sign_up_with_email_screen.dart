import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/sign_up_with_email_view.dart';
import 'cubit/sign_up_with_email_cubit.dart';

class SignUpWithEmailScreen extends StatelessWidget {
  const SignUpWithEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpWithEmailCubit(),
      child: const SignUpWithEmailView(),
    );
  }
}
