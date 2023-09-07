// ignore_for_file: depend_on_referenced_packages, unused_local_variable, non_constant_identifier_names, use_build_context_synchronously, avoid_print

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:location/location.dart';
import 'package:open_route_service/open_route_service.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:provider/provider.dart';
import 'package:oguz_taxi_driver/screen/complate_page.dart';
import '../const/color_const.dart';
import '../provider/app_provider.dart';
import '../provider/index_provider.dart';
import '../provider/map_provider.dart';
import '../services/web_socket.dart';
import '../widgets/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with OSMMixinObserver {
  final webSocketService = WebSocketService();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      alertDialog();
    });
    scaffoldKey = GlobalKey<ScaffoldState>();
    fetch();

    getLocation();
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

  late GlobalKey<ScaffoldState> scaffoldKey;
  geo.Position? _currentPosition;
  ORSCoordinate? latLng;
  bool loading = true;
  fetch() async {
    final box = Hive.box('LoginBox');

    final hive = await Hive.openBox('LoginBox');
    final user = await box.get('user');
    log('init');
    webSocketService.initWebSocket(user!.token);

    await Provider.of<AppProvider>(context, listen: false).userSet(user);
    await _getCurrentPosition();
    MapController controller = MapController.customLayer(
      initMapWithUserPosition: true,
      areaLimit: BoundingBox(
          east: 58.481078, // Longitude for eastern boundary
          north: 37.999194, // Latitude for northern boundary
          south: 37.782570, // Latitude for southern boundary
          west: 58.301888 // Longitude for western boundary
          ),
      customTile: CustomTile(
        sourceName: "openstreetmap",
        tileExtension: ".png",
        minZoomLevel: 10,
        maxZoomLevel: 19,
        urlsServers: [TileURLs(url: "https://a.tile.openstreetmap.org/")],
        tileSize: 256,
      ),
    );
    controller.addObserver(this);
    Provider.of<MapProvider>(context, listen: false).setMap(controller, latLng);
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await geo.Geolocator.getCurrentPosition(
            desiredAccuracy: geo.LocationAccuracy.high)
        .then((geo.Position position) {
      setState(() {
        _currentPosition = position;
        latLng = ORSCoordinate(
            latitude: _currentPosition!.latitude,
            longitude: _currentPosition!.longitude);
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    geo.LocationPermission permission;

    serviceEnabled = await geo.Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await geo.Geolocator.checkPermission();
    if (permission == geo.LocationPermission.denied) {
      permission = await geo.Geolocator.requestPermission();
      if (permission == geo.LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == geo.LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> mapIsInitialized() async {
    await Provider.of<MapProvider>(context, listen: false)
        .controller!
        .setZoom(zoomLevel: 12);
    if (mounted) {
      Provider.of<MapProvider>(context, listen: false)
          .controller!
          .changeLocation(GeoPoint(
              latitude: latLng!.latitude, longitude: latLng!.longitude));
    }
    for (int i = 1; i < 4; i++) {
      Provider.of<MapProvider>(context, listen: false).controller!.zoomIn();
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Future<void> mapIsReady(bool isReady) async {
    if (isReady) {
      await mapIsInitialized();
    }
  }

  void getLocation() async {
    Location location = Location();

    late bool _serviceEnabled;
    late PermissionStatus _permissionGranted;
    late LocationData _locationData;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    location.onLocationChanged.listen((LocationData event) {
      webSocketService.sendMessage(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
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
        key: scaffoldKey,
        resizeToAvoidBottomInset: false,
        drawer: const Drawer1(),
        floatingActionButton:
            Provider.of<MapProvider>(context).controller == null
                ? null
                : PointerInterceptor(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: FloatingActionButton(
                        onPressed: () async {
                          Provider.of<MapProvider>(context, listen: false)
                              .controller!
                              .changeLocation(GeoPoint(
                                  latitude: latLng!.latitude,
                                  longitude: latLng!.longitude));
                          for (int i = 1; i < 6; i++) {
                            Provider.of<MapProvider>(context, listen: false)
                                .controller!
                                .zoomIn();
                          }
                        },
                        child: const Icon(Icons.my_location),
                      ),
                    ),
                  ),
        body: Stack(
          children: [
            Provider.of<MapProvider>(context).controller == null
                ? Container(
                    alignment: Alignment.bottomCenter,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/splash.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: SpinKitThreeBounce(
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  )
                : Stack(children: [
                    OSMFlutter(
                      controller: Provider.of<MapProvider>(context).controller!,
                      // mapIsLoading:  Center(
                      //   child: Column(
                      //     mainAxisSize: MainAxisSize.min,
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     children: const [
                      //       CircularProgressIndicator(),
                      //       Text("Karta ýüklenýär.."),
                      //     ],
                      //   ),
                      // ),
                      onMapIsReady: (isReady) {
                        if (isReady) {
                          // print("map is ready");
                        }
                      },
                      onLocationChanged: (myLocation) {
                        print(myLocation);
                      },
                      onGeoPointClicked: (geoPoint) async {},
                      // osmOption: const OSMOption(enableRotationByGesture: true),
                    ),
                    Positioned(
                      left: 10,
                      top: 20,
                      child: InkWell(
                          onTap: () => scaffoldKey.currentState!.openDrawer(),
                          child: Image.asset(
                            "assets/icons/draver.png",
                          )),
                    ),
                  ]),
            Positioned.fill(
                child: Align(
                    alignment: Alignment.topRight,
                    child: SizedBox(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
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
                                'Sagatlayyn',
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
                Divider(
                  color: Colors.black,
                ),

                const Text(
                  'Rowsen Muhyyew',
                  style: TextStyle(fontSize: 18),
                ),
                // SizedBox(
                //   height: sizeHeight * 2,
                // ),
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
                Divider(
                  color: Colors.black,
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
