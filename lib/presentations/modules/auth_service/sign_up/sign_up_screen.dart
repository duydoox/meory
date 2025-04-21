import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meory/presentations/modules/auth_service/sign_up/components/sign_up_view.dart';
import 'package:meory/presentations/modules/auth_service/sign_up/cubit/sign_up_cubit.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: const SignUpView(),
    );
  }
}
