import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../../utils/utils.dart';

part 'user_model.g.dart';

@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class User extends Equatable {
  final int id;
  final int? idTypeOrganization;
  final String name;
  final String email;
  final UserType type;
  final String? pictureProfile;
  final String? phone;
  final String? logo;
  final String? address;
  final String? website;
  final String? whatsappContact;
  final String? emailContact;
  final String? instagramContact;
  final DateTime? birthDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const User({
    this.id = 0,
    this.idTypeOrganization,
    this.name = '',
    this.email = '',
    this.type = UserType.relawan,
    this.pictureProfile,
    this.phone,
    this.logo,
    this.address,
    this.website,
    this.whatsappContact,
    this.emailContact,
    this.instagramContact,
    this.birthDate,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props {
    return [
      id,
      idTypeOrganization,
      name,
      email,
      type,
      pictureProfile,
      phone,
      logo,
      address,
      website,
      whatsappContact,
      emailContact,
      instagramContact,
      birthDate,
      createdAt,
      updatedAt,
    ];
  }

  @override
  bool get stringify => true;

  User copyWith({
    int? id,
    int? idTypeOrganization,
    String? name,
    String? email,
    UserType? type,
    String? pictureProfile,
    String? phone,
    String? logo,
    String? address,
    String? website,
    String? whatsappContact,
    String? emailContact,
    String? instagramContact,
    DateTime? birthDate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      idTypeOrganization: idTypeOrganization ?? this.idTypeOrganization,
      name: name ?? this.name,
      email: email ?? this.email,
      type: type ?? this.type,
      pictureProfile: pictureProfile ?? this.pictureProfile,
      phone: phone ?? this.phone,
      logo: logo ?? this.logo,
      address: address ?? this.address,
      website: website ?? this.website,
      whatsappContact: whatsappContact ?? this.whatsappContact,
      emailContact: emailContact ?? this.emailContact,
      instagramContact: instagramContact ?? this.instagramContact,
      birthDate: birthDate ?? this.birthDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
