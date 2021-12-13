part of 'user_notifier.dart';

class UserState extends Equatable {
  const UserState({
    this.item,
    this.message = '',
    this.state = RequestState.empty,
    this.actionType = ActionType.empty,
  });

  final User? item;
  final String message;
  final RequestState state;
  final ActionType actionType;

  UserState init(User? user) => copyWith(item: user);
  UserState onLoadingState(ActionType actionType) =>
      copyWith(state: RequestState.loading, actionType: actionType);
  UserState onErrorState(String message) => copyWith(state: RequestState.error, message: message);

  ///* START Login
  UserState onSuccessLogin(User user) => copyWith(
        item: user,
        state: RequestState.loaded,
      );

  UserState onSuccessRegister(User user) => copyWith(
        item: user,
        state: RequestState.loaded,
      );

  UserState onSuccessUpdateProfile(User user) => copyWith(
        item: user,
        state: RequestState.loaded,
      );
  UserState onSuccessChangePassword(User user) => copyWith(
        item: user,
        state: RequestState.loaded,
      );

  ///* END Login

  ///* START Register
  ///* END Register

  ///* START ChangePassword
  ///* END ChangePassword
  @override
  List<Object?> get props => [item, message, state, actionType];

  @override
  bool get stringify => true;

  UserState copyWith({
    User? item,
    String? message,
    RequestState? state,
    ActionType? actionType,
  }) {
    return UserState(
      item: item ?? this.item,
      message: message ?? this.message,
      state: state ?? this.state,
      actionType: actionType ?? this.actionType,
    );
  }
}
