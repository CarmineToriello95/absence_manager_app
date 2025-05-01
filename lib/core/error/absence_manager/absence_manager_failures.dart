import 'package:crewmeister_frontend_coding_challenge/core/error/failure.dart';

/// Class representing a failure occurred when fetching the absences.
class FetchAbsencesFailure extends Failure {
  const FetchAbsencesFailure(super.message);
}

/// Class representing a failure occurred when fetching the members.
class FetchMembersFailure extends Failure {
  const FetchMembersFailure(super.message);
}
