// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detailPeminjaman.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DetailPeminjamanAdapter extends TypeAdapter<DetailPeminjaman> {
  @override
  final int typeId = 15;

  @override
  DetailPeminjaman read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DetailPeminjaman(
      id: fields[0] as int,
      status: fields[1] as PeminjamanStatus,
      borrowedDate: fields[2] as DateTime?,
      estimatedTime: fields[3] as DateTime?,
      returnDate: fields[4] as DateTime?,
      objective: fields[5] as String,
      destination: fields[6] as String?,
      passenger: fields[7] as int?,
      userId: fields[8] as int,
      createdAt: fields[9] as DateTime,
      canceledReason: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DetailPeminjaman obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.status)
      ..writeByte(2)
      ..write(obj.borrowedDate)
      ..writeByte(3)
      ..write(obj.estimatedTime)
      ..writeByte(4)
      ..write(obj.returnDate)
      ..writeByte(5)
      ..write(obj.objective)
      ..writeByte(6)
      ..write(obj.destination)
      ..writeByte(7)
      ..write(obj.passenger)
      ..writeByte(8)
      ..write(obj.userId)
      ..writeByte(9)
      ..write(obj.createdAt)
      ..writeByte(10)
      ..write(obj.canceledReason);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DetailPeminjamanAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
