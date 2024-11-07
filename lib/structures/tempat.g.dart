// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tempat.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TempatAdapter extends TypeAdapter<Tempat> {
  @override
  final int typeId = 3;

  @override
  Tempat read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Tempat(
      id: fields[0] as String,
      name: fields[1] as String,
      category: fields[2] as TempatCategory,
      photo: fields[3] as String,
      createdAt: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Tempat obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.category)
      ..writeByte(3)
      ..write(obj.photo)
      ..writeByte(4)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TempatAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
