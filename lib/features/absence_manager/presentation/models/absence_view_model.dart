import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/domain/entities/absence_entity.dart';

enum AbsenceStatusEnum {
  requested,
  confirmed,
  rejected,
}

/// Presentation layer representation of an absence.
/// It contains the absence information to display in the AbsencePage.
class AbsenceViewModel {
  final int id;
  final String memberName;
  final AbsenceTypeEnum absenceType;
  final DateTime startDate;
  final DateTime endDate;
  final String memberNote;
  final AbsenceStatusEnum absenceStatus;
  final String admitterNote;

  const AbsenceViewModel({
    required this.id,
    required this.memberName,
    required this.absenceType,
    required this.startDate,
    required this.endDate,
    required this.memberNote,
    required this.absenceStatus,
    required this.admitterNote,
  });
}
