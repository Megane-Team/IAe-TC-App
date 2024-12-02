// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifikasi.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotifikasisAdapter extends TypeAdapter<Notifikasis> {
  @override
  final int typeId = 12;

  @override
  Notifikasis read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Notifikasis(
      id: fields[0] as int,
      category: fields[1] as NotifikasiCategory,
      isRead: fields[2] as bool,
      userId: fields[3] as int,
      notifikasiId: fields[4] as int,
      createdAt: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Notifikasis obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.isRead)
      ..writeByte(3)
      ..write(obj.userId)
      ..writeByte(4)
      ..write(obj.notifikasiId)
      ..writeByte(5)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotifikasisAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
