// ignore_for_file: library_private_types_in_public_api, prefer_typing_uninitialized_variables, avoid_print

import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../../const/color_const.dart';
import '../../const/enums.dart';
import '../../provider/app_provider.dart';
import '../../services/login_api.dart';
import '../home_page.dart';

class PinCodeVerificationScreen extends StatefulWidget {
  final String phoneNumber;

  const PinCodeVerificationScreen({required this.phoneNumber, super.key});

  @override
  _PinCodeVerificationScreenState createState() =>
      _PinCodeVerificationScreenState();
}

class _PinCodeVerificationScreenState extends State<PinCodeVerificationScreen> {
  var onTapRecognizer;

  TextEditingController textEditingController = TextEditingController();

  late StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();

    super.dispose();
  }

  final otpController = TextEditingController();
  String code = "";

  @override
  Widget build(BuildContext context) {
    final providerLogin = Provider.of<LoginApi>(context);
    double sizeWidth = MediaQuery.of(context).size.width / 100;
    double sizeHeight = MediaQuery.of(context).size.height / 100;
    return Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldKey,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/otp.png'),
          fit: BoxFit.fill,
        )),
        child: ListView(
          children: <Widget>[
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Colors.white,
                      )),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: Text(
                'Telefon tassyklamak',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 34,
                    color: Colors.white),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: RichText(
                text: TextSpan(
                    text: "Şu ýere otp kodyny giriziň!  ",
                    children: [
                      TextSpan(
                          text: widget.phoneNumber,
                          style: const TextStyle(
                              color: Colors.white38,
                              fontWeight: FontWeight.bold,
                              fontSize: 15)),
                    ],
                    style: const TextStyle(color: Colors.white, fontSize: 15)),
              ),
            ),
            const SizedBox(
              height: 150,
            ),
            Form(
              key: formKey,
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 50),
                  child: PinCodeTextField(
                    appContext: context,
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                    pastedTextStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                    length: 6,
                    obscureText: false,
                    obscuringCharacter: '●',
                    animationType: AnimationType.fade,
                    validator: (v) {
                      if (v!.length < 3) {
                        return "I'm from validator";
                      } else {
                        return null;
                      }
                    },
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.underline,
                      borderRadius: BorderRadius.circular(5),
                      selectedFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      selectedColor: Color(0xFFD8D8D8),
                      inactiveColor: Color(0xFFD8D8D8),
                      disabledColor: Color(0xFFD8D8D8),
                      activeColor: Color(0xFFD8D8D8),
                      borderWidth: 5,
                      fieldHeight: 80,
                      fieldWidth: 40,
                      activeFillColor: hasError ? Colors.white : Colors.white,
                    ),
                    cursorColor: Colors.black,
                    animationDuration: Duration(milliseconds: 300),
                    // textStyle: TextStyle(fontSize: 20, height: 1.6),
                    // backgroundColor: Colors.blue.shade50,
                    enableActiveFill: true,

                    errorAnimationController: errorController,
                    controller: textEditingController,
                    keyboardType: TextInputType.number,
                    onCompleted: (value) async {
                      debugPrint("yes");
                      setState(() {
                        code = value;
                      });
                      await Provider.of<LoginApi>(context, listen: false)
                          .getToken(code: code, phone: widget.phoneNumber);
                      if (mounted && providerLogin.user != null) {
                        await Provider.of<AppProvider>(context, listen: false)
                            .userSet(providerLogin.user!);
                      }
                      if (providerLogin.status == ApiStatus.success) {
                        showmessages("Üstünlikli").then(
                            (value) => Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (ctx) => HomePage(),
                                  ),
                                ));
                      } else {
                        showmessages("Ýalňyş");
                      }
                    },
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        currentText = value;
                      });
                    },
                    beforeTextPaste: (text) {
                      print("Allowing to paste $text");
                      return true;
                    },
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Text(
                hasError ? "*Please fill up all the cells properly" : "",
                style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(
              height: sizeHeight * 4,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: InkWell(
                  onTap: () {
                    formKey.currentState!.validate();
                    // conditions for validating
                    if (currentText.length != 6 || currentText != "towtow") {
                      errorController.add(ErrorAnimationType
                          .shake); // Triggering error shake animation
                      setState(() {
                        hasError = true;
                      });
                    } else {
                      setState(() {
                        hasError = false;
                        // scaffoldKey.currentState.showSnackBar(SnackBar(
                        //   content: Text("Aye!!"),
                        //   duration: Duration(seconds: 2),
                        // )
                        // );
                      });
                    }
                  },
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
                        );
                      },
                      child: VerifyButton('Tassyklamak'))),
            ),
          ],
        ),
      ),
    );
  }

  Future showmessages(String message) async {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
    ));
  }

  Widget VerifyButton(String text) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: size.width / 8,
        // width: size.width / 1.22,
        alignment: Alignment.center,
        padding: EdgeInsets.only(right: size.width / 30),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ));
  }
}
