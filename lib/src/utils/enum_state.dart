import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'enum_state.g.dart';

@JsonEnum(alwaysCreate: true)
enum UserType { relawan, organisasi }

@HiveType(typeId: 1)
@JsonEnum(alwaysCreate: true)
enum EventType {
  @HiveField(0)
  offline,
  @HiveField(1)
  online,
}

enum RequestState { empty, loading, loaded, error }
enum ActionType { empty, create, read, update, delete }

const userTypeToValue = <UserType, String>{
  UserType.relawan: 'relawan',
  UserType.organisasi: 'organisasi',
};

const eventTypeToValue = <EventType, String>{
  EventType.offline: 'offline',
  EventType.online: 'online',
};
