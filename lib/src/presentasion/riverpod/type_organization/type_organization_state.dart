part of 'type_organization_notifier.dart';

class TypeOrganizationState extends Equatable {
  const TypeOrganizationState({
    this.items = const [],
    this.message = '',
    this.state = RequestState.empty,
    this.actionType = ActionType.empty,
  });

  final List<TypeOrganization> items;
  final String message;
  final RequestState state;
  final ActionType actionType;

  TypeOrganizationState init(List<TypeOrganization> values) => copyWith(items: [...values]);

  @override
  List<Object> get props => [items, message, state, actionType];

  @override
  bool get stringify => true;

  TypeOrganizationState copyWith({
    List<TypeOrganization>? items,
    String? message,
    RequestState? state,
    ActionType? actionType,
  }) {
    return TypeOrganizationState(
      items: items ?? this.items,
      message: message ?? this.message,
      state: state ?? this.state,
      actionType: actionType ?? this.actionType,
    );
  }
}
