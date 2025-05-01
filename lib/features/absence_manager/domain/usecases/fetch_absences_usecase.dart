import 'package:crewmeister_frontend_coding_challenge/core/error/failure.dart';
import 'package:crewmeister_frontend_coding_challenge/core/usecases/usecase.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/domain/entities/absence_entity.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/domain/repositories/absence_manager_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

/// Use case for retrieving the list of absences from the repository.
@injectable
class FetchAbsencesUsecase implements UseCase<List<AbsenceEntity>, NoParams> {
  final AbsenceManagerRepository _repository;

  FetchAbsencesUsecase(this._repository);

  @override
  Future<Either<Failure, List<AbsenceEntity>>> call({
    required NoParams params,
  }) =>
      _repository.fetchAbsences();
}
