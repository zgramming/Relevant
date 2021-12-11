// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'joined_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JoinedEventModel _$JoinedEventModelFromJson(Map<String, dynamic> json) =>
    JoinedEventModel(
      id: json['id'] as int? ?? 0,
      joinedDate: DateTime.parse(json['joined_date'] as String),
      namaRelawan: json['nama_relawan'] as String? ?? '',
      emailRelawan: json['email_relawan'] as String? ?? '',
      profileRelawan: json['profile_relawan'] as String?,
    );

Map<String, dynamic> _$JoinedEventModelToJson(JoinedEventModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'joined_date': instance.joinedDate.toIso8601String(),
      'nama_relawan': instance.namaRelawan,
      'email_relawan': instance.emailRelawan,
      'profile_relawan': instance.profileRelawan,
    };
