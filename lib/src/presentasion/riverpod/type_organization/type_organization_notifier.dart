import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:relevant/injection.dart';

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
    final result = await repository.get();
    state = state.init(result);
  }
}

final futureGetTypeOrganization = FutureProvider.autoDispose((ref) async {
  await ref.watch(typeOrganizationNotifier.notifier).get();
  return true;
});
