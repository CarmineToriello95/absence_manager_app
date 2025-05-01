import 'package:crewmeister_frontend_coding_challenge/core/error/absence_manager/absence_manager_failures.dart';
import 'package:crewmeister_frontend_coding_challenge/core/usecases/usecase.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/domain/entities/member_entity.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/domain/usecases/fetch_members_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/mocks.mocks.dart';

void main() {
  late FetchMembersUsecase usecase;
  late MockAbsenceManagerRepository mockRepository;

  setUp(() {
    mockRepository = MockAbsenceManagerRepository();
    usecase = FetchMembersUsecase(mockRepository);
  });

  group('FetchMembersUsecase', () {
    const tMembers = [
      MemberEntity(
        crewId: 1,
        id: 2,
        image: 'imagePath',
        name: 'name',
        userId: 3,
      ),
    ];
    const tFailure = FetchAbsencesFailure('Error while fetching members');

    test(
      'WHEN successful THEN return a list of MemberEntity',
      () async {
        /// arrange
        when(mockRepository.fetchMembers()).thenAnswer(
          (_) async => const Right(tMembers),
        );

        /// act
        final result = await usecase.call(params: const NoParams());

        /// assert
        expect(result, const Right(tMembers));
        verify(mockRepository.fetchMembers()).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );

    test(
      'WHEN not successful THEN return a Failure object',
      () async {
        /// arrange
        when(mockRepository.fetchMembers()).thenAnswer(
          (_) async => const Left(tFailure),
        );

        /// act
        final result = await usecase.call(params: const NoParams());

        /// assert
        expect(result, const Left(tFailure));
        verify(mockRepository.fetchMembers()).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );
  });
}
