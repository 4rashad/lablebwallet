import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/import_wallet_controller.dart';

class ImportWalletView extends GetView<ImportWalletController> {
   ImportWalletView({Key? key}) : super(key: key);
final TextEditingController _phaseRecoveryController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(

        child: SizedBox(
          height: context.height,
          child: Column(

            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Spacer(),
              const Text("Import Wallet Enter Your Recovery Phrase"),

              Container(
                  margin: const EdgeInsets.all(12),
                  width: context.width / 1.2,
                  height:context.height/5 ,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black26)),
                  child:  TextField(
                    controller: _phaseRecoveryController,
                    maxLines: 6,
                    minLines: 5,
                    style: const TextStyle(overflow: TextOverflow.clip),
                    decoration: const InputDecoration(border: InputBorder.none),
                  )),
              ElevatedButton(onPressed: (){
                controller.phaseLogin=_phaseRecoveryController.value.text;
                controller.loginMe();
              }, child: const Text("Continue")),
              ElevatedButton(onPressed: (){_phaseRecoveryController.text="pink detect then artefact piano laptop muscle thumb penalty taxi shuffle mixed sister family fun ignore wedding outside glide hurry culture robust cry absorb earth";}, child: Text("hhh")),
              const Spacer(),
              Container(
                margin: const EdgeInsets.all(20),
                child: const Text("What is a recovery phrase? \n It is a 12- or 24-word\n phrase that can be used to restore your wallet.\n"
                    "Is it safe to enter it into Glow?\n"
                    "Yes. It will be stored locally and never leave your device without your explicit permission."),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
