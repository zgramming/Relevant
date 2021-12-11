// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_nearest_date_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventNearestDateModel _$EventNearestDateModelFromJson(
        Map<String, dynamic> json) =>
    EventNearestDateModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
      type: $enumDecodeNullable(_$EventTypeEnumMap, json['type']) ??
          EventType.online,
      quota: json['quota'] as int? ?? 0,
      image: json['image'] as String?,
      namaCategory: json['nama_category'] as String? ?? '',
      namaOrganisasi: json['nama_organisasi'] as String? ?? '',
    );

Map<String, dynamic> _$EventNearestDateModelToJson(
        EventNearestDateModel instance) =>
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
