import 'package:fitness/core/constants/hive_types.dart';
import 'package:hive_flutter/adapters.dart';
part 'muscle_enum.g.dart';

@HiveType(typeId: HiveTypes.muscleEnum)
enum Muscles {
  @HiveField(0)
  none,
  @HiveField(1)
  chest,
  @HiveField(2)
  abdominals,
  @HiveField(3)
  obliques,
  @HiveField(4)
  traps,
  @HiveField(5)
  trapsmiddle,
  @HiveField(6)
  lats,
  @HiveField(7)
  lowerback,
  @HiveField(8)
  glutes,
  @HiveField(9)
  shoulders,
  @HiveField(10)
  biceps,
  @HiveField(11)
  triceps,
  @HiveField(12)
  forearms,
  @HiveField(13)
  quads,
  @HiveField(14)
  calves,
  @HiveField(15)
  hamstrings,
}
