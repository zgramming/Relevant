// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int? ?? 0,
      idTypeOrganization: json['id_type_organization'] as int?,
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      type: $enumDecodeNullable(_$UserTypeEnumMap, json['type']) ??
          UserType.relawan,
      pictureProfile: json['picture_profile'] as String?,
      phone: json['phone'] as String?,
      logo: json['logo'] as String?,
      address: json['address'] as String?,
      website: json['website'] as String?,
      whatsappContact: json['whatsapp_contact'] as String?,
      emailContact: json['email_contact'] as String?,
      instagramContact: json['instagram_contact'] as String?,
      birthDate: json['birth_date'] == null
          ? null
          : DateTime.parse(json['birth_date'] as String),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'id_type_organization': instance.idTypeOrganization,
      'name': instance.name,
      'email': instance.email,
      'type': _$UserTypeEnumMap[instance.type],
      'picture_profile': instance.pictureProfile,
      'phone': instance.phone,
      'logo': instance.logo,
      'address': instance.address,
      'website': instance.website,
      'whatsapp_contact': instance.whatsappContact,
      'email_contact': instance.emailContact,
      'instagram_contact': instance.instagramContact,
      'birth_date': instance.birthDate?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

const _$UserTypeEnumMap = {
  UserType.relawan: 'relawan',
  UserType.organisasi: 'organisasi',
};
