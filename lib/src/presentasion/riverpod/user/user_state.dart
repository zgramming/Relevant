part of 'user_notifier.dart';

class UserState extends Equatable {
  const UserState({
    this.item = const User(),
    this.actionState = RequestState.empty,
    this.message = '',
  });

  final User item;
  final RequestState actionState;
  final String message;

  UserState init(User user) => copyWith(item: user);
  UserState setActionState(RequestState state) => copyWith(actionState: state);
  UserState setMessage(String message) => copyWith(message: message);

  @override
  List<Object> get props => [item, actionState, message];

  @override
  bool get stringify => true;

  UserState copyWith({
    User? item,
    RequestState? actionState,
    String? message,
  }) {
    return UserState(
      item: item ?? this.item,
      actionState: actionState ?? this.actionState,
      message: message ?? this.message,
    );
  }
}
