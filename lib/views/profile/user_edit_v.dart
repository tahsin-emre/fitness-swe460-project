import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/core/constants/texts.dart';
import 'package:fitness/core/extensions/ui_exts.dart';
import 'package:fitness/services/hive_service.dart';
import 'package:fitness/services/user_service.dart';
import 'package:flutter/material.dart';

class UserEditView extends StatelessWidget {
  UserEditView({super.key});
  final TextEditingController kgCont =
      TextEditingController(text: HiveService.userBox.getAt(0)?.weight?.toString());
  final TextEditingController cmCont =
      TextEditingController(text: HiveService.userBox.getAt(0)?.height?.toString());
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(Texts.edit.tr()),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          myTextField(kgCont, Texts.weight),
          myTextField(cmCont, Texts.height),
        ],
      ),
      actions: [
        OutlinedButton(
          onPressed: () async {
            UserService.updateUser(num.parse(kgCont.text), num.parse(cmCont.text))
                .then((userModel) {
              HiveService.userBox.put(0, userModel);
              Navigator.pop(context);
            });
          },
          child: Text(Texts.update.tr()),
        ),
      ],
    );
  }

  Widget myTextField(TextEditingController cont, String label) {
    return Container(
      margin: 5.toEdgeAll(),
      child: TextField(
        controller: cont,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(border: const OutlineInputBorder(), labelText: label),
      ),
    );
  }
}
