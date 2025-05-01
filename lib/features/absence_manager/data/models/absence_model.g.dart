// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'absence_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AbsenceModel _$AbsenceModelFromJson(Map<String, dynamic> json) => AbsenceModel(
      admitterId: (json['admitterId'] as num?)?.toInt(),
      admitterNote: json['admitterNote'] as String,
      confirmedAt: json['confirmedAt'] == null
          ? null
          : DateTime.parse(json['confirmedAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      crewId: (json['crewId'] as num).toInt(),
      endDate: DateTime.parse(json['endDate'] as String),
      id: (json['id'] as num).toInt(),
      memberNote: json['memberNote'] as String,
      rejectedAt: json['rejectedAt'] == null
          ? null
          : DateTime.parse(json['rejectedAt'] as String),
      startDate: DateTime.parse(json['startDate'] as String),
      type: $enumDecode(_$AbsenceTypeEnumEnumMap, json['type']),
      userId: (json['userId'] as num).toInt(),
    );

Map<String, dynamic> _$AbsenceModelToJson(AbsenceModel instance) =>
    <String, dynamic>{
      'admitterId': instance.admitterId,
      'admitterNote': instance.admitterNote,
      'confirmedAt': instance.confirmedAt?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'crewId': instance.crewId,
      'endDate': instance.endDate.toIso8601String(),
      'id': instance.id,
      'memberNote': instance.memberNote,
      'rejectedAt': instance.rejectedAt?.toIso8601String(),
      'startDate': instance.startDate.toIso8601String(),
      'type': _$AbsenceTypeEnumEnumMap[instance.type]!,
      'userId': instance.userId,
    };

const _$AbsenceTypeEnumEnumMap = {
  AbsenceTypeEnum.sickness: 'sickness',
  AbsenceTypeEnum.vacation: 'vacation',
};
