import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_finance/components/constant.dart';
import 'package:flutter_finance/router/named_routes.dart';
import 'package:flutter_finance/widgets/portfolio_piechart.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class InvestmentPage extends StatefulWidget {
  const InvestmentPage({super.key});

  @override
  State<InvestmentPage> createState() => _InvestmentPageState();
}

class _InvestmentPageState extends State<InvestmentPage> {
  final DateTime now = DateTime.now();
  late String formattedDate;
  int totalInvestment = 0;
  int annualIncome = 0;
  int currentSavings = 0;
  int totalStockInvestment = 0;
  List<Map<String, dynamic>> groupedStocks = [];

  @override
  void initState() {
    super.initState();
    formattedDate = DateFormat('MMMM d, y').format(now);
    fetchAndStoreInvestmentData();
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

  Future<void> fetchAndStoreInvestmentData() async {
    final url = 'http://192.168.137.124:3000/users/getUserInvestment';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authToken = prefs.getString('authToken');
    print("hellllllllllllooooooo");

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        await prefs.setInt('annualIncome', data['annualIncome']);
        await prefs.setInt('currentSavings', data['currentSavings']);
        await prefs.setInt(
            'totalStockInvestment', data['totalStockInvestment']);
        List<String> groupedStocksJson = [];
        for (var stock in data['groupedStocks']) {
          groupedStocksJson.add(json.encode(stock));
        }
        await prefs.setStringList('groupedStocks', groupedStocksJson);
        print("Investment data stored successfully.");
      } else {
        print("Failed to fetch data: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching investment data: $error");
    }
  }

  // Function to get total investment from SharedPreferences


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
                Text("Investment",
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Investment",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(totalStockInvestment.toString() ,
                              style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black)),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Text(formattedDate),
                      Row(
                        children: [
                          Expanded(
                              child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: SizedBox(
                                    height: screenHeight * 0.15,
                                    child: PieChart(
                                      PieChartData(sections: [
                                        PieChartSectionData(
                                          radius: 20,
                                          value: 40,
                                          color: Colors.green,
                                        ),
                                        PieChartSectionData(
                                          value: 60,
                                          showTitle: false,
                                          color: Colors.white,
                                        ),
                                      ]),
                                    ),
                                  )),
                                  const Expanded(
                                      child: Row(
                                    children: [
                                      Icon(
                                        Icons.real_estate_agent,
                                        color: Colors.green,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 10.0),
                                        child: Text(
                                          "20%",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      )
                                    ],
                                  ))
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: SizedBox(
                                    height: screenHeight * 0.15,
                                    child: PieChart(
                                      PieChartData(sections: [
                                        PieChartSectionData(
                                          radius: 20,
                                          value: 30,
                                          color: Colors.red,
                                        ),
                                        PieChartSectionData(
                                          value: 70,
                                          showTitle: false,
                                          color: Colors.white,
                                        ),
                                      ]),
                                    ),
                                  )),
                                  const Expanded(
                                      child: Row(
                                    children: [
                                      Icon(
                                        Icons.real_estate_agent,
                                        color: Colors.red,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 10.0),
                                        child: Text(
                                          "20%",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      )
                                    ],
                                  ))
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: SizedBox(
                                    height: screenHeight * 0.15,
                                    child: PieChart(
                                      PieChartData(sections: [
                                        PieChartSectionData(
                                          radius: 15,
                                          value: 20,
                                          color: Colors.yellow,
                                        ),
                                        PieChartSectionData(
                                          value: 80,
                                          showTitle: false,
                                          color: Colors.white,
                                        ),
                                      ]),
                                    ),
                                  )),
                                  const Expanded(
                                      child: Row(
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
                                  ))
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: SizedBox(
                                    height: screenHeight * 0.15,
                                    child: PieChart(
                                      PieChartData(sections: [
                                        PieChartSectionData(
                                          radius: 10,
                                          value: 10,
                                          color: Colors.blue,
                                        ),
                                        PieChartSectionData(
                                          value: 55,
                                          showTitle: false,
                                          color: Colors.white,
                                        ),
                                      ]),
                                    ),
                                  )),
                                  const Expanded(
                                      child: Row(
                                    children: [
                                      Icon(
                                        Icons.real_estate_agent,
                                        color: Colors.blue,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 10.0),
                                        child: Text(
                                          "20%",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      )
                                    ],
                                  ))
                                ],
                              ),
                            ],
                          ))
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          GoRouter.of(context)
                              .pushNamed(UserRoutes.addNewInvestment);
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width * 0.55,
                          decoration: BoxDecoration(
                              color: MyColors.backgroundColor2,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Add New Investment?",
                                    style: GoogleFonts.inter(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        letterSpacing: 1)),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
