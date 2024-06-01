import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/core/base/routes.dart';
import 'package:fitness/core/constants/texts.dart';
import 'package:fitness/core/extensions/ui_exts.dart';
import 'package:fitness/models/user_model.dart';
import 'package:fitness/services/db.dart';
import 'package:fitness/services/hive_service.dart';
import 'package:fitness/services/user_service.dart';
import 'package:fitness/views/common/lang_selector_v.dart';
import 'package:fitness/views/profile/user_edit_v.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as io;

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
        onTap: func,
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
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.all(5),
                  width: 150,
                  height: 150,
                  child: ClipRRect(
                    borderRadius: 75.toRadiusAll(),
                    child: user.image != null
                        ? Image.network(
                            user.image!,
                            fit: BoxFit.cover,
                          )
                        : const Icon(Icons.person, size: 120),
                  ),
                ),
                IconButton.outlined(
                  onPressed: () async {
                    XFile? tempImage;
                    tempImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                    if (tempImage != null) {
                      await UserService.changeProfilePic(io.File(tempImage.path))
                          .then((value) => HiveService.userBox.put(0, value));
                    }
                  },
                  icon: const Icon(Icons.camera_alt),
                ),
              ],
            ),
            Text(
              user.fullname ?? '',
              style: const TextStyle(fontSize: 24),
            ),
            Text(
              user.phone,
              style:
                  const TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.w500),
            ),
            dataInfo(Texts.gender.tr(), user.gender.name.tr()),
            dataInfo(Texts.bmr.tr(), '${user.dailyCalorie?.toStringAsFixed(0)} kcal'),
            dataInfo(Texts.bmi.tr(), '${user.bmi?.toStringAsFixed(2)}'),
          ],
        );
      },
    );
  }

  Widget dataInfo(String label, String value) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Row(
        children: [
          Expanded(
            child: Text('$label: ',
                style: const TextStyle(
                    fontSize: 17, color: Colors.black, fontWeight: FontWeight.w600)),
          ),
          Text(value,
              style:
                  const TextStyle(fontSize: 17, color: Colors.brown, fontWeight: FontWeight.w600))
        ],
      ),
    );
  }
}
