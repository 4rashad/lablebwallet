import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../controllers/create_wallet_controller.dart';

class CreateWalletView extends GetView<CreateWalletController> {
   CreateWalletView({Key? key}) : super(key: key);
final textFieldController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FutureBuilder(
            future: controller.createAccountMe(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot){
              if(!snapshot.hasData){
                return CircularProgressIndicator();
              }
              else {
                textFieldController.text=snapshot.data!;
                return   Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            const Text("Create New Account")
            ,Container(
                margin: const EdgeInsets.all(12),
                width: context.width / 1.2,
                height: context.height / 5,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black26)),
                child:  TextField(
                  controller: textFieldController,
                  maxLines: 6,
                  minLines: 5,
                  readOnly: true,
                  style: const TextStyle(overflow: TextOverflow.clip),
                  decoration: const InputDecoration(border: InputBorder.none),
                )),
            ElevatedButton(onPressed: (){
              Get.offAndToNamed(Routes.DASHBOARD);
            }, child: const Text("Continue"))
        ],
      );
              }
            }


          )),
    );
  }
}
