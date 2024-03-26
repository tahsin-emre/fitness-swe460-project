import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/core/constants/texts.dart';
import 'package:fitness/core/extensions/ui_exts.dart';
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
          ValueListenableBuilder(
              valueListenable: HiveService.userBox!.listenable(),
              builder: (_, box, child) {
                return Container();
              }),
        ],
      ),
    );
  }
}
