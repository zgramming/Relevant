// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enum_state.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EventTypeAdapter extends TypeAdapter<EventType> {
  @override
  final int typeId = 1;

  @override
  EventType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return EventType.offline;
      case 1:
        return EventType.online;
      default:
        return EventType.offline;
    }
  }

  @override
  void write(BinaryWriter writer, EventType obj) {
    switch (obj) {
      case EventType.offline:
        writer.writeByte(0);
        break;
      case EventType.online:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

const _$UserTypeEnumMap = {
  UserType.relawan: 'relawan',
  UserType.organisasi: 'organisasi',
};

const _$EventTypeEnumMap = {
  EventType.offline: 'offline',
  EventType.online: 'online',
};
