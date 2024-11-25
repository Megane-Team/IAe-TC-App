// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifikasi_category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotifikasiCategoryAdapter extends TypeAdapter<NotifikasiCategory> {
  @override
  final int typeId = 13;

  @override
  NotifikasiCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return NotifikasiCategory.PB;
      case 1:
        return NotifikasiCategory.DK;
      case 2:
        return NotifikasiCategory.PG;
      case 3:
        return NotifikasiCategory.PDB;
      case 4:
        return NotifikasiCategory.PDT;
      case 5:
        return NotifikasiCategory.JT;
      case 6:
        return NotifikasiCategory.DO;
      case 7:
        return NotifikasiCategory.PP;
      default:
        return NotifikasiCategory.PB;
    }
  }

  @override
  void write(BinaryWriter writer, NotifikasiCategory obj) {
    switch (obj) {
      case NotifikasiCategory.PB:
        writer.writeByte(0);
        break;
      case NotifikasiCategory.DK:
        writer.writeByte(1);
        break;
      case NotifikasiCategory.PG:
        writer.writeByte(2);
        break;
      case NotifikasiCategory.PDB:
        writer.writeByte(3);
        break;
      case NotifikasiCategory.PDT:
        writer.writeByte(4);
        break;
      case NotifikasiCategory.JT:
        writer.writeByte(5);
        break;
      case NotifikasiCategory.DO:
        writer.writeByte(6);
        break;
      case NotifikasiCategory.PP:
        writer.writeByte(7);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotifikasiCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
