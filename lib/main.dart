import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'src/app.dart';
import 'src/data/model/event/event_bookmark_model.dart';
import 'src/presentasion/riverpod/global/global_notifier.dart';
import 'src/utils/utils.dart';

class Logger extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    log(
      '''
{
  "provider": "${provider.name ?? provider.runtimeType}",
  "newValue": "$newValue"
}''',
    );
  }
}

///? HiveType Legend :
///* 0 => EventForYouModel
///* 1 => EventType
Future<void> _initHive() async {
  /// Initialize for first time
  await Hive.initFlutter();

  /// Initialize Adapter
  Hive.registerAdapter(EventBookmarkModelAdapter());
  Hive.registerAdapter(EventTypeAdapter());
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initHive();

  /// Initialize openBox
  final eventBookmarkBox = await Hive.openBox<EventBookmarkModel>(keyBookmarkHive);
  runApp(
    ProviderScope(
      observers: [
        Logger(),
      ],
      overrides: [
        boxEventBookmark.overrideWithValue(eventBookmarkBox),
      ],
      child: const MyApp(),
    ),
  );
}

// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:global_template/global_template.dart';
// import 'package:json_annotation/json_annotation.dart';

// part 'sales_model.g.dart';

// @immutable
// @JsonSerializable(fieldRename: FieldRename.snake)

// class SalesModel extends Equatable{

// }
// @JsonKey(
//     toJson: GlobalFunction.toJsonStringFromInteger,
//     fromJson: GlobalFunction.fromJsonStringToInteger,
//   )

// factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
// Map<String, dynamic> toJson() => _$UserModelToJson(this);
