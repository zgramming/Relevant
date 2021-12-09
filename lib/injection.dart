import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/data/datasource/type_organization_remote_datasource.dart';
import 'src/data/datasource/user_remote_datasource.dart';
import 'src/data/repository/type_organization_impl.dart';
import 'src/data/repository/user_repository_impl.dart';
import 'src/presentasion/riverpod/type_organization/type_organization_notifier.dart';
import 'src/presentasion/riverpod/user/user_notifier.dart';

///* START RIVERPOD
final userNotifier = StateNotifierProvider<UserNotifier, UserState>(
  (ref) => UserNotifier(repository: ref.read(_userRepository)),
);

final typeOrganizationNotifier =
    StateNotifierProvider<TypeOrganizationNotifier, TypeOrganizationState>(
  (ref) => TypeOrganizationNotifier(repository: ref.read(_typeOrganizationRepository)),
);

///* END RIVERPOD

///* START REPOSITORY
final _userRepository = Provider(
  (ref) => UserRepositoryImpl(remoteDataSource: ref.read(_userRemoteDataSource)),
);

final _typeOrganizationRepository = Provider(
  (ref) =>
      TypeOrganizationRepositoryImpl(remoteDataSource: ref.read(_typeOrganizationRemoteDataSource)),
);

///* END REPOSITORY

///* START Remote DataSource
final _userRemoteDataSource = Provider((ref) => UserRemoteDataSource());
final _typeOrganizationRemoteDataSource = Provider((ref) => TypeOrganizationRemoteDataSource());
///* END Remote DataSource

///* START Local DataSource
///* END Local DataSource
