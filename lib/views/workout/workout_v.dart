import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/core/constants/texts.dart';
import 'package:fitness/core/enums/equipment_enum.dart';
import 'package:fitness/core/enums/muscle_enum.dart';
import 'package:fitness/core/extensions/ui_exts.dart';
import 'package:fitness/models/exercise_model.dart';
import 'package:fitness/services/hive_service.dart';
import 'package:fitness/views/workout/exercise_detail_v.dart';
import 'package:fitness/views/workout/workout_filter_v.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class WorkoutView extends StatefulWidget {
  final BuildContext pushContext;
  const WorkoutView(this.pushContext, {super.key});

  @override
  State<WorkoutView> createState() => _WorkoutViewState();
}

class _WorkoutViewState extends State<WorkoutView> {
  String query = '';
  List<int> equipments = [];
  List<int> muscles = [];
  @override
  void initState() {
    for (var element in Equipments.values) {
      equipments.add(element.index);
    }
    for (var element in Muscles.values) {
      muscles.add(element.index);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: HiveService.exerciseBox.listenable(),
        builder: (context, box, child) {
          List<ExerciseModel> filterList = [];
          for (var element in box.values) {
            bool isQuery = element.name?.toLowerCase().contains(query.toLowerCase()) ?? false;
            bool isEquipment =
                element.equipmentList.any((e) => equipments.any((el) => el == e.index));
            bool isMuscle = element.muscleList.any((e) => muscles.any((el) => el == e.index));
            if (isEquipment && isMuscle && isQuery) {
              filterList.add(element);
            }
          }
          return Container(
            margin: 10.toEdgeAll(),
            child: ListView(
              children: [
                Padding(
                  padding: 10.toEdgeAll(),
                  child: Text(Texts.exercise.tr(), style: const TextStyle(fontSize: 24)),
                ),
                const Divider(),
                filterBox(),
                const SizedBox(height: 10),
                exerciseList(filterList),
              ],
            ),
          );
        });
  }

  // Widget sendToDB() {
  //   return ElevatedButton(
  //     onPressed: () {
  //       FirebaseFirestore.instance.collection('exercises').add({
  //         'name': 'Dumbbell Russian Twist',
  //         'videoUrl':
  //             'https://media.musclewiki.com/media/uploads/videos/branded/male-Dumbbells-dumbbell-russian-twist-front.mp4',
  //         'equipmentList': [4],
  //         'muscleList': [2],
  //       });
  //     },
  //     child: const Text('Add'),
  //   );
  // }

  Widget filterBox() {
    return Row(
      children: [
        Expanded(
          child: SearchBar(
            leading: const Icon(Icons.search),
            hintText: 'Dumbbell Curl, Push Up...',
            onChanged: (value) {
              query = value;
              setState(() {});
            },
          ),
        ),
        IconButton(
            onPressed: () async {
              List<List<int>> filters = await showModalBottomSheet(
                context: context,
                enableDrag: false,
                isDismissible: false,
                builder: (_) => WorkoutFilterView(equipments, muscles),
              );
              equipments = filters[0];
              muscles = filters[1];
              setState(() {});
            },
            icon: const Icon(Icons.filter_alt))
      ],
    );
  }

  Widget exerciseList(List<ExerciseModel> list) {
    return Column(
      children: [
        ...list.map((e) => exerciseTile(context, e)),
      ],
    );
  }

  Widget exerciseTile(BuildContext context, ExerciseModel model) {
    return Card(
      elevation: .2,
      child: ListTile(
        onTap: () {
          showDialog(context: context, builder: (_) => ExerciseDetailView(model));
        },
        title: Text(
          model.name ?? '',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                '${Texts.equipments.tr()}: ${model.equipmentList.map((e) => e.name).toString().replaceAll('(', '').replaceAll(')', '')}'),
            Text(
                '${Texts.muscles.tr()}: ${model.muscleList.map((e) => e.name).toString().replaceAll('(', '').replaceAll(')', '')}'),
          ],
        ),
      ),
    );
  }
}
