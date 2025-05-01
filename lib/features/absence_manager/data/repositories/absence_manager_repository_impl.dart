import 'package:crewmeister_frontend_coding_challenge/core/error/absence_manager/absence_manager_failures.dart';
import 'package:crewmeister_frontend_coding_challenge/core/error/failure.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/data/datasources/remote_data_source.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/data/models/absence_model.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/data/models/member_model.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/domain/entities/absence_entity.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/domain/entities/member_entity.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/domain/repositories/absence_manager_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

/// Concrete implementation of [AbsenceManagerRepository]
@Injectable(as: AbsenceManagerRepository)
class AbsenceManagerRepositoryImpl implements AbsenceManagerRepository {
  final RemoteDataSource _remoteDataSource;

  AbsenceManagerRepositoryImpl(this._remoteDataSource);

  /// Fetches the list of absences from the data source.
  ///
  /// Returns a list of [AbsenceEntity] if successful.
  ///
  /// Returns a [Failure] object if not successful.
  @override
  Future<Either<Failure, List<AbsenceEntity>>> fetchAbsences() async {
    try {
      final List<AbsenceModel> absencesModels =
          await _remoteDataSource.fetchAbsences();
      final List<AbsenceEntity> absencesEntities =
          absencesModels.map((e) => e.toEntity()).toList();
      return Right(absencesEntities);
    } catch (e) {
      return Left(FetchAbsencesFailure(e.toString()));
    }
  }

  /// Fetches the list of members from the data source.
  ///
  /// Returns a list of [MemberEntity] if successful.
  ///
  /// Returns a [Failure] object if not successful.
  @override
  Future<Either<Failure, List<MemberEntity>>> fetchMembers() async {
    try {
      final List<MemberModel> membersModels =
          await _remoteDataSource.fetchMembers();
      final List<MemberEntity> membersEntities =
          membersModels.map((e) => e.toEntity()).toList();
      return Right(membersEntities);
    } catch (e) {
      return Left(FetchMembersFailure(e.toString()));
    }
  }
}
