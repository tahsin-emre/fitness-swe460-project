import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/core/base/routes.dart';
import 'package:fitness/core/constants/texts.dart';
import 'package:fitness/core/extensions/ui_exts.dart';
import 'package:fitness/models/user_model.dart';
import 'package:fitness/services/db.dart';
import 'package:fitness/services/hive_service.dart';
import 'package:flutter/material.dart';
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
            child: Text(Texts.profile.tr(), style: const TextStyle(fontSize: 24)),
          ),
          const Divider(),
          userInfo(),
          ListTile(
            leading: const Icon(Icons.power_settings_new),
            title: const Text('Log Out'),
            onTap: () {
              DB.auth.signOut();
              Navigator.pushNamedAndRemoveUntil(pushContext, Routes.auth, (route) => false);
              HiveService.userBox!.clear();
            },
          )
        ],
      ),
    );
  }

  Widget userInfo() {
    return ValueListenableBuilder(
      valueListenable: HiveService.userBox!.listenable(),
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
              user.fullname,
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              user.phone,
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ],
        );
      },
    );
  }
}
