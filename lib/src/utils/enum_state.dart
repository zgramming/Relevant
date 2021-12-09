import 'package:json_annotation/json_annotation.dart';
part 'enum_state.g.dart';

@JsonEnum(alwaysCreate: true)
enum UserType { relawan, organisasi }

const Map<UserType, String> userTypeToValue = {
  UserType.relawan: 'relawan',
  UserType.organisasi: 'organisasi',
};

enum RequestState { empty, loading, loaded, error }
