import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_finance/components/constant.dart';
import 'package:flutter_finance/router/named_routes.dart';
import 'package:flutter_finance/widgets/news_card.dart';
import 'package:flutter_finance/widgets/portfolio_piechart.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NewsHomePage extends StatefulWidget {
  const NewsHomePage({super.key});

  @override
  State<NewsHomePage> createState() => _NewsHomePageState();
}

class _NewsHomePageState extends State<NewsHomePage> {
  final DateTime now = DateTime.now();
  late String formattedDate;

  @override
  void initState() {
    super.initState();
    formattedDate = DateFormat('MMMM d, y').format(now);
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
                Text("News",
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
                      search(),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 10),
                        child: SizedBox(
                          height: 40,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: const [
                              Text("#Health"),
                              SizedBox(
                                width: 10,
                              ),
                              Text("#Stocks"),
                              SizedBox(
                                width: 10,
                              ),
                              Text("#News"),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Tata"),
                              SizedBox(
                                width: 10,
                              ),
                              Text("#Reliance"),
                              SizedBox(
                                width: 10,
                              ),
                              Text("#Finance"),
                              SizedBox(
                                width: 10,
                              ),
                              Text("#Trend"),
                              SizedBox(
                                width: 10,
                              ),
                              Text("#Market")
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("View All",
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: screenHeight * 0.35,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              NewsCard(
                                imagePath: 'assets/images/image.png',
                                authorName: 'John Doe',
                                articalDescription: "hello there this is article details",
                                date: '2022-02-20',
                              ),
                              NewsCard(
                                imagePath: 'assets/images/image.png',
                                authorName: 'John Doe',
                                articalDescription: "hello there this is article details",
                                date: '2022-02-20',
                              )
                            ],
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
        color: MyColors.appBackGround,
        border: Border.all(width: 0.2),
        borderRadius: BorderRadius.circular(15),
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
