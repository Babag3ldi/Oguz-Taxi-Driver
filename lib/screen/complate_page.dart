import 'package:flutter/material.dart';
import 'package:oguz_taxi_driver/const/color_const.dart';
import 'package:oguz_taxi_driver/screen/home_page.dart';

class ComplatePage extends StatefulWidget {
  const ComplatePage({super.key});

  @override
  State<ComplatePage> createState() => _ComplatePageState();
}

class _ComplatePageState extends State<ComplatePage> {
  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width / 100;
    double sizeHeight = MediaQuery.of(context).size.height / 100;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: sizeHeight * 45,
            decoration: const BoxDecoration(
              color: AppColors.primary,
            ),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: sizeHeight * 10,
                  ),
                  Image.asset('assets/icons/check.png'),
                  SizedBox(
                    height: sizeHeight * 2,
                  ),
                  const Text(
                    'Üstunlikli tamamlamdy',
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                  const Text(
                    'sagboluň we hasap\ngörkezmeli',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: sizeHeight * 55,
            width: sizeWidth * 75,
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: sizeHeight * 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Ugran yeri',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'köç.Oguz Han, 123',
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: sizeHeight * 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Baran yeri',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Magtymguly şaýoly, 14',
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: sizeHeight * 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Bahasy',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '25.00TMT',
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: sizeHeight * 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Garaşylan Wagt',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '5mint',
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: sizeHeight * 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Garaşylan Wagt Baha',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '5man',
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 0.8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Jemi',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '35man',
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: sizeHeight * 5,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
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
                        'Bas sahypa dolanmak',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
