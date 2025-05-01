import 'package:bloc_test/bloc_test.dart';
import 'package:crewmeister_frontend_coding_challenge/core/error/absence_manager/absence_manager_failures.dart';
import 'package:crewmeister_frontend_coding_challenge/core/usecases/usecase.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/domain/entities/absence_entity.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/domain/entities/member_entity.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/presentation/cubit/absence_manager_cubit.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/presentation/cubit/absence_manager_cubit_state.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/presentation/models/filters_view_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../core/mocks.mocks.dart';

void main() {
  late AbsenceManagerCubit cubit;
  late MockFetchAbsencesUsecase mockFetchAbsencesUsecase =
      MockFetchAbsencesUsecase();
  late MockFetchMembersUsecase mockFetchMembersUsecase =
      MockFetchMembersUsecase();

  final tAbsencesEntities = [
    AbsenceEntity(
      admitterId: 1,
      admitterNote: 'admitterNote',
      confirmedAt: DateTime(2025, 10, 10),
      createdAt: DateTime(2025, 10, 10),
      crewId: 2,
      endDate: DateTime(2025, 10, 10),
      id: 3,
      memberNote: 'memberNote',
      rejectedAt: null,
      startDate: DateTime(2025, 10, 10),
      type: AbsenceTypeEnum.sickness,
      userId: 2,
    ),
  ];

  const tMembersEntities = [
    MemberEntity(
      crewId: 1,
      id: 2,
      image: 'imagePath',
      name: 'name',
      userId: 2,
    ),
  ];

  const tFailure = FetchAbsencesFailure('failure');

  setUp(() {
    cubit =
        AbsenceManagerCubit(mockFetchAbsencesUsecase, mockFetchMembersUsecase);
  });

  void mockFetchAbsencesUseCaseSuccess() =>
      when(mockFetchAbsencesUsecase.call(params: const NoParams()))
          .thenAnswer((_) async => Right(tAbsencesEntities));
  void mockFetchMembersUseCaseSuccess() =>
      when(mockFetchMembersUsecase.call(params: const NoParams()))
          .thenAnswer((_) async => const Right(tMembersEntities));

  void mockFetchAbsencesUseCaseFailure() =>
      when(mockFetchAbsencesUsecase.call(params: const NoParams()))
          .thenAnswer((_) async => const Left(tFailure));

  void mockFetchMembersUseCaseFailure() =>
      when(mockFetchMembersUsecase.call(params: const NoParams()))
          .thenAnswer((_) async => const Left(tFailure));

  group('AbsenceManagerCubit', () {
    blocTest(
      'WHEN fetching the absences and members is successful THEN emits [AbsenceManagerLoadingState,AbsenceManagerPopulatedState]',
      build: () {
        mockFetchAbsencesUseCaseSuccess();
        mockFetchMembersUseCaseSuccess();
        return cubit;
      },
      act: (cubit) => cubit.fetchData(),
      verify: (_) {
        verifyInOrder([
          mockFetchAbsencesUsecase.call(params: const NoParams()),
          mockFetchMembersUsecase.call(params: const NoParams()),
        ]);
        verifyNoMoreInteractions(mockFetchAbsencesUsecase);
        verifyNoMoreInteractions(mockFetchMembersUsecase);
      },
      expect: () => [
        isA<AbsenceManagerLoadingState>(),
        isA<AbsenceManagerPopulatedState>(),
      ],
    );

    blocTest(
      'WHEN fetching the absences fails THEN emits [AbsenceManagerLoadingState,AbsenceManagerErrorState]',
      build: () {
        mockFetchAbsencesUseCaseFailure();
        return cubit;
      },
      act: (cubit) => cubit.fetchData(),
      verify: (_) {
        verifyInOrder([
          mockFetchAbsencesUsecase.call(params: const NoParams()),
        ]);
        verifyNoMoreInteractions(mockFetchAbsencesUsecase);
        verifyNoMoreInteractions(mockFetchMembersUsecase);
      },
      expect: () => [
        isA<AbsenceManagerLoadingState>(),
        isA<AbsenceManagerErrorState>(),
      ],
    );

    blocTest(
      'WHEN fetching the members fails THEN emits [AbsenceManagerLoadingState,AbsenceManagerErrorState]',
      build: () {
        mockFetchAbsencesUseCaseSuccess();
        mockFetchMembersUseCaseFailure();
        return cubit;
      },
      act: (cubit) => cubit.fetchData(),
      verify: (_) {
        verifyInOrder([
          mockFetchAbsencesUsecase.call(params: const NoParams()),
          mockFetchMembersUsecase.call(params: const NoParams()),
        ]);
        verifyNoMoreInteractions(mockFetchAbsencesUsecase);
        verifyNoMoreInteractions(mockFetchMembersUsecase);
      },
      expect: () => [
        isA<AbsenceManagerLoadingState>(),
        isA<AbsenceManagerErrorState>(),
      ],
    );

    blocTest(
      'WHEN applying filter and the filtered absence list is not empty THEN emits [AbsenceManagerLoadingState,AbsenceManagerPopulatedState]',
      build: () {
        mockFetchAbsencesUseCaseSuccess();
        mockFetchMembersUseCaseSuccess();
        return cubit;
      },
      act: (cubit) async {
        cubit.fetchData();
        await Future.delayed(const Duration(milliseconds: 300));
        cubit.applyFilters(const FiltersViewModel(
            startDate: null,
            endDate: null,
            absenceType: {AbsenceTypeEnum.sickness}));
      },
      verify: (_) {
        verifyInOrder([
          mockFetchAbsencesUsecase.call(params: const NoParams()),
          mockFetchMembersUsecase.call(params: const NoParams()),
        ]);
        verifyNoMoreInteractions(mockFetchAbsencesUsecase);
        verifyNoMoreInteractions(mockFetchMembersUsecase);
      },
      expect: () => [
        /// The first two states are related to the fetching of the data
        isA<AbsenceManagerLoadingState>(),
        isA<AbsenceManagerPopulatedState>(),

        /// Appling the filters starts here
        isA<AbsenceManagerLoadingState>(),
        isA<AbsenceManagerPopulatedState>(),
      ],
    );

    blocTest(
      'WHEN applying filter and there are no matching absences THEN emits [AbsenceManagerLoadingState,AbsenceManagerErrorState]',
      build: () {
        mockFetchAbsencesUseCaseSuccess();
        mockFetchMembersUseCaseSuccess();
        return cubit;
      },
      act: (cubit) async {
        cubit.fetchData();
        await Future.delayed(const Duration(milliseconds: 300));
        cubit.applyFilters(const FiltersViewModel(
            startDate: null,
            endDate: null,
            absenceType: {AbsenceTypeEnum.vacation}));
      },
      verify: (_) {
        verifyInOrder([
          mockFetchAbsencesUsecase.call(params: const NoParams()),
          mockFetchMembersUsecase.call(params: const NoParams()),
        ]);
        verifyNoMoreInteractions(mockFetchAbsencesUsecase);
        verifyNoMoreInteractions(mockFetchMembersUsecase);
      },
      expect: () => [
        /// The first two states are related to the fetching of the data
        isA<AbsenceManagerLoadingState>(),
        isA<AbsenceManagerPopulatedState>(),

        /// Appling the filters starts here
        isA<AbsenceManagerLoadingState>(),
        isA<AbsenceManagerEmptyState>(),
      ],
    );
  });
}
