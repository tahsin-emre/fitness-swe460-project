// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gender_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GendersAdapter extends TypeAdapter<Genders> {
  @override
  final int typeId = 99;

  @override
  Genders read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Genders.none;
      case 1:
        return Genders.male;
      case 2:
        return Genders.female;
      default:
        return Genders.none;
    }
  }

  @override
  void write(BinaryWriter writer, Genders obj) {
    switch (obj) {
      case Genders.none:
        writer.writeByte(0);
        break;
      case Genders.male:
        writer.writeByte(1);
        break;
      case Genders.female:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GendersAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
