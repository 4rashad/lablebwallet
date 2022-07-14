import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:feather_icons/feather_icons.dart';
import '../../assets/views/assets_view.dart';
import '../../home/views/home_view.dart';
import '../../settings/views/settings_view.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<DashboardController>(
        init: DashboardController(),
        builder: (controller) => Scaffold(
          bottomNavigationBar: BottomNavigationBarMe(
            index: controller.tabPageChange,
            onTap: (index) {
              controller.tabPageChange = index;
              controller.update();
            },
          ),
          body: Center(
            child: IndexedStack(
              index: controller.tabPageChange,
              children: const [
                 HomeView(),
                 SettingsView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomNavigationBarMe extends StatelessWidget {
  const BottomNavigationBarMe({
    Key? key,
    required this.index,
    this.onTap,
  }) : super(key: key);
  final int index;
  final Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(

      onTap: onTap,

      currentIndex: index,
      items:  [
        BottomNavigationBarItem(icon: Icon( FeatherIconsMap["home"]), label: "home"),
        BottomNavigationBarItem(icon: Icon(FeatherIconsMap["settings"]), label: "Settings"),
      ],
    );
  }
}
