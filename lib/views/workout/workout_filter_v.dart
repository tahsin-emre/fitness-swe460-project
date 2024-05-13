import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/core/constants/texts.dart';
import 'package:fitness/core/enums/equipment_enum.dart';
import 'package:fitness/core/enums/muscle_enum.dart';
import 'package:flutter/material.dart';

class WorkoutFilterView extends StatefulWidget {
  final List<int> equipments;
  final List<int> muscles;
  const WorkoutFilterView(this.equipments, this.muscles, {super.key});

  @override
  State<WorkoutFilterView> createState() => _WorkoutFilterViewState();
}

class _WorkoutFilterViewState extends State<WorkoutFilterView> {
  List<int> equipments = [];
  List<int> muscles = [];
  @override
  void initState() {
    equipments = widget.equipments;
    muscles = widget.muscles;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BottomSheet(
          onClosing: () {},
          enableDrag: false,
          builder: (context) {
            return Column(
              children: [
                Text(
                  Texts.equipments.tr(),
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                equipmentsPart(),
                const SizedBox(height: 5),
                Text(
                  Texts.muscles.tr(),
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                musclesPart(),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(elevation: 6),
                        onPressed: () {
                          List<int> eqs = [];
                          List<int> mus = [];
                          for (var element in Equipments.values) {
                            eqs.add(element.index);
                          }
                          for (var element in Muscles.values) {
                            mus.add(element.index);
                          }
                          Navigator.pop(context, [eqs, mus]);
                        },
                        child: Text(Texts.reset.tr()),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(elevation: 6),
                        onPressed: () {
                          Navigator.pop(context, [equipments, muscles]);
                        },
                        child: Text(Texts.apply.tr()),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
    );
  }

  Widget equipmentsPart() {
    return Wrap(
      runSpacing: -5,
      alignment: WrapAlignment.center,
      spacing: 5,
      children: [
        ...Equipments.values.sublist(1).map((e) => eChip(e)),
      ],
    );
  }

  Widget musclesPart() {
    return Wrap(
      alignment: WrapAlignment.center,
      runSpacing: -5,
      spacing: 5,
      children: [
        ...Muscles.values.sublist(1).map((e) => mChip(e)),
      ],
    );
  }

  Widget eChip(Equipments e) {
    bool isThere = equipments.any((element) => element == e.index);
    return InkWell(
      onTap: () => setState(() {
        if (isThere) {
          equipments.remove(e.index);
        } else {
          equipments.add(e.index);
        }
      }),
      child: Chip(
        color: MaterialStatePropertyAll(isThere ? Colors.greenAccent : null),
        padding: const EdgeInsets.all(3),
        label: Text(e.name.tr()),
      ),
    );
  }

  Widget mChip(Muscles m) {
    bool isThere = muscles.any((element) => element == m.index);
    return InkWell(
      onTap: () => setState(() {
        if (isThere) {
          muscles.remove(m.index);
        } else {
          muscles.add(m.index);
        }
      }),
      child: Chip(
        color: MaterialStatePropertyAll(isThere ? Colors.greenAccent : null),
        padding: const EdgeInsets.all(3),
        label: Text(m.name.tr()),
      ),
    );
  }
}
