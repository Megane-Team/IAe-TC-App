// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kendaraan.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KendaraanAdapter extends TypeAdapter<Kendaraan> {
  @override
  final int typeId = 10;

  @override
  Kendaraan read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Kendaraan(
      id: fields[0] as int,
      name: fields[1] as String,
      plat: fields[2] as String,
      status: fields[3] as String,
      condition: fields[4] as String,
      warranty: fields[5] as DateTime,
      capacity: fields[6] as int,
      category: fields[7] as KendaraanCategory?,
      color: fields[8] as String,
      photo: fields[9] as String?,
      tempatId: fields[10] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Kendaraan obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.plat)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.condition)
      ..writeByte(5)
      ..write(obj.warranty)
      ..writeByte(6)
      ..write(obj.capacity)
      ..writeByte(7)
      ..write(obj.category)
      ..writeByte(8)
      ..write(obj.color)
      ..writeByte(9)
      ..write(obj.photo)
      ..writeByte(10)
      ..write(obj.tempatId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KendaraanAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
