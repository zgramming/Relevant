part of 'user_notifier.dart';

class UserState extends Equatable {
  const UserState({
    this.item,
    this.message = '',
    this.actionLoginState = RequestState.empty,
    this.actionRegisterState = RequestState.empty,
    this.actionUpdateState = RequestState.empty,
    this.actionChangePasswordState = RequestState.empty,
  });

  final User? item;
  final String message;
  final RequestState actionLoginState;
  final RequestState actionRegisterState;
  final RequestState actionUpdateState;
  final RequestState actionChangePasswordState;

  UserState init(User? user) => copyWith(item: user);
  UserState setMessage(String message) => copyWith(message: message);

  UserState setActionLoginState(RequestState state) => copyWith(actionLoginState: state);
  UserState setActionRegisterState(RequestState state) => copyWith(actionRegisterState: state);
  UserState setActionUpdateState(RequestState state) => copyWith(actionUpdateState: state);
  UserState setActionChangePasswordState(RequestState state) =>
      copyWith(actionChangePasswordState: state);

  @override
  List<Object?> get props {
    return [
      item,
      message,
      actionLoginState,
      actionRegisterState,
      actionUpdateState,
      actionChangePasswordState,
    ];
  }

  @override
  bool get stringify => true;

  UserState copyWith({
    User? item,
    String? message,
    RequestState? actionLoginState,
    RequestState? actionRegisterState,
    RequestState? actionUpdateState,
    RequestState? actionChangePasswordState,
  }) {
    return UserState(
      item: item ?? this.item,
      message: message ?? this.message,
      actionLoginState: actionLoginState ?? this.actionLoginState,
      actionRegisterState: actionRegisterState ?? this.actionRegisterState,
      actionUpdateState: actionUpdateState ?? this.actionUpdateState,
      actionChangePasswordState: actionChangePasswordState ?? this.actionChangePasswordState,
    );
  }
}
