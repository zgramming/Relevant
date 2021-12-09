import 'package:json_annotation/json_annotation.dart';
part 'enum_state.g.dart';

@JsonEnum(alwaysCreate: true)
enum UserType { relawan, organisasi }
enum TypeEvent { offline, online }

enum RequestState { empty, loading, loaded, error }

const userTypeToValue = <UserType, String>{
  UserType.relawan: 'relawan',
  UserType.organisasi: 'organisasi',
};

const typeEventToValue = <TypeEvent, String>{
  TypeEvent.offline: 'offline',
  TypeEvent.online: 'online',
};
