// ignore_for_file: depend_on_referenced_packages, unused_local_variable, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:oguz_taxi_driver/screen/complate_page.dart';
import 'package:provider/provider.dart';
import '../const/color_const.dart';
import '../provider/index_provider.dart';
import '../widgets/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      alertDialog();
    });
    super.initState();
  }

  void alertDialog() {
    showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: AlertDialog(
              content: Container(
                height: 320,
                alignment: Alignment.bottomCenter,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16))),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Divider(
                      thickness: 0.8,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Provider.of<IndexProvider>(context, listen: false)
                            .addTarif(1);
                      },
                      child: Container(
                          height: 45,
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: const Color(0xffE5E7FF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Image.asset(
                                      'assets/icons/clock.png',
                                    ),
                                  ),
                                  const Text(
                                    'Sagatlayyn',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                              Provider.of<IndexProvider>(context)
                                      .workingTarifs
                                      .contains(1)
                                  ? const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: Icon(
                                        Icons.check_circle_outline_outlined,
                                        color: Colors.green,
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          )),
                    ),
                    InkWell(
                      onTap: () {
                        Provider.of<IndexProvider>(context, listen: false)
                            .addTarif(2);
                      },
                      child: Container(
                          height: 45,
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: const Color(0xffE5E7FF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Image.asset(
                                      'assets/icons/car1.png',
                                    ),
                                  ),
                                  const Text(
                                    'Adaty',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                              Provider.of<IndexProvider>(context)
                                      .workingTarifs
                                      .contains(2)
                                  ? const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: Icon(
                                        Icons.check_circle_outline_outlined,
                                        color: Colors.green,
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          )),
                    ),
                    InkWell(
                      onTap: () {
                        Provider.of<IndexProvider>(context, listen: false)
                            .addTarif(3);
                      },
                      child: Container(
                          height: 45,
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: const Color(0xffE5E7FF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Image.asset(
                                      'assets/icons/driving.png',
                                    ),
                                  ),
                                  const Text(
                                    'Yol ugruna',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                              Provider.of<IndexProvider>(context)
                                      .workingTarifs
                                      .contains(3)
                                  ? const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: Icon(
                                        Icons.check_circle_outline_outlined,
                                        color: Colors.green,
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          )),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        if (Provider.of<IndexProvider>(context, listen: false)
                            .workingTarifs
                            .isNotEmpty) {
                          Navigator.of(context).pop();
                        }
                      },
                      child: Container(
                        width: 300,
                        height: 45,
                        margin: const EdgeInsets.only(bottom: 20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          'Tassyklamak',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  bool sagat = false;
  bool adaty = false;
  bool yol = false;
  bool call = false;
  bool go = false;

  // int selectBottomSheetIndex = -1;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    MapController mapController = MapController();

    double sizeWidth = MediaQuery.of(context).size.width / 100;
    double sizeHeight = MediaQuery.of(context).size.height / 100;
    return WillPopScope(
      onWillPop: () async {
        print(
            "yes${Provider.of<IndexProvider>(context, listen: false).selectIndex}");
        if (Provider.of<IndexProvider>(context, listen: false).selectIndex !=
            -1) {
          Provider.of<IndexProvider>(context, listen: false).backBottomSheet();
          return false;
        } else {
          bool shouldPop = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Duýduruş'),
                content:
                    const Text('Siz hakykatdanam programmadan çykjakmysyňyz?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: const Text('Hawa'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text('Ýok'),
                  ),
                ],
              );
            },
          );

          return shouldPop;
        }
      },
      child: Scaffold(
        drawer: const Drawer1(),
        body: Stack(
          children: [
            FlutterMap(
              options: MapOptions(
                center: LatLng(37.961449, 58.327929),
                zoom: 15.0,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: const ['a', 'c'],
                ),
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: [],
                      strokeWidth: 4.0,
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 35),
              child: ClipOval(
                child: Material(
                  color: Colors.white,
                  child: InkWell(
                    splashColor: AppColors.primary,
                    onTap: () {
                      _key.currentState!.openDrawer();
                    },
                    child: const SizedBox(
                        width: 50,
                        height: 50,
                        child: Icon(
                          Icons.menu,
                          size: 30,
                        )),
                  ),
                ),
              ),
            ),
            Positioned.fill(
                child: Align(
                    alignment: Alignment.topRight,
                    child: SizedBox(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          InkWell(
                              onTap: () {
                                setState(() {
                                  sagat = true;
                                  adaty = false;
                                  yol = false;
                                });
                                Provider.of<IndexProvider>(context,
                                        listen: false)
                                    .changeIndex(0);
                              },
                              child: const Text(
                                'Sabatlayyn',
                                style: TextStyle(fontSize: 20),
                              )),
                          InkWell(
                              onTap: () {
                                setState(() {
                                  sagat = false;
                                  adaty = true;
                                  yol = false;
                                });
                                Provider.of<IndexProvider>(context,
                                        listen: false)
                                    .changeIndex(1);
                              },
                              child: const Text(
                                'Adaty',
                                style: TextStyle(fontSize: 20),
                              )),
                          InkWell(
                              onTap: () {
                                setState(() {
                                  sagat = false;
                                  adaty = false;
                                  yol = true;
                                });
                                Provider.of<IndexProvider>(context,
                                        listen: false)
                                    .changeIndex(2);
                              },
                              child: const Text(
                                'Yol ugruna',
                                style: TextStyle(fontSize: 20),
                              )),
                        ],
                      ),
                    ))),
          ],
        ),
        key: _key,
        bottomSheet: Provider.of<IndexProvider>(context).selectIndex == -1
            ? null
            : Container(
                height: Provider.of<IndexProvider>(context, listen: false)
                    .sizeHeight(sizeHeight),
                decoration: const BoxDecoration(
                  // color: Colors.transparent,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                ),
                child: IndexedStack(
                    index: Provider.of<IndexProvider>(context).selectIndex,
                    children: [
                      bottomSheet(sizeHeight, sizeWidth, 'Sagatlaýyn'),
                      bottomSheet(sizeHeight, sizeWidth, 'Adaty'),
                      bottomSheet(sizeHeight, sizeWidth, 'Ýol ugry'),
                      callBottomSheet(sizeHeight, sizeWidth),
                      goBottomSheet(sizeHeight, sizeWidth),
                      complateBottomSheet(sizeHeight, sizeWidth),
                      cancelBottomSheet(sizeHeight, sizeWidth)
                    ]),
              ),
      ),
    );
  }

  Container bottomSheet(double sizeHeight, sizeWidth, String text) {
    return Container(
      height: sizeHeight * 60,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Container(
              height: 5,
              width: 60,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          SizedBox(
            height: sizeHeight * 1,
          ),
          Text(
            text,
            style: const TextStyle(fontSize: 30),
          ),
          SizedBox(
            width: sizeWidth * 70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      '5 min',
                      style: TextStyle(fontSize: 24),
                    ),
                    Icon(
                      Icons.circle,
                      size: 10,
                    ),
                    Text(
                      '350 m ',
                      style: TextStyle(fontSize: 24),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
                const Text(
                  'Rowsen Muhyyew',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: sizeHeight * 2,
                ),
                const Text(
                  '+99364929340',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
                const Text(
                  '+köç.Oguz Han, 123',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                SizedBox(
                  height: sizeHeight * 1,
                ),
                const Text(
                  '+köç.Oguz Han, 123',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                SizedBox(
                  height: sizeHeight * 1,
                ),
                const Text(
                  '+köç.Oguz Han, 123',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
                Row(
                  children: [
                    Image.asset('assets/icons/green_box.png'),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      '30 TMT',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(
                  height: sizeHeight * 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          call = true;
                          sagat = false;
                          adaty = false;
                          yol = false;
                        });
                        Provider.of<IndexProvider>(context, listen: false)
                            .changeIndex(3);
                      },
                      child: Container(
                        width: sizeWidth * 34,
                        height: 45,
                        margin: const EdgeInsets.only(bottom: 20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          'Sargyt almak',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Provider.of<IndexProvider>(context, listen: false)
                            .changeIndex(-1);
                      },
                      child: Container(
                        width: sizeWidth * 34,
                        height: 45,
                        margin: const EdgeInsets.only(bottom: 20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xffF00000),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          'Ýatyrmak',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container callBottomSheet(
    double sizeHeight,
    sizeWidth,
  ) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      ),
      child: Center(
        child: SizedBox(
          width: sizeWidth * 75,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Container(
                  height: 5,
                  width: 60,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(
                height: sizeHeight * 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: const [
                      Text('Rowsen Muhyyew',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600)),
                      Text(
                        '+99364929340',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Image.asset('assets/icons/call.png')
                ],
              ),
              const Divider(
                thickness: 0.8,
              ),
              SizedBox(
                height: sizeHeight * 3,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    call = false;
                  });
                  Provider.of<IndexProvider>(context, listen: false)
                      .changeIndex(4);
                },
                child: Container(
                  height: 45,
                  margin: const EdgeInsets.only(bottom: 20),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Men geldim',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container goBottomSheet(
    double sizeHeight,
    sizeWidth,
  ) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      ),
      child: Center(
        child: SizedBox(
          width: sizeWidth * 75,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Container(
                  height: 5,
                  width: 60,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(
                height: sizeHeight * 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: const [
                      Text(
                        'Rowsen Muhyyew',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '+99364929340',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Image.asset('assets/icons/call.png')
                ],
              ),
              const Divider(
                thickness: 0.8,
              ),
              SizedBox(
                height: sizeHeight * 1,
              ),
              const Text(
                'Garaşýan wagty',
                style: TextStyle(fontSize: 12),
              ),
              const Text(
                '01:30',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: sizeHeight * 1,
              ),
              const Divider(
                thickness: 0.8,
              ),
              SizedBox(
                height: sizeHeight * 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        go = false;
                      });
                      Provider.of<IndexProvider>(context, listen: false)
                          .changeIndex(5);
                    },
                    child: Container(
                      width: sizeWidth * 36,
                      height: 45,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'Gitmek',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Provider.of<IndexProvider>(context, listen: false)
                          .changeIndex(6);
                    },
                    child: Container(
                      width: sizeWidth * 36,
                      height: 45,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'Ýatyrmak',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container complateBottomSheet(
    double sizeHeight,
    sizeWidth,
  ) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      ),
      child: Center(
        child: SizedBox(
          width: sizeWidth * 75,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Container(
                  height: 5,
                  width: 60,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(
                height: sizeHeight * 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  SizedBox(),
                  Text(
                    'Wagt',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Aralyk',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  SizedBox(),
                  Text(
                    '07:10',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '10 km',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(),
                ],
              ),
              SizedBox(
                height: sizeHeight * 2,
              ),
              const Text(
                'Bahasy',
                style: TextStyle(fontSize: 12),
              ),
              const Text(
                '50 TMT',
                style: TextStyle(fontSize: 32),
              ),
              SizedBox(
                height: sizeHeight * 2,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ComplatePage(),
                    ),
                  );
                },
                child: Container(
                  height: 45,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Gutarmak',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container cancelBottomSheet(
    double sizeHeight,
    sizeWidth,
  ) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      ),
      child: Center(
        child: SizedBox(
          width: sizeWidth * 75,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: InkWell(
                      onTap: () {
                        
                          Provider.of<IndexProvider>(context, listen: false)
                              .backBottomSheet();
                        
                      },
                      child: Container(
                        height: 25,
                        width: 25,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(6)),
                        child: const Icon(CupertinoIcons.back),
                      ),
                    ),
                  ),
                  Container(
                    height: 5,
                    width: 60,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  const SizedBox()
                ],
              ),
              SizedBox(
                height: sizeHeight * 2,
              ),
              const Text(
                'Isim çykdy',
                style: TextStyle(fontSize: 14),
              ),
              const Divider(
                thickness: 0.8,
              ),
              const Text(
                'Gidesim gelmedi',
                style: TextStyle(fontSize: 14),
              ),
              const Divider(
                thickness: 0.8,
              ),
              const Text(
                'Sonurak gidjek',
                style: TextStyle(fontSize: 14),
              ),
              const Divider(
                thickness: 0.8,
              ),
              const Text(
                'Sonurak gidjek',
                style: TextStyle(fontSize: 14),
              ),
              const Divider(
                thickness: 0.8,
              ),
              SizedBox(
                height: sizeHeight * 2,
              ),
              InkWell(
                onTap: () {
                  Provider.of<IndexProvider>(context, listen: false)
                          .changeIndex(-1);

                },
                child: Container(
                  height: 45,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Tassyklamak',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();
}
