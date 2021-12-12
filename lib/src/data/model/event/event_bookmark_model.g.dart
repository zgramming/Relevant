// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_bookmark_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EventBookmarkModelAdapter extends TypeAdapter<EventBookmarkModel> {
  @override
  final int typeId = 0;

  @override
  EventBookmarkModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EventBookmarkModel(
      id: fields[0] as int,
      title: fields[1] as String,
      startDate: fields[2] as DateTime,
      endDate: fields[3] as DateTime,
      type: fields[4] as EventType,
      quota: fields[5] as int,
      image: fields[6] as String?,
      namaCategory: fields[7] as String,
      namaOrganisasi: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, EventBookmarkModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.startDate)
      ..writeByte(3)
      ..write(obj.endDate)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.quota)
      ..writeByte(6)
      ..write(obj.image)
      ..writeByte(7)
      ..write(obj.namaCategory)
      ..writeByte(8)
      ..write(obj.namaOrganisasi);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventBookmarkModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
