// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ruangan_category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RuanganCategoryAdapter extends TypeAdapter<RuanganCategory> {
  @override
  final int typeId = 5;

  @override
  RuanganCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return RuanganCategory.kelas;
      case 1:
        return RuanganCategory.lab;
      case 2:
        return RuanganCategory.gudang;
      default:
        return RuanganCategory.kelas;
    }
  }

  @override
  void write(BinaryWriter writer, RuanganCategory obj) {
    switch (obj) {
      case RuanganCategory.kelas:
        writer.writeByte(0);
        break;
      case RuanganCategory.lab:
        writer.writeByte(1);
        break;
      case RuanganCategory.gudang:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RuanganCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
