import 'package:dartz/dartz.dart';

import '../../data/model/type_organization/type_organization_model.dart';
import '../../utils/utils.dart';

abstract class TypeOrganizationRepository {
  Future<Either<Failure, List<TypeOrganization>>> get();
}
