// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_for_you_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventForYouModel _$EventForYouModelFromJson(Map<String, dynamic> json) =>
    EventForYouModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
      type: $enumDecode(_$EventTypeEnumMap, json['type']),
      quota: json['quota'] as int? ?? 0,
      image: json['image'] as String?,
      namaCategory: json['nama_category'] as String? ?? '',
      namaOrganisasi: json['nama_organisasi'] as String? ?? '',
    );

Map<String, dynamic> _$EventForYouModelToJson(EventForYouModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'start_date': instance.startDate.toIso8601String(),
      'end_date': instance.endDate.toIso8601String(),
      'type': _$EventTypeEnumMap[instance.type],
      'quota': instance.quota,
      'image': instance.image,
      'nama_category': instance.namaCategory,
      'nama_organisasi': instance.namaOrganisasi,
    };

const _$EventTypeEnumMap = {
  EventType.offline: 'offline',
  EventType.online: 'online',
};
