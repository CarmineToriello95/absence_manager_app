import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/domain/entities/absence_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'absence_model.g.dart';

/// Data layer representation of an Absence, used for serialization.
@JsonSerializable()
class AbsenceModel extends AbsenceEntity {
  const AbsenceModel({
    required super.admitterId,
    required super.admitterNote,
    required super.confirmedAt,
    required super.createdAt,
    required super.crewId,
    required super.endDate,
    required super.id,
    required super.memberNote,
    required super.rejectedAt,
    required super.startDate,
    required super.type,
    required super.userId,
  });

  factory AbsenceModel.fromJson(Map<String, dynamic> json) =>
      _$AbsenceModelFromJson(json);

  AbsenceEntity toEntity() => AbsenceEntity(
        admitterId: admitterId,
        admitterNote: admitterNote,
        confirmedAt: confirmedAt,
        createdAt: createdAt,
        crewId: crewId,
        endDate: endDate,
        id: id,
        memberNote: memberNote,
        rejectedAt: rejectedAt,
        startDate: startDate,
        type: type,
        userId: userId,
      );
}
