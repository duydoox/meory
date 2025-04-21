import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meory/domain/usecases/splash/splash_usecase.dart';
import 'package:meory/generated/assets.gen.dart';
import 'package:meory/presentations/modules/splash/cubit/splash_cubit.dart';
import 'package:meory/presentations/routes.dart';
import 'package:meory/presentations/widgets/base_widget.dart';

part 'components/splash_view.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(
        getIt.get<SplashUseCase>(),
      ),
      child: const SplashView(),
    );
  }
}
