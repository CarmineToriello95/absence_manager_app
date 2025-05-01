import 'package:crewmeister_frontend_coding_challenge/core/error/absence_manager/absence_manager_failures.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/data/models/absence_model.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/data/models/member_model.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/data/repositories/absence_manager_repository_impl.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/domain/entities/absence_entity.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/domain/entities/member_entity.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/domain/repositories/absence_manager_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/mocks.mocks.dart';

void main() {
  late AbsenceManagerRepository repository;
  late MockRemoteDataSource mockRemoteDataSource;

  setUp(
    () {
      mockRemoteDataSource = MockRemoteDataSource();
      repository = AbsenceManagerRepositoryImpl(mockRemoteDataSource);
    },
  );

  group('AbsenceManagerRepository', () {
    final tAbsencesModels = [
      AbsenceModel(
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

    const tMembersModels = [
      MemberModel(
        crewId: 1,
        id: 2,
        image: 'imagePath',
        name: 'name',
        userId: 3,
      ),
    ];

    final exception = Exception('Test error');

    test(
      'WHEN fetching the absences is successful THEN return a list of AbsenceEntity',
      () async {
        /// arrange
        when(mockRemoteDataSource.fetchAbsences())
            .thenAnswer((_) async => tAbsencesModels);

        /// acts
        final result = await repository.fetchAbsences();

        final resultList = (result as Right).value as List<AbsenceEntity>;

        /// assert
        for (AbsenceEntity absence in resultList) {
          expect(absence, isA<AbsenceEntity>());
        }
        verify(mockRemoteDataSource.fetchAbsences()).called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );

    test(
      'WHEN an exception occurs while fetching the absences THEN return a FetchAbsencesFailure object',
      () async {
        /// arrange
        when(mockRemoteDataSource.fetchAbsences())
            .thenAnswer((_) async => throw exception);

        /// act
        final result = await repository.fetchAbsences();

        /// assert
        expect(result, Left(FetchAbsencesFailure(exception.toString())));
        verify(mockRemoteDataSource.fetchAbsences()).called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );

    test(
      'WHEN fetching the members is successful THEN return a list of MemberEntity',
      () async {
        /// arrange
        when(mockRemoteDataSource.fetchMembers())
            .thenAnswer((_) async => tMembersModels);

        /// acts
        final result = await repository.fetchMembers();

        final resultList = (result as Right).value as List<MemberEntity>;

        /// assert
        for (MemberEntity absence in resultList) {
          expect(absence, isA<MemberEntity>());
        }
        verify(mockRemoteDataSource.fetchMembers()).called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );

    test(
      'WHEN an exception occurs while fetching the members THEN return a FetchMembersFailure object',
      () async {
        /// arrange
        when(mockRemoteDataSource.fetchMembers())
            .thenAnswer((_) async => throw exception);

        /// act
        final result = await repository.fetchMembers();

        /// assert
        expect(result, Left(FetchMembersFailure(exception.toString())));
        verify(mockRemoteDataSource.fetchMembers()).called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );
  });
}
