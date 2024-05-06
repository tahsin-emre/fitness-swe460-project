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
              child: const Text('Add')),
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
                    const Text(
                      'Your Daily Calorie Tracking',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
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
                  builder: (_) => const AlertDialog(
                        title: Text('Help'),
                        content: Text(
                            'A string containing food or drink items. If you wish to calculate a specific quantity, you may prefix a quantity before an item. For example, 3 tomatoes or 1lb beef brisket. If no quantity is specified, the default quantity is 100 grams. Queries cannot exceed 1500 characters.'),
                      ));
            },
            icon: const Icon(Icons.help_outline))
      ],
      leading: const Icon(Icons.search),
      hintText: '140 grams rice, 3 tomatoes',
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
