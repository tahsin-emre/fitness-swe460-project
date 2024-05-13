import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/core/base/routes.dart';
import 'package:fitness/core/constants/texts.dart';
import 'package:fitness/core/extensions/ui_exts.dart';
import 'package:fitness/models/user_model.dart';
import 'package:fitness/services/db.dart';
import 'package:fitness/services/hive_service.dart';
import 'package:fitness/views/common/lang_selector_v.dart';
import 'package:fitness/views/profile/user_edit_v.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/adapters.dart';

class ProfileView extends StatelessWidget {
  final BuildContext pushContext;
  const ProfileView(this.pushContext, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: 10.toEdgeAll(),
      child: ListView(
        children: [
          Padding(
            padding: 10.toEdgeAll(),
            child: Row(
              children: [
                Expanded(child: Text(Texts.profile.tr(), style: const TextStyle(fontSize: 24))),
                const LanguageSelectorView(),
              ],
            ),
          ),
          const Divider(),
          userInfo(),
          myCard(
            Icons.edit,
            Texts.edit,
            () {
              showDialog(context: context, builder: (_) => UserEditView());
            },
          ),
          myCard(
            Icons.power_settings_new,
            Texts.logout,
            () {
              DB.auth.signOut();
              Navigator.pushNamedAndRemoveUntil(pushContext, Routes.auth, (route) => false);
              HiveService.userBox.clear();
            },
          )
        ],
      ),
    );
  }

  Widget myCard(IconData icon, String title, void Function() func) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title.tr()),
        onTap: () => func(),
      ),
    );
  }

  Widget userInfo() {
    return ValueListenableBuilder(
      valueListenable: HiveService.userBox.listenable(),
      builder: (_, box, child) {
        UserModel user = box.get(0)!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(5),
              width: 150,
              height: 150,
              child: ClipRRect(
                borderRadius: 75.toRadiusAll(),
                child: user.image != null
                    ? Image.network(user.image!)
                    : const Icon(Icons.person, size: 100),
              ),
            ),
            Text(
              user.fullname ?? '',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              user.phone,
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
            Text(
              'Gender: ${user.gender.name.tr()} kcal',
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
            Text(
              'BMR: ${user.dailyCalorie?.toStringAsFixed(0)} kcal',
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
            Text(
              'BMI: ${user.bmi?.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ],
        );
      },
    );
  }
}
