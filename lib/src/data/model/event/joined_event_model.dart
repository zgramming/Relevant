import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
part 'joined_event_model.g.dart';

@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class JoinedEventModel extends Equatable {
  const JoinedEventModel({
    this.id = 0,
    required this.joinedDate,
    this.namaRelawan = '',
    this.emailRelawan = '',
    this.profileRelawan,
  });

  final int id;
  final DateTime joinedDate;
  final String namaRelawan;
  final String emailRelawan;
  final String? profileRelawan;

  factory JoinedEventModel.fromJson(Map<String, dynamic> json) => _$JoinedEventModelFromJson(json);
  Map<String, dynamic> toJson() => _$JoinedEventModelToJson(this);

  JoinedEventModel copyWith({
    int? id,
    DateTime? joinedDate,
    String? namaRelawan,
    String? emailRelawan,
    String? profileRelawan,
  }) {
    return JoinedEventModel(
      id: id ?? this.id,
      joinedDate: joinedDate ?? this.joinedDate,
      namaRelawan: namaRelawan ?? this.namaRelawan,
      emailRelawan: emailRelawan ?? this.emailRelawan,
      profileRelawan: profileRelawan ?? this.profileRelawan,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      joinedDate,
      namaRelawan,
      emailRelawan,
      profileRelawan,
    ];
  }
}
