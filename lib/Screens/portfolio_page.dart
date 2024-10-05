import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_finance/components/constant.dart';
import 'package:flutter_finance/widgets/portfolio_piechart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final DateTime now = DateTime.now();
  late String formattedDate;

  int annualIncome = 0;
  int currentSavings = 0;
  int totalStockInvestment = 0;
  List<Map<String, dynamic>> groupedStocks = [];

  @override
  void initState() {
    super.initState();
    formattedDate = DateFormat('MMMM d, y').format(now);
    fetchPortfolioData(); 
  }

  Future<void> fetchPortfolioData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      annualIncome = prefs.getInt('annualIncome') ?? 0;
      currentSavings = prefs.getInt('currentSavings') ?? 0;
      totalStockInvestment = prefs.getInt('totalStockInvestment') ?? 0;
      List<String> groupedStocksJson =
          prefs.getStringList('groupedStocks') ?? [];

      groupedStocks = groupedStocksJson.map((stockJson) {
        return json.decode(stockJson) as Map<String, dynamic>;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: MyColors.ourPrimary,
      body: Column(
        children: [
          SizedBox(height: screenHeight * 0.06),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Portfolio",
                    style: GoogleFonts.poppins(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    )),
                Icon(Icons.notifications_active)
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Expanded(
            child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text("Gross Balance"),
                      Text(currentSavings.toString(),
                          style: GoogleFonts.poppins(
                              fontSize: 35,
                              fontWeight: FontWeight.w500,
                              color: Colors.black)),
                      Text("YOUR investment"),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: Container(
                                  height: screenHeight * 0.23,
                                  child: PortfolioPiechart())),
                          const Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.real_estate_agent,
                                        color: Colors.yellow,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 10.0),
                                        child: Text(
                                          "20%",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.inventory_2_outlined,
                                        color: Colors.red,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 10.0),
                                        child: Text(
                                          "30%",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.price_change_outlined,
                                        color: Colors.green,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 10.0),
                                        child: Text(
                                          "40%",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.currency_bitcoin,
                                        color: Colors.blue,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 10.0),
                                        child: Text(
                                          "10%",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ))
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Text(formattedDate),
                      SizedBox(height: screenHeight * 0.02),
                     ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: groupedStocks.length,
                            itemBuilder: (context, index) {
                              print("stock here:!" + groupedStocks[index].toString());
                              var stock = groupedStocks[index];
                              return Padding(
                                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          stock['type'] == 'up'
                                              ? Icons.arrow_circle_up
                                              : Icons.arrow_circle_down,
                                          size: 35,
                                        ),
                                        SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Stocks", style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black
                                            )),
                                            Row(
                                              children: [
                                                Text(stock['name'] ?? 'Unknown Stock',
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w400,
                                                        color: Colors.grey)),
                                                    Text(
                                      " : ${stock['numberOfStocks'] ?? 0}",
                                      style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "₹${stock['investedAmount'] ?? 0}",
                                          style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        ),
                                         Text(
                                          "₹ per stock ${stock['pricePerStock'] ?? 0}",
                                          style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                      SizedBox(height: screenHeight * 0.02),
                      Text(formattedDate),
                      SizedBox(height: screenHeight * 0.02),
                      const Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.arrow_circle_up, size: 35),
                                Column(
                                  children: [
                                    Text("SALARY"),
                                    Text("Software Engineer")
                                  ],
                                ),
                              ],
                            ),
                            Text("+₹142550")
                          ],
                        ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.only(left: 20.0, right: 20, top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.arrow_circle_down,
                                  size: 35,
                                ),
                                Column(
                                  children: [Text("Rent"), Text("4BHK")],
                                ),
                              ],
                            ),
                            Text("-₹35550")
                          ],
                        ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.only(left: 20.0, right: 20, top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.arrow_circle_up,
                                  size: 35,
                                ),
                                Column(
                                  children: [Text("Stocks"), Text("TATA")],
                                ),
                              ],
                            ),
                            Text("data")
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
