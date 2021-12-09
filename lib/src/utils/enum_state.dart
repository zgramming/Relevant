import 'package:json_annotation/json_annotation.dart';

@JsonEnum(alwaysCreate: true)
enum UserType { relawan, organisasi }

@JsonEnum(alwaysCreate: true)
enum EventType { offline, online }

enum RequestState { empty, loading, loaded, error }

const userTypeToValue = <UserType, String>{
  UserType.relawan: 'relawan',
  UserType.organisasi: 'organisasi',
};

const eventTypeToValue = <EventType, String>{
  EventType.offline: 'offline',
  EventType.online: 'online',
};
