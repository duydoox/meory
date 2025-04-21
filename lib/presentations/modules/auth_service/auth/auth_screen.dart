import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meory/presentations/modules/auth_service/auth/components/auth_view.dart';
import 'package:meory/presentations/modules/auth_service/auth/cubit/auth_cubit.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: const AuthView(),
    );
  }
}
