import 'package:flutter/material.dart';
import 'package:flutter_finance/components/constant.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class on_board4 extends StatelessWidget {
  const on_board4({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(children: [
        const SizedBox(
          height: 40,
        ),
       Container(
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width * 0.95,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: MyColors.onboard2),
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                 const SizedBox(
                  height: 20,
                ),
                Text(
                  "Understand Your\n Financial Behaviour.",
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
                    const SizedBox(
                  height: 20,
                ),
                Text(
                  "Set financial goals, save money, and buy stocks. All\n the financial tools for your goals in one place",
                  style: TextStyle(fontSize: 15),
                  textAlign: TextAlign.left,
                ),
              const SizedBox(
                  height: 30,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.46,
                  child: LottieBuilder.asset(
                    'assets/Lotty/fourGeo.json',
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
