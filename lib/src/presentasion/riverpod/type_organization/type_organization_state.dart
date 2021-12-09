part of 'type_organization_notifier.dart';

class TypeOrganizationState extends Equatable {
  const TypeOrganizationState({
    this.items = const [],
    this.message = '',
    this.state = RequestState.empty,
  });

  final List<TypeOrganization> items;
  final String message;
  final RequestState state;

  TypeOrganizationState init(List<TypeOrganization> values) => copyWith(items: [...values]);
  TypeOrganizationState setMessage(String message) => copyWith(message: message);
  TypeOrganizationState setState(RequestState state) => copyWith(state: state);

  @override
  List<Object> get props => [items, message, state];

  @override
  bool get stringify => true;

  TypeOrganizationState copyWith({
    List<TypeOrganization>? items,
    String? message,
    RequestState? state,
  }) {
    return TypeOrganizationState(
      items: items ?? this.items,
      message: message ?? this.message,
      state: state ?? this.state,
    );
  }
}
