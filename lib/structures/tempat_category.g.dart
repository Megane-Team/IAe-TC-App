// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tempat_category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TempatCategoryAdapter extends TypeAdapter<TempatCategory> {
  @override
  final int typeId = 4;

  @override
  TempatCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TempatCategory.parkiran;
      case 1:
        return TempatCategory.gedung;
      default:
        return TempatCategory.parkiran;
    }
  }

  @override
  void write(BinaryWriter writer, TempatCategory obj) {
    switch (obj) {
      case TempatCategory.parkiran:
        writer.writeByte(0);
        break;
      case TempatCategory.gedung:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TempatCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
