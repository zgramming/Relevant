part of 'user_notifier.dart';

class UserState extends Equatable {
  const UserState({
    this.item = const User(),
    this.message = '',
    this.state = RequestState.empty,
  });

  final User item;
  final String message;
  final RequestState state;

  UserState init(User user) => copyWith(item: user);
  UserState setMessage(String message) => copyWith(message: message);
  UserState setState(RequestState state) => copyWith(state: state);

  @override
  List<Object> get props => [item, message, state];

  @override
  bool get stringify => true;

  UserState copyWith({
    User? item,
    String? message,
    RequestState? state,
  }) {
    return UserState(
      item: item ?? this.item,
      message: message ?? this.message,
      state: state ?? this.state,
    );
  }
}
