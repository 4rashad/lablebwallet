import 'dart:typed_data';
import 'package:algorand_dart/algorand_dart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:barcode_image/barcode_image.dart';
import 'package:image/image.dart' as images;
import '../controllers/receiver_controller.dart';
import 'package:clipboard/clipboard.dart';

class ReceiverView extends GetView<ReceiverController> {
  const ReceiverView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final image = images.Image(600, 350);
    images.fill(image, images.getColor(255, 255, 255));
    // Draw the barcode

    return Scaffold(
      appBar: AppBar(
        title: const Text('Receiver View'),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: controller.accountMe(),
          builder: (BuildContext context, AsyncSnapshot<Account> snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            } else {
              drawBarcode(
                  image, Barcode.qrCode(), snapshot.data?.publicAddress ?? "",
                  font: images.arial_24);
              var kk = images.encodePng(image);
              Uint8List c = Uint8List.fromList(kk);

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(),
                  Image.memory(c),
                  Spacer(),
                  Text(snapshot.data?.publicAddress ?? ""),
                  IconButton(
                      onPressed: () {
                        FlutterClipboard.copy(
                                snapshot.data?.publicAddress ?? " ")
                            .then((value) => Get.showSnackbar(const GetSnackBar(
                                  message: "copied",
                                  duration: Duration(milliseconds: 900),
                                  maxWidth: 200,
                                  snackPosition: SnackPosition.TOP,
                                  animationDuration:
                                      Duration(milliseconds: 400),
                                )));
                      },
                      icon: const Icon(Icons.copy)),
                  Spacer(),
                ],
              );
            }
          }),
    );
  }
}
