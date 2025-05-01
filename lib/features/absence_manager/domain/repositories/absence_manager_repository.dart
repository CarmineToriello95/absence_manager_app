import 'package:crewmeister_frontend_coding_challenge/core/error/failure.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/domain/entities/absence_entity.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/domain/entities/member_entity.dart';
import 'package:dartz/dartz.dart';

/// Contract that defines the operations to fetch absences and members.
abstract class AbsenceManagerRepository {
  /// Fetches the list of absences
  Future<Either<Failure, List<AbsenceEntity>>> fetchAbsences();

  /// Fetches the list of members
  Future<Either<Failure, List<MemberEntity>>> fetchMembers();
}
