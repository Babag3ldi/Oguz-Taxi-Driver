import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../const/color_const.dart';
import '../screen/home_page.dart';
class Drawer1 extends StatelessWidget {
  const Drawer1({super.key});

  @override
  Widget build(BuildContext context) {
    // double sizeWidth = MediaQuery.of(context).size.width / 100;
    // double sizeHeight = MediaQuery.of(context).size.height / 100;
    return SafeArea(
      child: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          // padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 280,
              child: DrawerHeader(
                  decoration: const BoxDecoration(
                    // image: DecorationImage(
                    //   image: AssetImage(
                    //     'assets/images/drawerBack.png',
                    //   ),
                    //   fit: BoxFit.fill,
                    // ),
                    color: AppColors.primary,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height:  50,),
                      // Image.asset('assets/images/profile.png'),
                      const Text(
                        'Babag3ldi Orunov',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      const SizedBox(height: 15,),
                      Container(
                        height: 35,
                        width: 128,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                          Text(
                            'Cash',
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                          Text(
                            '2500',
                            style:
                                TextStyle(fontSize: 17, color: AppColors.primary),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Color(0xFFC1C0C9),
                            size: 15,
                          )
                        ]),
                      )
                    ],
                  )),
            ),
            ListTile(
              leading: Image.asset('assets/icons/homeIcon.png',),
              title: const Text(
                'Baş Sahypa',
                style: TextStyle(color: Color(0xFF242E42), fontSize: 17),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
            ),
            // ListTile(
            //   leading: Image.asset('assets/icons/walletIcon.png'),
            //   title: const Text(
            //     'Hasap',
            //     style: TextStyle(color: Color(0xFF242E42), fontSize: 17),
            //   ),
            //   onTap: () {
            //     // Navigator.push(
            //     //   context,
            //     //   MaterialPageRoute(
            //     //     builder: (context) => Wallet(),
            //     //   ),
            //     // );
            //   },
            // ),
            ListTile(
              leading: Image.asset('assets/icons/historyIcon.png'),
              title: const Text(
                'Taryh',
                style: TextStyle(color: Color(0xFF242E42), fontSize: 17),
              ),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => History(),
                //   ),
                // );
              },
            ),
            ListTile(
              leading: Image.asset('assets/icons/notificationIcon.png'),
              title: const Text(
                'Bellik',
                style: TextStyle(color: Color(0xFF242E42), fontSize: 17),
              ),
              onTap: ()  {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => Notifications(),
                //   ),
                // );
              },
            ),
            ListTile(
              leading: Image.asset('assets/icons/settingsIcon.png'),
              title: const Text(
                'Sazlamalar',
                style: TextStyle(color: Color(0xFF242E42), fontSize: 17),
              ),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => Settings(),
                //   ),
                // );
              },
            ),
            ListTile(
              leading: Image.asset('assets/icons/logoutIcon.png'),
              title: const Text(
                'Logout',
                style: TextStyle(color: Color(0xFF242E42), fontSize: 17),
              ),
              onTap: () {
               SystemNavigator.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
