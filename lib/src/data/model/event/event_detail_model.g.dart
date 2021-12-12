// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventDetailModel _$EventDetailModelFromJson(Map<String, dynamic> json) =>
    EventDetailModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      type: $enumDecodeNullable(_$EventTypeEnumMap, json['type']) ??
          EventType.online,
      description: json['description'] as String? ?? '',
      startDate: json['start_date'] == null
          ? null
          : DateTime.parse(json['start_date'] as String),
      endDate: json['end_date'] == null
          ? null
          : DateTime.parse(json['end_date'] as String),
      location: json['location'] as String? ?? '',
      quota: json['quota'] as int? ?? 0,
      image: json['image'] as String?,
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      namaCategory: json['nama_category'] as String? ?? '',
      namaOrganisasi: json['nama_organisasi'] as String? ?? '',
      websiteOrganisasi: json['website_organisasi'] as String?,
      whatsappOrganisasi: json['whatsapp_organisasi'] as String?,
      emailOrganisasi: json['email_organisasi'] as String?,
      instagramOrganisasi: json['instagram_organisasi'] as String?,
      totalJoinedEvent: json['total_joined_event'] as int? ?? 0,
      joinedEvent: (json['joined_event'] as List<dynamic>?)
              ?.map((e) => JoinedEventModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isAlreadyJoinEvent: json['is_already_join_event'] as bool? ?? false,
    );

Map<String, dynamic> _$EventDetailModelToJson(EventDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'type': _$EventTypeEnumMap[instance.type],
      'description': instance.description,
      'start_date': instance.startDate?.toIso8601String(),
      'end_date': instance.endDate?.toIso8601String(),
      'location': instance.location,
      'quota': instance.quota,
      'image': instance.image,
      'updated_at': instance.updatedAt?.toIso8601String(),
      'nama_category': instance.namaCategory,
      'nama_organisasi': instance.namaOrganisasi,
      'website_organisasi': instance.websiteOrganisasi,
      'whatsapp_organisasi': instance.whatsappOrganisasi,
      'email_organisasi': instance.emailOrganisasi,
      'instagram_organisasi': instance.instagramOrganisasi,
      'total_joined_event': instance.totalJoinedEvent,
      'joined_event': instance.joinedEvent,
      'is_already_join_event': instance.isAlreadyJoinEvent,
    };

const _$EventTypeEnumMap = {
  EventType.offline: 'offline',
  EventType.online: 'online',
};
