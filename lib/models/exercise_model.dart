import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness/core/enums/equipment_enum.dart';
import 'package:fitness/core/enums/muscle_enum.dart';

class ExerciseModel {
  late String id;
  late String name;
  late String? videoUrl;
  late List<Muscles> muscleList = [];
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
