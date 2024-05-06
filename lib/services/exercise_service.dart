import 'package:fitness/models/exercise_model.dart';
import 'package:fitness/services/db.dart';
import 'package:fitness/services/hive_service.dart';

class ExerciseService {
  static Future getExercises() async {
    var data = await DB.db.collection('exercises').get();
    for (var element in data.docs) {
      ExerciseModel model = ExerciseModel.fromQDS(element);
      HiveService.exerciseBox.put(model.id, model);
    }
  }
}
