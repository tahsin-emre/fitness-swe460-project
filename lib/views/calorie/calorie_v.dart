import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/core/constants/texts.dart';
import 'package:fitness/core/extensions/ui_exts.dart';
import 'package:fitness/models/food_model.dart';
import 'package:fitness/services/food_service.dart';
import 'package:fitness/services/hive_service.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class CalorieView extends StatelessWidget {
  final BuildContext pushContext;
  final TextEditingController cont = TextEditingController();
  CalorieView(this.pushContext, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: 10.toEdgeAll(),
      child: ListView(
        children: [
          Padding(
            padding: 10.toEdgeAll(),
            child: Text(
              Texts.calorie.tr(),
              style: const TextStyle(fontSize: 24),
            ),
          ),
          const Divider(),
          searchBar(context),
          const SizedBox(height: 10),
          OutlinedButton(
              onPressed: () {
                FoodService.foodReq(cont.text).then((value) => null);
              },
              child: Text(Texts.add.tr())),
          const SizedBox(height: 10),
          ValueListenableBuilder(
              valueListenable: HiveService.foodBox.listenable(),
              builder: (context, box, child) {
                double calc = 0;
                for (var a in box.values) {
                  calc += a.calorie;
                }
                return Column(
                  children: [
                    Text(
                      Texts.calorieTitle.tr(),
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    Text(
                        '${calc.toStringAsFixed(0)} / ${HiveService.userBox.getAt(0)!.dailyCalorie!.toStringAsFixed(0)} kcal'),
                    ...box.values.map((e) => foodTile(e)),
                  ],
                );
              }),
        ],
      ),
    );
  }

  Widget searchBar(BuildContext context) {
    return SearchBar(
      controller: cont,
      trailing: [
        IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        title: Text(Texts.help.tr()),
                        content: Text(Texts.calorieHelp.tr()),
                      ));
            },
            icon: const Icon(Icons.help_outline))
      ],
      leading: const Icon(Icons.search),
      hintText: Texts.calorieHint.tr(),
    );
  }

  Widget foodTile(FoodModel food) {
    TextStyle style = const TextStyle(fontSize: 13, fontWeight: FontWeight.w600);
    return Card(
      child: ListTile(
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${food.gram} grams', style: style),
            Text('${food.calorie} kcal', style: style),
          ],
        ),
        title: Text(
          food.name.toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          children: [
            expText('Fat: ${food.fat}'),
            expText('Carb: ${food.carb}'),
            expText('Protein: ${food.protein}'),
          ],
        ),
      ),
    );
  }

  Widget expText(String text) {
    return Expanded(child: Text(text));
  }
}
