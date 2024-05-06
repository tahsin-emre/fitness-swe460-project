// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equipment_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EquipmentsAdapter extends TypeAdapter<Equipments> {
  @override
  final int typeId = 97;

  @override
  Equipments read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Equipments.none;
      case 1:
        return Equipments.bodyweight;
      case 2:
        return Equipments.band;
      case 3:
        return Equipments.barbell;
      case 4:
        return Equipments.dumbbell;
      case 5:
        return Equipments.kettlebell;
      case 6:
        return Equipments.plate;
      case 7:
        return Equipments.machine;
      case 8:
        return Equipments.smitemachine;
      case 9:
        return Equipments.cables;
      default:
        return Equipments.none;
    }
  }

  @override
  void write(BinaryWriter writer, Equipments obj) {
    switch (obj) {
      case Equipments.none:
        writer.writeByte(0);
        break;
      case Equipments.bodyweight:
        writer.writeByte(1);
        break;
      case Equipments.band:
        writer.writeByte(2);
        break;
      case Equipments.barbell:
        writer.writeByte(3);
        break;
      case Equipments.dumbbell:
        writer.writeByte(4);
        break;
      case Equipments.kettlebell:
        writer.writeByte(5);
        break;
      case Equipments.plate:
        writer.writeByte(6);
        break;
      case Equipments.machine:
        writer.writeByte(7);
        break;
      case Equipments.smitemachine:
        writer.writeByte(8);
        break;
      case Equipments.cables:
        writer.writeByte(9);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EquipmentsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
