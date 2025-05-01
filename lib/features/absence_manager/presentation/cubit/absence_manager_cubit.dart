import 'package:crewmeister_frontend_coding_challenge/core/extensions/date_time_extension.dart';
import 'package:crewmeister_frontend_coding_challenge/core/extensions/either_extension.dart';
import 'package:crewmeister_frontend_coding_challenge/core/usecases/usecase.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/domain/entities/absence_entity.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/domain/entities/member_entity.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/domain/usecases/fetch_absences_usecase.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/domain/usecases/fetch_members_usecase.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/presentation/cubit/absence_manager_cubit_state.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/presentation/models/absence_view_model.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/presentation/models/filters_view_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AbsenceManagerCubit extends Cubit<AbsenceManagerCubitState> {
  final FetchAbsencesUsecase _fetchAbsencesUsecase;
  final FetchMembersUsecase _fetchMembersUsecase;
  late List<AbsenceViewModel> _listOfAllAbsences;
  late List<AbsenceViewModel> _listOfFilteredAbsences;
  late int _numberOfPages;
  late FiltersViewModel _filtersViewModel;

  AbsenceManagerCubit(
    this._fetchAbsencesUsecase,
    this._fetchMembersUsecase,
  ) : super(const AbsenceManagerInitialState());

  void fetchData() async {
    emit(const AbsenceManagerLoadingState());

    late final List<AbsenceEntity> absences;
    late final List<MemberEntity> members;
    final Map<int, String> mappedMembers = {};

    // Fetch the list of absences entities by calling the usecase.
    final fetchAbsencesResult =
        await _fetchAbsencesUsecase.call(params: const NoParams());
    if (fetchAbsencesResult.isLeft()) {
      emit(AbsenceManagerErrorState(failure: fetchAbsencesResult.asLeft()));
      return;
    } else {
      absences = fetchAbsencesResult.asRight();
    }

    // Fetch the list of members entities by calling the usecase.
    final fetchMembersResult =
        await _fetchMembersUsecase.call(params: const NoParams());
    if (fetchMembersResult.isLeft()) {
      emit(AbsenceManagerErrorState(failure: fetchMembersResult.asLeft()));
      return;
    } else {
      members = fetchMembersResult.asRight();
    }

    // Create a Map with userId/memberName as key value pairs.
    // We need to display the member name for each absence, and each absence has a userId.
    // With a list, we would need to loop through the members list for each absence to find the member name.
    // Looping through a list is an operation of cost O(n).
    // Instead we can access the Map and get the member name. Cost of operation is O(1).
    for (MemberEntity member in members) {
      mappedMembers.putIfAbsent(member.userId, () => member.name);
    }

    // Create the list of AbsenceViewModel with the information wee need to display.
    _listOfAllAbsences = absences
        .map((e) => AbsenceViewModel(
              id: e.id,
              memberName: mappedMembers[e.userId] ?? '',
              absenceType: e.type,
              startDate: e.startDate,
              endDate: e.endDate,
              memberNote: e.memberNote,
              absenceStatus: calculateAbsenceStatus(
                confirmedAt: e.confirmedAt,
                rejectedAt: e.rejectedAt,
              ),
              admitterNote: e.admitterNote,
            ))
        .toList();

    _numberOfPages = (_listOfAllAbsences.length / 10).ceil();

    _listOfFilteredAbsences = _listOfAllAbsences;

    _filtersViewModel =
        const FiltersViewModel(startDate: null, endDate: null, absenceType: {});

    emit(
      AbsenceManagerPopulatedState(
        absencesViewModel: _listOfAllAbsences,
        totalNumberOfAbsences: _listOfAllAbsences.length,
        numberOfPages: _numberOfPages,
        filtersViewModel: _filtersViewModel,
      ),
    );
  }

  void applyFilters(FiltersViewModel newFiltersViewModel) {
    emit(const AbsenceManagerLoadingState());
    int numberOfActiveFilters = newFiltersViewModel.numberOfActiveFilters();

    /// If the active filters are less then 2
    /// then the list to filter is the list of all absences
    if (numberOfActiveFilters < 2) {
      _listOfFilteredAbsences = _listOfAllAbsences;
    }

    if (newFiltersViewModel.startDate != null) {
      _listOfFilteredAbsences = _listOfFilteredAbsences
          .where(
              (e) => e.startDate.isSameOrAfter(newFiltersViewModel.startDate!))
          .toList();
    }

    if (newFiltersViewModel.endDate != null) {
      _listOfFilteredAbsences = _listOfFilteredAbsences
          .where(
              (e) => e.startDate.isSameOrBefore(newFiltersViewModel.endDate!))
          .toList();
    }

    if (newFiltersViewModel.absenceType.isNotEmpty) {
      _listOfFilteredAbsences = _listOfFilteredAbsences
          .where(((e) =>
              (newFiltersViewModel.absenceType.contains(e.absenceType))))
          .toList();
    }

    _filtersViewModel = newFiltersViewModel;
    _numberOfPages = (_listOfFilteredAbsences.length / 10).ceil();

    if (_listOfFilteredAbsences.isEmpty) {
      emit(AbsenceManagerEmptyState(filtersViewModel: _filtersViewModel));
    } else {
      emit(
        AbsenceManagerPopulatedState(
          absencesViewModel: _listOfFilteredAbsences,
          totalNumberOfAbsences: _listOfFilteredAbsences.length,
          filtersViewModel: _filtersViewModel,
          numberOfPages: _numberOfPages,
        ),
      );
    }
  }

  AbsenceStatusEnum calculateAbsenceStatus({
    required DateTime? confirmedAt,
    required DateTime? rejectedAt,
  }) {
    if (confirmedAt != null) {
      return AbsenceStatusEnum.confirmed;
    }
    if (rejectedAt != null) {
      return AbsenceStatusEnum.rejected;
    }
    return AbsenceStatusEnum.requested;
  }
}
