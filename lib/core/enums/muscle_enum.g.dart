// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'muscle_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MusclesAdapter extends TypeAdapter<Muscles> {
  @override
  final int typeId = 98;

  @override
  Muscles read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Muscles.none;
      case 1:
        return Muscles.chest;
      case 2:
        return Muscles.abdominals;
      case 3:
        return Muscles.obliques;
      case 4:
        return Muscles.traps;
      case 5:
        return Muscles.trapsmiddle;
      case 6:
        return Muscles.lats;
      case 7:
        return Muscles.lowerback;
      case 8:
        return Muscles.glutes;
      case 9:
        return Muscles.shoulders;
      case 10:
        return Muscles.biceps;
      case 11:
        return Muscles.triceps;
      case 12:
        return Muscles.forearms;
      case 13:
        return Muscles.quads;
      case 14:
        return Muscles.calves;
      case 15:
        return Muscles.hamstrings;
      default:
        return Muscles.none;
    }
  }

  @override
  void write(BinaryWriter writer, Muscles obj) {
    switch (obj) {
      case Muscles.none:
        writer.writeByte(0);
        break;
      case Muscles.chest:
        writer.writeByte(1);
        break;
      case Muscles.abdominals:
        writer.writeByte(2);
        break;
      case Muscles.obliques:
        writer.writeByte(3);
        break;
      case Muscles.traps:
        writer.writeByte(4);
        break;
      case Muscles.trapsmiddle:
        writer.writeByte(5);
        break;
      case Muscles.lats:
        writer.writeByte(6);
        break;
      case Muscles.lowerback:
        writer.writeByte(7);
        break;
      case Muscles.glutes:
        writer.writeByte(8);
        break;
      case Muscles.shoulders:
        writer.writeByte(9);
        break;
      case Muscles.biceps:
        writer.writeByte(10);
        break;
      case Muscles.triceps:
        writer.writeByte(11);
        break;
      case Muscles.forearms:
        writer.writeByte(12);
        break;
      case Muscles.quads:
        writer.writeByte(13);
        break;
      case Muscles.calves:
        writer.writeByte(14);
        break;
      case Muscles.hamstrings:
        writer.writeByte(15);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MusclesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
