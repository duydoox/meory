import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meory/presentations/modules/home/cubit/home_cubit.dart';
import 'package:meory/presentations/routes.dart';

class HomeListener extends StatefulWidget {
  const HomeListener({super.key});

  @override
  State<HomeListener> createState() => _HomeListenerState();
}

class _HomeListenerState extends State<HomeListener> with RouteAware {
  late final HomeCubit homeCubit;

  @override
  void initState() {
    super.initState();
    homeCubit = context.read<HomeCubit>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AppNavigator.routeObserver.subscribe(this, ModalRoute.of(context)! as PageRoute);
  }

  @override
  void didPopNext() {
    if (HomeCubit.neededRefreshData) {
      homeCubit.getHomeData();
      HomeCubit.neededRefreshData = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
