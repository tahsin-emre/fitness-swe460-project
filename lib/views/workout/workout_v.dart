import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/core/constants/texts.dart';
import 'package:fitness/core/extensions/ui_exts.dart';
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
        ],
      ),
    );
  }
}
