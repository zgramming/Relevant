import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/model/type_organization/type_organization_model.dart';
import '../../../domain/repository/type_organization_repository.dart';
import '../../../utils/utils.dart';

part 'type_organization_state.dart';

class TypeOrganizationNotifier extends StateNotifier<TypeOrganizationState> {
  TypeOrganizationNotifier({
    required this.repository,
  }) : super(const TypeOrganizationState());

  final TypeOrganizationRepository repository;

  Future<void> get() async {
    state = state.setState(RequestState.loading);
    final result = await repository.get();

    result.fold(
      (failure) {
        state = state.setMessage(failure.message);
        state = state.setState(RequestState.loaded);
      },
      (values) {
        state = state.init(values);
        state = state.setState(RequestState.loaded);
      },
    );
  }
}
