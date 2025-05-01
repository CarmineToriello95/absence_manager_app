import 'package:crewmeister_frontend_coding_challenge/core/error/failure.dart';
import 'package:crewmeister_frontend_coding_challenge/core/usecases/usecase.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/domain/entities/member_entity.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/domain/repositories/absence_manager_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

/// Use case for retrieving the list of members from the repository.
@injectable
class FetchMembersUsecase implements UseCase<List<MemberEntity>, NoParams> {
  final AbsenceManagerRepository _repository;

  FetchMembersUsecase(this._repository);

  @override
  Future<Either<Failure, List<MemberEntity>>> call({
    required NoParams params,
  }) =>
      _repository.fetchMembers();
}
