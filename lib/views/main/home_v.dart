import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/core/constants/texts.dart';
import 'package:fitness/views/profile/profile_v.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: PersistentTabView(
        context,
        stateManagement: true,
        onWillPop: (p0) async => false,
        controller: PersistentTabController(),
        navBarStyle: NavBarStyle.style11,
        onItemSelected: (value) {},
        screens: [
          ProfileView(context),
          ProfileView(context),
          ProfileView(context),
          ProfileView(context),
          ProfileView(context),
        ],
        items: [
          navItem(Icons.person, Texts.profile),
          navItem(Icons.person, Texts.profile),
          navItem(Icons.person, Texts.profile),
          navItem(Icons.person, Texts.profile),
          navItem(Icons.person, Texts.profile),
        ],
      ),
    );
  }

  PersistentBottomNavBarItem navItem(IconData icon, String title) {
    return PersistentBottomNavBarItem(
      icon: Icon(icon),
      title: title.tr(),
      activeColorPrimary: Colors.grey.shade600,
      activeColorSecondary: Colors.black,
    );
  }
}
