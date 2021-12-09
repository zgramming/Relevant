// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type_organization_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TypeOrganization _$TypeOrganizationFromJson(Map<String, dynamic> json) =>
    TypeOrganization(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$TypeOrganizationToJson(TypeOrganization instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
