import 'package:flutter/material.dart';
import 'package:algorand_dart/algorand_dart.dart';
import 'package:get/get.dart';
import 'package:clipboard/clipboard.dart';
import 'package:lablebwallet/app/routes/app_pages.dart';
import '../controllers/home_controller.dart';


class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init:HomeController() ,
      builder: (HomeController c)=>
 RefreshIndicator(
        onRefresh:  (){
          c.update();

          return Future.delayed(Duration(seconds: 1));},
        child: ListView(

          shrinkWrap: true,
          children: [

            FutureBuilder(
                future: controller.accountMe,
                builder: (BuildContext context, AsyncSnapshot<Account> snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  } else {
                    String? a=snapshot.data?.publicAddress.substring(0,16);
                    String? b=snapshot.data?.publicAddress.substring(43,58);
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          a! + "....." + b! ,
                          style: const TextStyle(fontSize: 14),
                        ),
                        IconButton(
                            onPressed: () {
                              FlutterClipboard.copy(
                                      snapshot.data?.publicAddress ?? " ")
                                  .then((value) =>
                                      Get.showSnackbar(const GetSnackBar(
                                        message: "copied",
                                        duration: Duration(milliseconds: 900),
                                        maxWidth: 200,
                                        snackPosition: SnackPosition.TOP,
                                        animationDuration:
                                            Duration(milliseconds: 400),
                                      )));
                            },
                            icon: const Icon(Icons.copy)),
                      ],
                    );
                  }
                }),

            FutureBuilder(
              future: c.avt(),
              builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
                String text = snapshot.hasData
                    ? snapshot.data.toString() + " Algo"
                    : "loading..";

                return Container(
                    margin: const EdgeInsets.all(12),
                    height: context.height / 5,
                    width: context.width,
                    color: context.theme.primaryColor,
                    child: Center(
                        child: Text(
                      text,
                      style: TextStyle(
                          color: context.theme.primaryColorLight,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    )));
              },
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Container(
                        margin: const EdgeInsets.all(12),
                        width: 200,
                        height: 70,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(const Color(
                              0xfffffcfc,
                            ))),
                            onPressed: () {
                              Get.toNamed(Routes.SENDER);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                Text(
                                  "send",
                                  style: TextStyle(color: Colors.black),
                                ),
                                Icon(
                                  Icons.arrow_upward_outlined,
                                  color: Colors.black,
                                )
                              ],
                            )))),
                Expanded(
                    child: Container(
                        margin: const EdgeInsets.all(12),
                        width: 200,
                        height: 70,
                        child: ElevatedButton(
                            onPressed: () {
                              Get.toNamed(Routes.RECEIVER);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                Text("receive"),
                                Icon(Icons.arrow_downward_outlined),
                              ],
                            )))),
              ],
            ),

            SizedBox(
                height: context.height/2.2,
                child: TabBarAndTabViews(
                  view: [
                    FutureBuilder(
                      future: controller.printAssetHolding,
                      builder: (BuildContext context,
                          AsyncSnapshot<List<AssetHolding>> snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          print(snapshot.data?.length);
                          return ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (BuildContext context, int index) =>
                                ListTileTheme(
                              child: ListTile(
                                leading: Text(snapshot.data?[index].assetId
                                        .toString() ??
                                    ""),
                                title: Text(
                                  snapshot.data?[index].amount.toString() ??
                                      "",
                                  textScaleFactor: 1,
                                ),
                                trailing: Icon(Icons.chevron_right),
                                selected: false,
                                onTap: () {
                                  controller.destroyAssets(
                                      index:
                                          snapshot.data?[index].assetId ?? 0);
                                },
                              ),
                         //     textColor: Color(0xFF4338CA),
                           //   iconColor: Color(0xFF4338CA),
                            ),
                          );
                        }
                      },
                    ),
                    Text("a2"),
                    FutureBuilder(
                      future: controller.searchAssetsByName,
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Asset>> snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (BuildContext context, int index) =>
                                ListTileTheme(
                              child: ListTile(
                                leading: Text(
                                    snapshot.data?[index].index.toString() ??
                                        ""),
                                title: Text(
                                  snapshot.data?[index].params.name ?? "",
                                  textScaleFactor: 1,
                                ),
                                trailing: Icon(Icons.chevron_right),
                                selected: false,
                                onTap: () {
                                  controller.addAssetsMe(
                                      index:
                                          snapshot.data?[index].index ?? 0);
                                },
                              ),
                     //         textColor: Color(0xFF4338CA),
                       //       iconColor: Color(0xFF4338CA),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ))

          ],
        ),
      ),
    );
  }
}

class TabBarAndTabViews extends StatefulWidget {
  const TabBarAndTabViews({Key? key, required this.view}) : super(key: key);
  final List<Widget> view;
  @override
  _TabBarAndTabViewsState createState() => _TabBarAndTabViewsState();
}

class _TabBarAndTabViewsState extends State<TabBarAndTabViews>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // give the tab bar a height [can change height to preferred height]
          Container(
            height: 45,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                25.0,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: TabBar(
                controller: _tabController,
                // give the indicator a decoration (color and border radius)
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                  color: context.theme.primaryColor,
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                tabs: const [
                  Text("Assets"),
                  Text("Activety"),
                  Text("Add token")
                ],
              ),
            ),
          ),
          Expanded(
            child:
                TabBarView(controller: _tabController, children: widget.view),
          ),
        ],
      ),
    );
  }
}
