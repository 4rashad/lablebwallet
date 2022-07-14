import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lablebwallet/app/routes/app_pages.dart';
import '../controllers/accounts_controller.dart';
class AccountsView extends GetView<AccountsController> {
  const AccountsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            CardMe(title:  'Create new Wallet', onTop: () {
              Get.offAndToNamed(Routes.CREATE_WALLET);
            }, color: Colors.greenAccent,),
            CardMe(title:  'Import Wallet', onTop: () {
              Get.offAndToNamed(Routes.IMPORT_WALLET);

            }, color: Colors.white,textColor: context.textTheme.displayMedium?.color,),


          ],
        ),
      ),
    );
  }
}

class CardMe extends StatelessWidget {
  const CardMe({
    Key? key, required this.title, required this.onTop, required this.color,  this.textColor,
  }) : super(key: key);
final String title;
final Function() onTop;
final Color color;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTop,
      child: Container(
        margin: const EdgeInsets.all(10),
        width: context.width / 2,
        height: context.height / 4,
        decoration: BoxDecoration(
             color: color,
            border: Border.all(color: Colors.black12),
            boxShadow:  const [BoxShadow(
                offset: Offset(2, 3),
                color: Colors.black26,
                spreadRadius: 0.1,
                blurRadius: 9

            )]),
        child:  Center(
          child: Text(
           title,
            style:  TextStyle(fontSize: 20,color: textColor),
          ),
        ),
      ),
    );
  }
}
