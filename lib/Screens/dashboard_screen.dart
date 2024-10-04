import 'package:flutter/material.dart';
import 'package:flutter_finance/components/constant.dart';
import 'package:flutter_finance/widgets/stock_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
        final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            search(),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Container(
              height: screenHeight * 0.2,
              width: screenWidth * 0.9,
              decoration: BoxDecoration(
                color: MyColors.ourPrimary,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, bottom: 20),
                          child: Text("Your Portfolio is up by 5% this month",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width * 0.3,
                          decoration: BoxDecoration(
                              color: MyColors.backgroundColor2,
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                            child: Text("Check ",
                                style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 1)),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: LottieBuilder.asset(
                      'assets/Lotty/stockGrowth.json',
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Container(
              height: screenHeight * 0.2,
              width: screenWidth * 0.9,
              decoration: BoxDecoration(
                color: MyColors.ourPrimary,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.12,
                            width: MediaQuery.of(context).size.width * 0.3,
                            decoration: BoxDecoration(
                                // color: MyColors.backgroundColor2,
                                borderRadius: BorderRadius.circular(15)),
                            child: LottieBuilder.asset(
                              'assets/Lotty/portfolioAni.json',
                            ),
                          ),
                        ),
                        const Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 10),
                          child: Text("Your Portfolio",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Text("Profit Last Week"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  width:
                                      MediaQuery.of(context).size.width * 0.15,
                                  decoration: BoxDecoration(
                                      // color: MyColors.backgroundColor2,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: LottieBuilder.asset(
                                    'assets/Lotty/moneyAni.json',
                                  ),
                                ),
                              ),
                              Text("₹4.000.00",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20))
                            ],
                          ),
                          SizedBox(
                            width: screenWidth * 0.4,
                            child: const Divider(
                              thickness: 2,
                              color: Colors.white,
                            ),
                          ),
                          Text("Risk Level"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  width:
                                      MediaQuery.of(context).size.width * 0.15,
                                  decoration: BoxDecoration(
                                      // color: MyColors.backgroundColor2,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: LottieBuilder.asset(
                                    'assets/Lotty/riskAni.json',
                                  ),
                                ),
                              ),
                              Text(
                                "Moderate",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              )
                            ],
                          ),
                        ],
                      ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Top Stocks",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                  DropdownButton(
                      hint: Text("All Time"),
                      items: const [
                        DropdownMenuItem(
                          child: Text("All Time"),
                          value: 1,
                        ),
                        DropdownMenuItem(
                          child: Text("1Yr"),
                          value: 2,
                        ),
                        DropdownMenuItem(
                          child: Text("5Yr"),
                          value: 3,
                        ),
                      ],
                      onChanged: (value) {
                        print(value);
                      })
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.245,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  StockCard(
                    companyName: 'Tata Motors',
                    currentPrice: '650.55',
                    imagePath: 'assets/images/facebook.png',
                    isBullMarket: true, // Show bull run animation
                  ),
                  StockCard(
                    companyName: 'Reliance Industries',
                    currentPrice: '2390.75',
                    imagePath: 'assets/images/facebook.png',
                    isBullMarket: false, // Show bear market animation
                  ),
                  StockCard(
                    companyName: 'Infosys',
                    currentPrice: '1485.20',
                    imagePath: 'assets/images/facebook.png',
                    isBullMarket: true, // Show bull run animation
                  ),
                  StockCard(
                    companyName: 'HDFC Bank',
                    currentPrice: '1580.10',
                    imagePath: 'assets/images/facebook.png',
                    isBullMarket: false, // Show bear market animation
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            // Text(
            //   'Selected Page: $_page',
            //   textScaleFactor: 2,
            // ),
          ],
        ),
      );
  }

  Widget search() {
    return Container(
      margin: const EdgeInsets.only(
        top: 24,
        left: 24,
        right: 24,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18),
      height: 54,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            height: 24,
            width: 24,
            child: Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Search...',
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
