import 'package:crewmeister_frontend_coding_challenge/di_config.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/presentation/cubit/absence_manager_cubit.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/presentation/cubit/absence_manager_cubit_state.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/presentation/widgets/absences_page_empty_state_widget.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/presentation/widgets/absences_page_error_state_widget.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/presentation/widgets/absences_page_populated_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AbsencesPage extends StatefulWidget {
  const AbsencesPage({super.key});

  @override
  State<AbsencesPage> createState() => _AbsencesPageState();
}

class _AbsencesPageState extends State<AbsencesPage> {
  final AbsenceManagerCubit _cubit = getIt.get();

  @override
  void initState() {
    _cubit.fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primaryFixed,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: BlocBuilder<AbsenceManagerCubit, AbsenceManagerCubitState>(
              bloc: _cubit,
              builder: (_, state) {
                if (state is AbsenceManagerLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is AbsenceManagerPopulatedState) {
                  return AbsencesPagePopulatedStateWidget(state: state);
                }
                if (state is AbsenceManagerEmptyState) {
                  return AbsencesPageEmptyStateWidget(
                    state: state,
                  );
                }
                return AbsencesPageErrorStateWidget(
                  onFetchAbsencesButtonTapped: _cubit.fetchData,
                );
              },
            ),
          ),
        ),
      );
}
