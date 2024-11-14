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
      status: fields[1] as String,
      category: fields[2] as PeminjamanCategory,
      borrowedDate: fields[3] as DateTime,
      estimatedTime: fields[4] as DateTime,
      returnDate: fields[5] as DateTime?,
      objective: fields[6] as String,
      pasengger: fields[7] as int?,
      userId: fields[8] as int,
      ruanganId: fields[9] as int?,
      barangId: fields[10] as int?,
      kendaraanId: fields[11] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Peminjaman obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.status)
      ..writeByte(2)
      ..write(obj.category)
      ..writeByte(3)
      ..write(obj.borrowedDate)
      ..writeByte(4)
      ..write(obj.estimatedTime)
      ..writeByte(5)
      ..write(obj.returnDate)
      ..writeByte(6)
      ..write(obj.objective)
      ..writeByte(7)
      ..write(obj.pasengger)
      ..writeByte(8)
      ..write(obj.userId)
      ..writeByte(9)
      ..write(obj.ruanganId)
      ..writeByte(10)
      ..write(obj.barangId)
      ..writeByte(11)
      ..write(obj.kendaraanId);
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
