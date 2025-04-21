import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meory/domain/usecases/auth/login_usecase.dart';
import 'package:meory/presentations/modules/auth_service/sign_in/components/sign_in_view.dart';
import 'package:meory/presentations/modules/auth_service/sign_in/cubit/sign_in_cubit.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(
        getIt.get<LoginUseCase>(),
      ),
      child: const SignInView(),
    );
  }
}
