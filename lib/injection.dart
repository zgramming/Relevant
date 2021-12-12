import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/data/datasource/category_remote_datasource.dart';
import 'src/data/datasource/event_remote_datasource.dart';
import 'src/data/datasource/type_organization_remote_datasource.dart';
import 'src/data/datasource/user_local_datasource.dart';
import 'src/data/datasource/user_remote_datasource.dart';
import 'src/data/repository/category_repository_impl.dart';
import 'src/data/repository/event_repository_impl.dart';
import 'src/data/repository/type_organization_impl.dart';
import 'src/data/repository/user_repository_impl.dart';
import 'src/presentasion/riverpod/category/category_notifier.dart';
import 'src/presentasion/riverpod/event/event_detail_notifier.dart';
import 'src/presentasion/riverpod/event/event_for_you_notifier.dart';
import 'src/presentasion/riverpod/event/event_nearest_date_notifier.dart';
import 'src/presentasion/riverpod/event/event_notifier.dart';
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

final categoryNotifier = StateNotifierProvider<CategoryNotifier, CategoryState>(
  (ref) => CategoryNotifier(repository: ref.read(_categoryRepository)),
);

final eventNotifier = StateNotifierProvider<EventNotifier, EventState>(
  (ref) => EventNotifier(repository: ref.read(_eventRepository)),
);

final eventNearestDateNotifier =
    StateNotifierProvider<EventNearestDateNotifier, EventNearestDateState>(
  (ref) => EventNearestDateNotifier(repository: ref.read(_eventRepository)),
);

final eventForYouNotifier = StateNotifierProvider<EventForYouNotifier, EventForYouState>(
  (ref) => EventForYouNotifier(repository: ref.read(_eventRepository)),
);

final eventDetailNotifier = StateNotifierProvider<EventDetailNotifier, EventDetailState>(
  (ref) => EventDetailNotifier(repository: ref.read(_eventRepository)),
);

///* END RIVERPOD

///* START REPOSITORY
final _userRepository = Provider(
  (ref) => UserRepositoryImpl(
    remoteDataSource: ref.read(_userRemoteDataSource),
    localDataSource: ref.read(_userLocalDataSource),
  ),
);

final _typeOrganizationRepository = Provider(
  (ref) => TypeOrganizationRepositoryImpl(
    remoteDataSource: ref.read(_typeOrganizationRemoteDataSource),
  ),
);

final _categoryRepository = Provider(
  (ref) => CategoryRepositoryImpl(
    remoteDataSource: ref.read(_categoryRemoteDataSource),
  ),
);

final _eventRepository = Provider(
  (ref) => EventRepositoryImpl(
    remoteDataSource: ref.read(_eventRemoteDataSource),
  ),
);

///* END REPOSITORY

///* START Remote DataSource
final _userRemoteDataSource = Provider(
  (ref) => UserRemoteDataSource(),
);

final _typeOrganizationRemoteDataSource = Provider(
  (ref) => TypeOrganizationRemoteDataSource(),
);

final _categoryRemoteDataSource = Provider(
  (ref) => CategoryRemoteDataSource(),
);

final _eventRemoteDataSource = Provider(
  (ref) => EventRemoteDataSource(),
);

///* END Remote DataSource

///* START Local DataSource
final _userLocalDataSource = Provider(
  (ref) => UserLocalDataSource(),
);
///* END Local DataSource
