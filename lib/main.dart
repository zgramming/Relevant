import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await initializeDateFormatting();

  runApp(
    ProviderScope(
      observers: [
        Logger(),
      ],
      // overrides: [],
      child: const MyApp(),
    ),
  );
}

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
