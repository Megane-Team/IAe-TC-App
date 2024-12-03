// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ruangan.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RuangansAdapter extends TypeAdapter<Ruangans> {
  @override
  final int typeId = 6;

  @override
  Ruangans read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Ruangans(
      id: fields[0] as int,
      code: fields[1] as String,
      status: fields[2] as bool,
      capacity: fields[3] as int?,
      category: fields[4] as RuanganCategory?,
      photo: fields[5] as String?,
      tempatId: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Ruangans obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.code)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.capacity)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.photo)
      ..writeByte(6)
      ..write(obj.tempatId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RuangansAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
