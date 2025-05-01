/// Exception representing a technical error in the data layer
/// while fetching the absences.
///
/// It is not inteded to propagate to the UI. It should be caught and translated
/// into a [Failure] in the repository.
class FetchAbsencesException implements Exception {
  final String message;

  const FetchAbsencesException(this.message);
}

/// Exception representing a technical error in the data layer
/// while fetching the members.
///
/// It is not inteded to propagate to the UI. It should be caught and translated
/// into a [Failure] in the repository.
class FetchMembersException implements Exception {
  final String message;

  const FetchMembersException(this.message);
}
