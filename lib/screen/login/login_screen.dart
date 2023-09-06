// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../const/color_const.dart';
import '../../services/login_api.dart';
import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
      TextEditingController controller = TextEditingController();
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<double> _transform;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    )..addListener(() {
        setState(() {});
      });

    _transform = Tween<double>(begin: 2, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    );

    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  showmessages(String message) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sizeWidth = MediaQuery.of(context).size.width / 100;
    double sizeHeight = MediaQuery.of(context).size.height / 100;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: SizedBox(
              height: size.height,
              child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/images/login.png',
                        ),
                        fit: BoxFit.fill)),
                child: SizedBox(
                  height: sizeHeight * 85,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Opacity(
                        opacity: _opacity.value,
                        child: Transform.scale(
                          scale: _transform.value,
                          child: Container(
                            width: size.width * .92,
                            height: sizeHeight * 46.8,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(.2),
                                  blurRadius: 90,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: sizeHeight * 10.6,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        height: 87,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const SizedBox(
                                              height: 12,
                                            ),
                                            const Text(
                                              'Içeri gir',
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black),
                                            ),
                                            const SizedBox(
                                              height: 9,
                                            ),
                                            Container(
                                              height: 5,
                                              width: 37,
                                              decoration: BoxDecoration(
                                                  color: AppColors.primary,
                                                  borderRadius:
                                                      BorderRadius.circular(2.5)),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  thickness: 1,
                                ),
                                SizedBox(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      SizedBox(
                                        height: sizeHeight * 3.5,
                                      ),
                                      SizedBox(
                                        width: sizeWidth * 80,
                                        child: const Text(
                                          'Telefon belgiňizi ýazyp içeri girip bilersiňiz!',
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                      SizedBox(
                                        height: sizeHeight * 3,
                                      ),
                                      loginNumber('61 xxxxxx', false, true),
                                      SizedBox(
                                        height: sizeHeight * 5,
                                      ),
                                      Center(
                                        child: InkWell(
                                            onTap: () async {
                                             
                                            if (controller.text.isEmpty) {
                                              showmessages("Telefon belgiňizi ýazyň");
                                              return;
                                            }
                                            if (controller.text.length != 8) {
                                              showmessages("Telefon belgi ýalňyş ");
                                              return;
                                            }
                                            if (formKey.currentState!.validate()) {
                                              await Provider.of<LoginApi>(context, listen: false).sendCodePhone(controller.text);
                                              if (mounted) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => PinCodeVerificationScreen(
                                                            phoneNumber: controller.text,
                                                          )),
                                                );
                                              }
                                            } else {}
                                            },
                                            child: LoginButton('Next')),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: sizeHeight * 8,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  final formKey = GlobalKey<FormState>();

  

  Widget loginNumber(String hintText, bool isPassword, bool isEmail) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.width / 8,
      width: size.width / 1.22,
      alignment: Alignment.center,
      padding: EdgeInsets.only(right: size.width / 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xFFEFEFF4), width: 1.5),
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.black.withOpacity(.8)),
        obscureText: isPassword,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 10, top: 12, right: 5),
            child: Text(
              '+993 |',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
          ),
          // prefix: Text('+993'),
          border: InputBorder.none,
          hintMaxLines: 1,
          hintText: hintText,
          hintStyle:
              TextStyle(fontSize: 16, color: Colors.black.withOpacity(.5)),
        ),
      ),
    );
  }

  Widget LoginButton(String text) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: size.width / 8,
        width: size.width / 1.22,
        alignment: Alignment.center,
        padding: EdgeInsets.only(right: size.width / 30),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ));
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) {
    return child;
  }
}
