import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/domain/entities/member_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'member_model.g.dart';

/// Data layer representation of a Member, used for serialization.
@JsonSerializable()
class MemberModel extends MemberEntity {
  const MemberModel({
    required super.crewId,
    required super.id,
    required super.image,
    required super.name,
    required super.userId,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) =>
      _$MemberModelFromJson(json);
}
