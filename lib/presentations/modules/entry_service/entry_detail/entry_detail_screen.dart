import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'components/entry_detail_view.dart';
import 'cubit/entry_detail_cubit.dart';

class EntryDetailScreen extends StatelessWidget {
  const EntryDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final extra = GoRouterState.of(context).extra as Map<String, dynamic>?;
    return BlocProvider(
      create: (context) => EntryDetailCubit(
        entry: extra?['entry'],
        callback: extra?['callback'],
      ),
      child: const EntryDetailView(),
    );
  }
}
