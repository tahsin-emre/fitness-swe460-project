import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/core/constants/texts.dart';
import 'package:fitness/core/extensions/ui_exts.dart';
import 'package:fitness/models/exercise_model.dart';
import 'package:fitness/services/hive_service.dart';
import 'package:fitness/views/workout/exercise_detail_v.dart';
import 'package:flutter/material.dart';

class WorkoutView extends StatelessWidget {
  final BuildContext pushContext;
  const WorkoutView(this.pushContext, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: 10.toEdgeAll(),
      child: ListView(
        children: [
          Padding(
            padding: 10.toEdgeAll(),
            child: Text(Texts.workout.tr(), style: const TextStyle(fontSize: 24)),
          ),
          const Divider(),
          const SearchBar(),
          const SizedBox(height: 10),
          exerciseList(context),
        ],
      ),
    );
  }

  Widget exerciseList(BuildContext context) {
    return Column(
      children: [
        ...HiveService.exerciseBox.values.map((e) => exerciseTile(context, e)),
      ],
    );
  }

  Widget exerciseTile(BuildContext context, ExerciseModel model) {
    return ListTile(
      onTap: () {
        showDialog(context: context, builder: (_) => ExerciseDetailView(model));
      },
      title: Text(model.name ?? ''),
      subtitle: Text('Equipments: ${model.equipmentList}'),
    );
  }
}
