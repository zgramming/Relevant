import 'dart:io';

import 'package:equatable/equatable.dart';

import '../../../utils/utils.dart';

class UserUpdateFormModel extends Equatable {
  const UserUpdateFormModel({
    required this.id,
    this.name = '',
    required this.birthDate,
    this.phone = '',
    this.pictureProfile,
    this.logo,
    required this.type,
    this.address = '',
    this.website = '',
    this.whatsappContact = '',
    this.emailContact = '',
    this.instagramContact = '',
  });

  final int id;
  final String name;
  final DateTime birthDate;
  final String phone;
  final File? pictureProfile;
  final File? logo;
  final UserType type;

  /// Organisasi
  final String address;
  final String website;
  final String whatsappContact;
  final String emailContact;
  final String instagramContact;

  @override
  // TODO: implement stringify
  bool get stringify => true;
  @override
  List<Object?> get props {
    return [
      id,
      name,
      birthDate,
      phone,
      pictureProfile,
      logo,
      type,
      address,
      website,
      whatsappContact,
      emailContact,
      instagramContact,
    ];
  }

  UserUpdateFormModel copyWith({
    int? id,
    String? name,
    DateTime? birthDate,
    String? phone,
    File? pictureProfile,
    File? logo,
    UserType? type,
    String? address,
    String? website,
    String? whatsappContact,
    String? emailContact,
    String? instagramContact,
  }) {
    return UserUpdateFormModel(
      id: id ?? this.id,
      name: name ?? this.name,
      birthDate: birthDate ?? this.birthDate,
      phone: phone ?? this.phone,
      pictureProfile: pictureProfile ?? this.pictureProfile,
      logo: logo ?? this.logo,
      type: type ?? this.type,
      address: address ?? this.address,
      website: website ?? this.website,
      whatsappContact: whatsappContact ?? this.whatsappContact,
      emailContact: emailContact ?? this.emailContact,
      instagramContact: instagramContact ?? this.instagramContact,
    );
  }
}
