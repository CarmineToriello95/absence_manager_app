import 'package:crewmeister_frontend_coding_challenge/core/error/failure.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/presentation/models/absence_view_model.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/presentation/models/filters_view_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class AbsenceManagerCubitState extends Equatable {
  const AbsenceManagerCubitState();
}

class AbsenceManagerInitialState extends AbsenceManagerCubitState {
  const AbsenceManagerInitialState();

  @override
  List<Object?> get props => [];
}

class AbsenceManagerLoadingState extends AbsenceManagerCubitState {
  const AbsenceManagerLoadingState();

  @override
  List<Object?> get props => [];
}

class AbsenceManagerEmptyState extends AbsenceManagerCubitState {
  final FiltersViewModel filtersViewModel;

  const AbsenceManagerEmptyState({required this.filtersViewModel});

  @override
  List<Object?> get props => [filtersViewModel];
}

class AbsenceManagerPopulatedState extends AbsenceManagerCubitState {
  final List<AbsenceViewModel> absencesViewModel;
  final int totalNumberOfAbsences;
  final int numberOfPages;
  final FiltersViewModel filtersViewModel;

  const AbsenceManagerPopulatedState({
    required this.absencesViewModel,
    required this.totalNumberOfAbsences,
    required this.numberOfPages,
    required this.filtersViewModel,
  });

  @override
  List<Object?> get props =>
      [absencesViewModel, filtersViewModel, numberOfPages, filtersViewModel];
}

class AbsenceManagerErrorState extends AbsenceManagerCubitState {
  final Failure failure;

  const AbsenceManagerErrorState({required this.failure});

  @override
  List<Object?> get props => [];
}
