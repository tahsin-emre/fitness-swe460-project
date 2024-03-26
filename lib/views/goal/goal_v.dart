import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/core/constants/texts.dart';
import 'package:fitness/core/extensions/ui_exts.dart';
import 'package:flutter/material.dart';

class GoalView extends StatelessWidget {
  final BuildContext pushContext;
  const GoalView(this.pushContext, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: 10.toEdgeAll(),
      child: ListView(
        children: [
          Padding(
            padding: 10.toEdgeAll(),
            child: Text(Texts.goal.tr(), style: const TextStyle(fontSize: 24)),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
