import 'package:equatable/equatable.dart';

class UserChangePasswordFormModel extends Equatable {
  const UserChangePasswordFormModel({
    this.oldPassword,
    this.newPassword,
    this.newPasswordConfirmation,
    this.idUser,
  });
  final String? oldPassword;
  final String? newPassword;
  final String? newPasswordConfirmation;
  final int? idUser;

  @override
  bool get stringify => true;
  @override
  List<Object?> get props => [oldPassword, newPassword, newPasswordConfirmation, idUser];

  UserChangePasswordFormModel copyWith({
    String? oldPassword,
    String? newPassword,
    String? newPasswordConfirmation,
    int? idUser,
  }) {
    return UserChangePasswordFormModel(
      oldPassword: oldPassword ?? this.oldPassword,
      newPassword: newPassword ?? this.newPassword,
      newPasswordConfirmation: newPasswordConfirmation ?? this.newPasswordConfirmation,
      idUser: idUser ?? this.idUser,
    );
  }
}
