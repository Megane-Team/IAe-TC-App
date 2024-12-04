// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'peminjaman_status.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PeminjamanStatusAdapter extends TypeAdapter<PeminjamanStatus> {
  @override
  final int typeId = 14;

  @override
  PeminjamanStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return PeminjamanStatus.draft;
      case 1:
        return PeminjamanStatus.pending;
      case 2:
        return PeminjamanStatus.approved;
      case 3:
        return PeminjamanStatus.rejected;
      case 4:
        return PeminjamanStatus.returned;
      case 5:
        return PeminjamanStatus.canceled;
      default:
        return PeminjamanStatus.draft;
    }
  }

  @override
  void write(BinaryWriter writer, PeminjamanStatus obj) {
    switch (obj) {
      case PeminjamanStatus.draft:
        writer.writeByte(0);
        break;
      case PeminjamanStatus.pending:
        writer.writeByte(1);
        break;
      case PeminjamanStatus.approved:
        writer.writeByte(2);
        break;
      case PeminjamanStatus.rejected:
        writer.writeByte(3);
        break;
      case PeminjamanStatus.returned:
        writer.writeByte(4);
        break;
      case PeminjamanStatus.canceled:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PeminjamanStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
