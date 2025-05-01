import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class MemberEntity extends Equatable {
  final int crewId;
  final int id;
  final String image;
  final String name;
  final int userId;

  const MemberEntity({
    required this.crewId,
    required this.id,
    required this.image,
    required this.name,
    required this.userId,
  });

  @override
  List<Object?> get props => [crewId, id, image, name, userId];
}
