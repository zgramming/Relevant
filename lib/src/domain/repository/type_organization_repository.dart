import '../../data/model/type_organization/type_organization_model.dart';

abstract class TypeOrganizationRepository {
  Future<List<TypeOrganization>> get();
}
