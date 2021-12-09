import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'src/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();

  runApp(
    const ProviderScope(
      observers: [],
      // overrides: [],
      child: MyApp(),
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
