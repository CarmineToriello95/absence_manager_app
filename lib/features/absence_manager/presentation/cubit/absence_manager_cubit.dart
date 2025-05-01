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
  ) : super(const AbsenceManagerInitialState()) {
    fetchData();
  }

  void fetchData() async {
    emit(const AbsenceManagerLoadingState());

    late final List<AbsenceEntity> absences;
    late final List<MemberEntity> members;
    final Map<int, String> mappedMembers = {};

    // Fetch the list of absences entities by calling the usecase.
    final fetchAbsencesResult =
        await _fetchAbsencesUsecase.call(params: const NoParams());
    fetchAbsencesResult.fold(
      (failure) {
        emit(AbsenceManagerErrorState(failure: failure));
      },
      (data) {
        absences = data;
      },
    );

    // Fetch the list of members entities by calling the usecase.
    final fetchMembersResult =
        await _fetchMembersUsecase.call(params: const NoParams());
    fetchMembersResult.fold((failure) {
      emit(AbsenceManagerErrorState(failure: failure));
    }, (data) {
      members = data;
    });

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
        absencesWithMembersDataModels: _listOfAllAbsences,
        totalNumberOfAbsences: _listOfAllAbsences.length,
        numberOfPages: _numberOfPages,
        filtersViewModel: _filtersViewModel,
      ),
    );
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
