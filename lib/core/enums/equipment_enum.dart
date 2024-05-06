import 'package:fitness/core/constants/hive_types.dart';
import 'package:hive_flutter/adapters.dart';
part 'equipment_enum.g.dart';

@HiveType(typeId: HiveTypes.equipmentEnum)
enum Equipments {
  @HiveField(0)
  none,
  @HiveField(1)
  bodyweight,
  @HiveField(2)
  band,
  @HiveField(3)
  barbell,
  @HiveField(4)
  dumbbell,
  @HiveField(5)
  kettlebell,
  @HiveField(6)
  plate,
  @HiveField(7)
  machine,
  @HiveField(8)
  smitemachine,
  @HiveField(9)
  cables,
}
