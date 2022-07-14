import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

import '../controllers/sender_controller.dart';

class SenderView extends GetView<SenderController> {
  final addressCon = TextEditingController();
  final amountCon = TextEditingController();

   SenderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SenderView'),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(23),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text("Network: Algorand testnet"),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: addressCon,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'address',
              ),
              onChanged: (value){
               value.length==58?controller.buttonEnable.value=true: controller.buttonEnable.value=false;

              },
            ),
            NumberInputWithIncrementDecrement(
              controller: amountCon,
            ),
            Obx(()=>
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(controller.buttonEnable.value?null:Colors.black12)
              ),
                onPressed:controller.buttonEnable.value? () async {
                  //  controller.sender(address: textCon.text);
                  controller.txId.value = await controller.sender(
                      address: addressCon.value.text,
                      amount: double.parse(amountCon.value.text));
                  addressCon.text="";
                  controller.buttonEnable.value=false;
                }:null,
                child: const Text("send")),
    ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () async {
                  try {
                    final a = controller.txId.value;
                    Uri _url =
                        Uri.parse('https://testnet.algoexplorer.io/tx/' + a);

                    if (!await launchUrl(_url)) throw 'Could not launch $_url';
                  } catch (e) {
                    Get.showSnackbar(GetSnackBar(message: e.toString(),));
                  }
                },
                child: Obx(() => Text(controller.txId.value))),
          ],
        ),
      ),
    );
  }
}

class NumberInputWithIncrementDecrement extends StatefulWidget {
  const NumberInputWithIncrementDecrement({Key? key, required this.controller})
      : super(key: key);
  final TextEditingController controller;
  @override
  _NumberInputWithIncrementDecrementState createState() =>
      _NumberInputWithIncrementDecrementState();
}

class _NumberInputWithIncrementDecrementState
    extends State<NumberInputWithIncrementDecrement> {
  @override
  void initState() {
    super.initState();
    widget.controller.text = "0"; // Setting the initial value for the field.
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Container(
          width: 150.0,
          foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(
              color: Colors.blueGrey,
              width: 2.0,
            ),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter address';
                    } else if (value.length == 58) {
                      return null;
                    } else {
                      return "Please enter correct address";
                    }
                  },
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(8.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  controller: widget.controller,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: false,
                    signed: true,
                  ),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.deny(',',
                        replacementString: '.'),
                    FilteringTextInputFormatter.allow(
                        RegExp(r'(^\d*\.?\d{0,2})'))
                  ],
                ),
              ),
              SizedBox(
                height: 38.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: InkWell(
                        child: const Icon(
                          Icons.arrow_drop_up,
                          size: 18.0,
                        ),
                        onTap: () {
                          int currentValue = int.parse(widget.controller.text);
                          setState(() {
                            currentValue++;
                            widget.controller.text =
                                (currentValue).toString(); // incrementing value
                          });
                        },
                      ),
                    ),
                    InkWell(
                      child: const Icon(
                        Icons.arrow_drop_down,
                        size: 18.0,
                      ),
                      onTap: () {
                        int currentValue = int.parse(widget.controller.text);
                        setState(() {
                          currentValue--;
                          widget.controller.text =
                              (currentValue > 0 ? currentValue : 0)
                                  .toString(); // decrementing value
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
