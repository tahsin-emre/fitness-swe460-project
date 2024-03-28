import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/core/base/routes.dart';
import 'package:fitness/core/constants/texts.dart';
import 'package:fitness/models/user_model.dart';
import 'package:fitness/services/auth_service.dart';
import 'package:fitness/services/hive_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterFormView extends StatefulWidget {
  final String phone;
  const RegisterFormView(this.phone, {super.key});

  @override
  State<RegisterFormView> createState() => _RegisterFormViewState();
}

class _RegisterFormViewState extends State<RegisterFormView> {
  UserModel tempUser = UserModel();
  @override
  void initState() {
    tempUser.phone = widget.phone;
    tempUser.id = '';
    super.initState();
  }

  DateTime? dateOfBirth;
  String? genderValue;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        textField(Texts.name),
        textField(Texts.surname),
        Row(
          children: [
            Expanded(child: textField(Texts.weight, 'KG', true)),
            Expanded(child: textField(Texts.height, 'CM', true)),
          ],
        ),
        Row(
          children: [
            Expanded(child: birthDate(context)),
            Expanded(child: genderSelector()),
          ],
        ),
        registerButton(context),
      ],
    );
  }

  Widget textField(String label, [String? suffix, bool numeric = false]) {
    TextEditingController controller = TextEditingController()..text = getValue(label) ?? '';
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: TextField(
        controller: controller,
        keyboardType: numeric ? TextInputType.number : TextInputType.none,
        onChanged: (value) {
          updateUser(value, label);
          controller.selection =
              TextSelection.fromPosition(TextPosition(offset: controller.text.length));
        },
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
          suffixText: suffix,
        ),
      ),
    );
  }

  Widget genderSelector() {
    return Container(
      margin: const EdgeInsets.all(10),
      child: DropdownButton<String?>(
        value: genderValue,
        isExpanded: true,
        hint: const Text(Texts.gender),
        items: const [
          DropdownMenuItem(
            value: Texts.male,
            child: Text(Texts.male),
          ),
          DropdownMenuItem(
            value: Texts.female,
            child: Text(Texts.female),
          ),
        ],
        onChanged: (value) {
          setState(() => genderValue = value);
          updateUser(value, Texts.gender);
        },
      ),
    );
  }

  Widget birthDate(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (_) => SizedBox(
              height: 400,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: OutlinedButton(
                        onPressed: () => Navigator.pop(_), child: const Text(Texts.ok)),
                  ),
                  Expanded(
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      minimumYear: 1900,
                      initialDateTime: dateOfBirth,
                      onDateTimeChanged: (date) => updateUser(date, Texts.birthDate),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        child: Card(
          child: ListTile(
            title: Text(
              dateOfBirth == null ? Texts.birthDate : dateOfBirth.toString().substring(0, 10),
            ),
            subtitle: const Text(Texts.taptochange),
          ),
        ),
      ),
    );
  }

  void updateUser(dynamic value, String label) {
    switch (label) {
      case Texts.name:
        tempUser.name = value;
        break;
      case Texts.surname:
        tempUser.surname = value;
        break;
      case Texts.weight:
        tempUser.weight = int.tryParse(value) ?? 0;
        break;
      case Texts.height:
        tempUser.height = int.tryParse(value) ?? 0;
        break;
      case Texts.birthDate:
        log('date $value');
        setState(() => dateOfBirth = value);
        tempUser.birthDate = value;
        break;
      case Texts.gender:
        tempUser.gender = value;
        break;
      default:
    }
  }

  String? getValue(String label) {
    switch (label) {
      case Texts.name:
        return tempUser.name;
      case Texts.surname:
        return tempUser.surname;
      case Texts.weight:
        return tempUser.weight?.toString() ?? '';
      case Texts.height:
        return tempUser.height?.toString() ?? '';
      default:
        return null;
    }
  }

  Widget registerButton(BuildContext _) {
    return Container(
      alignment: Alignment.centerRight,
      margin: const EdgeInsets.all(10),
      child: OutlinedButton(
          onPressed: () async {
            await AuthService.register(tempUser).then((userModel) {
              HiveService.userBox.put(0, userModel);
              AuthService.otpStream.close();
              Navigator.pushNamedAndRemoveUntil(_, Routes.home, (route) => false);
            });
          },
          child: Text(Texts.register.tr())),
    );
  }
}
