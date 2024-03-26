import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/core/base/routes.dart';
import 'package:fitness/core/constants/texts.dart';
import 'package:fitness/services/auth_service.dart';
import 'package:fitness/services/hive_service.dart';
import 'package:flutter/material.dart';

class RegisterFormView extends StatelessWidget {
  final TextEditingController nameCont = TextEditingController();
  final TextEditingController surnameCont = TextEditingController();
  RegisterFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          textField(nameCont, Texts.name),
          textField(surnameCont, Texts.surname),
          registerButton(context),
        ],
      ),
    );
  }

  Widget textField(TextEditingController cont, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: TextField(
        controller: cont,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
        ),
      ),
    );
  }

  Widget registerButton(BuildContext _) {
    return Container(
      alignment: Alignment.centerRight,
      margin: const EdgeInsets.all(10),
      child: OutlinedButton(
          onPressed: () async {
            await AuthService.register(nameCont.text, surnameCont.text).then((userModel) {
              HiveService.userBox!.put(0, userModel);
              AuthService.otpStream.close();
              Navigator.pushNamedAndRemoveUntil(_, Routes.home, (route) => false);
            });
          },
          child: Text(Texts.register.tr())),
    );
  }
}
