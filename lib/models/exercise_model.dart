import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness/core/constants/hive_types.dart';
import 'package:fitness/core/enums/equipment_enum.dart';
import 'package:fitness/core/enums/muscle_enum.dart';
import 'package:hive_flutter/adapters.dart';

part 'exercise_model.g.dart';

@HiveType(typeId: HiveTypes.exerciseModel)
class ExerciseModel {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? videoUrl;
  @HiveField(3)
  late List<Muscles> muscleList = [];
  @HiveField(4)
  late List<Equipments> equipmentList = [];

  ExerciseModel();

  ExerciseModel.fromQDS(QueryDocumentSnapshot snapshot) {
    var data = snapshot.data() as dynamic;
    id = snapshot.id;
    name = data['name'] ?? '';
    videoUrl = data['videoUrl'];
    List ml = data['muscleList'] ?? [];
    List el = data['equipmentList'] ?? [];
    for (var m in ml) {
      muscleList.add(Muscles.values[m]);
    }
    for (var e in el) {
      equipmentList.add(Equipments.values[e]);
    }
  }
}
