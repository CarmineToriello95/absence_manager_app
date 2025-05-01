import 'package:crewmeister_frontend_coding_challenge/core/error/absence_manager/absence_manager_failures.dart';
import 'package:crewmeister_frontend_coding_challenge/core/usecases/usecase.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/domain/entities/absence_entity.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/domain/usecases/fetch_absences_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/mocks.mocks.dart';

void main() {
  late FetchAbsencesUsecase usecase;
  late MockAbsenceManagerRepository mockRepository;

  setUp(() {
    mockRepository = MockAbsenceManagerRepository();
    usecase = FetchAbsencesUsecase(mockRepository);
  });

  group('FetchAbsencesUsecase', () {
    final tAbsences = [
      AbsenceEntity(
        admitterId: 1,
        admitterNote: 'admitterNote',
        confirmedAt: DateTime(2025, 10, 10),
        createdAt: DateTime(2025, 10, 10),
        crewId: 2,
        endDate: DateTime(2025, 10, 10),
        id: 3,
        memberNote: 'memberNote',
        rejectedAt: DateTime(2025, 10, 10),
        startDate: DateTime(2025, 10, 10),
        type: AbsenceTypeEnum.sickness,
        userId: 2,
      ),
    ];
    const tFailure = FetchAbsencesFailure('Error while fetching absences');
    test(
      'WHEN successful THEN return a list of AbsenceEntity',
      () async {
        /// arrange
        when(mockRepository.fetchAbsences()).thenAnswer(
          (_) async => Right(tAbsences),
        );

        /// act
        final result = await usecase.call(params: const NoParams());

        /// assert
        expect(result, Right(tAbsences));
        verify(mockRepository.fetchAbsences()).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );

    test(
      'WHEN not successful THEN return a Failure object',
      () async {
        /// arrange
        when(mockRepository.fetchAbsences()).thenAnswer(
          (_) async => const Left(tFailure),
        );

        /// act
        final result = await usecase.call(params: const NoParams());

        /// assert
        expect(result, const Left(tFailure));
        verify(mockRepository.fetchAbsences()).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );
  });
}
