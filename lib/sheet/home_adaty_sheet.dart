import 'package:flutter/material.dart';

import '../const/color_const.dart';

class HomeBottomSheet extends StatelessWidget {
  const HomeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width / 100;
    double sizeHeight = MediaQuery.of(context).size.height / 100;
    return Container(
      height: sizeHeight * 55,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
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
          const Text(
            'Adaty',
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(
            height: sizeHeight * 2,
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
                    Container(
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
                        Container(
                          width: sizeWidth * 34,
                          height: 45,
                          margin: const EdgeInsets.only(bottom: 20),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color:  Color(0xffF00000),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'Ýatyrmak',
                            style: TextStyle(color: Colors.white, fontSize: 14),
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
}
