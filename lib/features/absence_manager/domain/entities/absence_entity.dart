import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

enum AbsenceTypeEnum { sickness, vacation }

@immutable
class AbsenceEntity extends Equatable {
  final int? admitterId;
  final String admitterNote;
  final DateTime? confirmedAt;
  final DateTime createdAt;
  final int crewId;
  final DateTime endDate;
  final int id;
  final String memberNote;
  final DateTime? rejectedAt;
  final DateTime startDate;
  final AbsenceTypeEnum type;
  final int userId;

  const AbsenceEntity({
    required this.admitterId,
    required this.admitterNote,
    required this.confirmedAt,
    required this.createdAt,
    required this.crewId,
    required this.endDate,
    required this.id,
    required this.memberNote,
    required this.rejectedAt,
    required this.startDate,
    required this.type,
    required this.userId,
  });

  @override
  List<Object?> get props => [
        admitterId,
        admitterNote,
        confirmedAt,
        createdAt,
        crewId,
        endDate,
        id,
        memberNote,
        rejectedAt,
        startDate,
        type,
        userId
      ];
}
