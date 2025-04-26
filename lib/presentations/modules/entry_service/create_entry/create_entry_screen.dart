import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'components/create_entry_view.dart';
import 'cubit/create_entry_cubit.dart';

class CreateEntryScreen extends StatelessWidget {
  const CreateEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final extra = GoRouterState.of(context).extra as Map<String, dynamic>?;
    return BlocProvider(
      create: (context) => CreateEntryCubit(callback: extra?['callback']),
      child: const CreateEntryView(),
    );
  }
}
