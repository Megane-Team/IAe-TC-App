// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'peminjaman.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PeminjamanAdapter extends TypeAdapter<Peminjaman> {
  @override
  final int typeId = 8;

  @override
  Peminjaman read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Peminjaman(
      id: fields[0] as int,
      category: fields[1] as PeminjamanCategory,
      userId: fields[2] as int,
      ruanganId: fields[3] as int?,
      barangId: fields[4] as int?,
      kendaraanId: fields[5] as int?,
      detailPeminjamanId: fields[6] as int?,
      createdAt: fields[7] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Peminjaman obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.userId)
      ..writeByte(3)
      ..write(obj.ruanganId)
      ..writeByte(4)
      ..write(obj.barangId)
      ..writeByte(5)
      ..write(obj.kendaraanId)
      ..writeByte(6)
      ..write(obj.detailPeminjamanId)
      ..writeByte(7)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PeminjamanAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
