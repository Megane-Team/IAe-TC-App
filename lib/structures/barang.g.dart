// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barang.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BarangAdapter extends TypeAdapter<Barang> {
  @override
  final int typeId = 7;

  @override
  Barang read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Barang(
      id: fields[0] as int,
      name: fields[2] as String,
      code: fields[3] as String,
      status: fields[4] as String,
      condition: fields[5] as String,
      warranty: fields[6] as String,
      photo: fields[7] as String?,
      ruanganId: fields[8] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Barang obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.code)
      ..writeByte(4)
      ..write(obj.status)
      ..writeByte(5)
      ..write(obj.condition)
      ..writeByte(6)
      ..write(obj.warranty)
      ..writeByte(7)
      ..write(obj.photo)
      ..writeByte(8)
      ..write(obj.ruanganId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BarangAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
