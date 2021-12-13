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
      idUser: fields[1] as int,
      title: fields[2] as String,
      startDate: fields[3] as DateTime,
      endDate: fields[4] as DateTime,
      type: fields[5] as EventType,
      quota: fields[6] as int,
      image: fields[7] as String?,
      namaCategory: fields[8] as String,
      namaOrganisasi: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, EventBookmarkModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.idUser)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.startDate)
      ..writeByte(4)
      ..write(obj.endDate)
      ..writeByte(5)
      ..write(obj.type)
      ..writeByte(6)
      ..write(obj.quota)
      ..writeByte(7)
      ..write(obj.image)
      ..writeByte(8)
      ..write(obj.namaCategory)
      ..writeByte(9)
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
