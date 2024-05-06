import 'package:fitness/core/constants/hive_types.dart';
import 'package:hive_flutter/adapters.dart';

part 'gender_enum.g.dart';

@HiveType(typeId: HiveTypes.genderEnum)
enum Genders {
  @HiveField(0)
  none,
  @HiveField(1)
  male,
  @HiveField(2)
  female,
}
