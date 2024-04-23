import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/core/constants/texts.dart';
import 'package:fitness/core/extensions/ui_exts.dart';
import 'package:fitness/models/food_model.dart';
import 'package:fitness/services/food_service.dart';
import 'package:fitness/services/hive_service.dart';
import 'package:flutter/material.dart';

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
          SearchBar(
            controller: cont,
            trailing: [
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) => const AlertDialog(
                              title: Text('Help'),
                              content: Text(
                                  'A string containing food or drink items. If you wish to calculate a specific quantity, you may prefix a quantity before an item. For example, 3 tomatoes or 1lb beef brisket. If no quantity is specified, the default quantity is 100 grams. Queries cannot exceed 1500 characters.'),
                            ));
                  },
                  icon: Icon(Icons.help_outline))
            ],
            leading: const Icon(Icons.search),
            hintText: '140 grams rice, 3 tomatoes',
          ),
          const SizedBox(height: 10),
          OutlinedButton(
              onPressed: () {
                FoodService.foodReq(cont.text);
              },
              child: Text('Check Api')),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Your Daily Calorie Tracking',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                Text(
                    '357.2 / ${HiveService.userBox.getAt(0)!.dailyCalorie!.toStringAsFixed(0)} kcal'),
              ],
            ),
          ),
          foodTile(
            FoodModel.fromUser(
              '210 grams chicken breast',
              311.7,
              18.1,
              0.1,
              33.2,
            ),
          ),
          foodTile(
            FoodModel.fromUser(
              '2 tomatoes',
              45.5,
              0.5,
              9.7,
              2.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget foodTile(FoodModel food) {
    return Card(
      child: ListTile(
        trailing: Text(
          '${food.calorie} kcal',
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
        title: Text(food.name),
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
