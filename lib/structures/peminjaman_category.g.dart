// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'peminjaman_category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PeminjamanCategoryAdapter extends TypeAdapter<PeminjamanCategory> {
  @override
  final int typeId = 9;

  @override
  PeminjamanCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return PeminjamanCategory.barang;
      case 1:
        return PeminjamanCategory.ruangan;
      case 2:
        return PeminjamanCategory.kendaraan;
      default:
        return PeminjamanCategory.barang;
    }
  }

  @override
  void write(BinaryWriter writer, PeminjamanCategory obj) {
    switch (obj) {
      case PeminjamanCategory.barang:
        writer.writeByte(0);
        break;
      case PeminjamanCategory.ruangan:
        writer.writeByte(1);
        break;
      case PeminjamanCategory.kendaraan:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PeminjamanCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
