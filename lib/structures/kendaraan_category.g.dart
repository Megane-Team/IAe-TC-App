// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kendaraan_category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KendaraanCategoryAdapter extends TypeAdapter<KendaraanCategory> {
  @override
  final int typeId = 10;

  @override
  KendaraanCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return KendaraanCategory.mobil;
      case 1:
        return KendaraanCategory.motor;
      case 2:
        return KendaraanCategory.truk;
      default:
        return KendaraanCategory.mobil;
    }
  }

  @override
  void write(BinaryWriter writer, KendaraanCategory obj) {
    switch (obj) {
      case KendaraanCategory.mobil:
        writer.writeByte(0);
        break;
      case KendaraanCategory.motor:
        writer.writeByte(1);
        break;
      case KendaraanCategory.truk:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KendaraanCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
