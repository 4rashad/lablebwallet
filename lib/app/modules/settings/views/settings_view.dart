import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../routes/app_pages.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
     child: Column(
       children: [
         const Text(
           'SettingsView is working',
           style: TextStyle(fontSize: 20),),

         ElevatedButton(onPressed: (){
           accountStorage.erase();
           Get.offAndToNamed(Routes.ACCOUNTS);
         }, child: const Text("logout")),


         GetBuilder<SettingsController>(
           init:SettingsController() ,
           builder: (controller)=>
               SwitchListTile(

                 isThreeLine: true,
                 value: controller.isDark,
                 dense: false,
                 title: const Text('Dark mode'),
                 subtitle: const Text("switch you them mode"),
                 onChanged: controller.changeMode,
               ),
         ),


       ],
     ),
          );



  }
}
