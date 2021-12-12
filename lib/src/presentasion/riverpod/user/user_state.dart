part of 'user_notifier.dart';

class UserState extends Equatable {
  const UserState({
    this.item,
    this.message = '',
    this.actionLoginState = RequestState.empty,
    this.actionRegisterState = RequestState.empty,
  });

  final User? item;
  final String message;
  final RequestState actionLoginState;
  final RequestState actionRegisterState;

  UserState init(User? user) => copyWith(item: user);
  UserState setMessage(String message) => copyWith(message: message);

  UserState setactionLoginState(RequestState state) => copyWith(actionLoginState: state);
  UserState setactionRegisterState(RequestState state) => copyWith(actionRegisterState: state);

  @override
  List<Object?> get props => [item, message, actionLoginState, actionRegisterState];

  @override
  bool get stringify => true;

  UserState copyWith({
    User? item,
    String? message,
    RequestState? actionLoginState,
    RequestState? actionRegisterState,
  }) {
    return UserState(
      item: item ?? this.item,
      message: message ?? this.message,
      actionLoginState: actionLoginState ?? this.actionLoginState,
      actionRegisterState: actionRegisterState ?? this.actionRegisterState,
    );
  }
}
