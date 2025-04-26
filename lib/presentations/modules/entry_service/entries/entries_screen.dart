import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/entries_view.dart';
import 'cubit/entries_cubit.dart';

class EntriesScreen extends StatelessWidget {
  const EntriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EntriesCubit(),
      child: const EntriesView(),
    );
  }
}
