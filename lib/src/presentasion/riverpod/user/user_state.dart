part of 'user_notifier.dart';

class UserState extends Equatable {
  const UserState({
    this.item,
    this.message = '',
    this.actionLoginState = RequestState.empty,
    this.actionRegisterState = RequestState.empty,
    this.actionUpdateState = RequestState.empty,
  });

  final User? item;
  final String message;
  final RequestState actionLoginState;
  final RequestState actionRegisterState;
  final RequestState actionUpdateState;

  UserState init(User? user) => copyWith(item: user);
  UserState setMessage(String message) => copyWith(message: message);

  UserState setActionLoginState(RequestState state) => copyWith(actionLoginState: state);
  UserState setActionRegisterState(RequestState state) => copyWith(actionRegisterState: state);
  UserState setActionUpdateState(RequestState state) => copyWith(actionUpdateState: state);

  @override
  List<Object?> get props {
    return [
      item,
      message,
      actionLoginState,
      actionRegisterState,
      actionUpdateState,
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
  }) {
    return UserState(
      item: item ?? this.item,
      message: message ?? this.message,
      actionLoginState: actionLoginState ?? this.actionLoginState,
      actionRegisterState: actionRegisterState ?? this.actionRegisterState,
      actionUpdateState: actionUpdateState ?? this.actionUpdateState,
    );
  }
}
