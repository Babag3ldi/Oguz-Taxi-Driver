import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:oguz_taxi_driver/provider/app_provider.dart';
import 'package:provider/provider.dart';

import 'model/user_model.dart';
import 'provider/index_provider.dart';
import 'provider/map_provider.dart';
import 'screen/splash_screen.dart';
import 'services/login_api.dart';

void main() async {
  await Hive.initFlutter();
  // await Hive.openBox<UserModel>("LoginBox");
  Hive.registerAdapter<UserModel>(UserAdapter());
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<IndexProvider>(
            create: (context) => IndexProvider()),
        ChangeNotifierProvider<AppProvider>(create: (context) => AppProvider()),
        ChangeNotifierProvider<LoginApi>(create: (context) => LoginApi()),
        ChangeNotifierProvider(create: (context) => MapProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Mitr',
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
