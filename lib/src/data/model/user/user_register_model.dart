import 'package:equatable/equatable.dart';
import '../../../utils/utils.dart';

class UserRegisterModel extends Equatable {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;
  final UserType userType;
  final int? idTypeOrganization;
  final String? address;

  const UserRegisterModel({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.userType,
    this.idTypeOrganization,
    this.address,
  });

  @override
  List<Object?> get props {
    return [
      name,
      email,
      password,
      passwordConfirmation,
      userType,
      idTypeOrganization,
      address,
    ];
  }

  @override
  bool get stringify => true;

  UserRegisterModel copyWith({
    String? name,
    String? email,
    String? password,
    String? passwordConfirmation,
    UserType? userType,
    int? idTypeOrganization,
    String? address,
  }) {
    return UserRegisterModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
      userType: userType ?? this.userType,
      idTypeOrganization: idTypeOrganization ?? this.idTypeOrganization,
      address: address ?? this.address,
    );
  }
}
