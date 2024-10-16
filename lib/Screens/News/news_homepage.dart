import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_finance/Screens/News/short_news_card.dart';
import 'package:flutter_finance/components/constant.dart';
import 'package:flutter_finance/models/ipo_models.dart';
import 'package:flutter_finance/models/new_models.dart';
import 'package:flutter_finance/models/new_shortNews.dart';
import 'package:flutter_finance/router/named_routes.dart';
import 'package:flutter_finance/services/auth_services.dart';
import 'package:flutter_finance/widgets/news_card.dart';
import 'package:flutter_finance/widgets/portfolio_piechart.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class NewsHomePage extends StatefulWidget {
  const NewsHomePage({super.key});

  @override
  State<NewsHomePage> createState() => _NewsHomePageState();
}

class _NewsHomePageState extends State<NewsHomePage> {
  final DateTime now = DateTime.now();
  late String formattedDate;
  List<NewsModels> newsList = [];
  List<Map<String, String>> newsList2 = [];
  bool isLoading = true;
  bool hasError = false;
  late Future<ipoModels> futureIpo;

  // Future<void> _loadNews() async {
  //   try {
  //     final fetchedNews = await AuthService().fetchNews();
  //     setState(() {
  //       newsList =
  //           fetchedNews.map((item) => NewsModels.fromJson(item)).toList();
  //       isLoading = false;
  //       hasError = fetchedNews.isEmpty;
  //     });
  //   } catch (e) {
  //     setState(() {
  //       isLoading = false;
  //       hasError = true;
  //     });
  //   }
  // }

  // Function to fetch news from API
  Future<void> fetchNews() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authToken = prefs.getString('authToken');

    final response = await http.get(
      Uri.parse('https://vh-24-byte-fuse.vercel.app/users/news'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
    );
    try {
      // final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        List<NewsModels> fetchedNews =
            data.map((item) => NewsModels.fromJson(item)).toList();
        setState(() {
          newsList = fetchedNews;
          // print me this newsList to see if this api is working or not
          print(newsList);
        });
      } else {
        print('Failed to load news. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while fetching news: $e');
    }
  }

  late Future<List<NewsModels2>> futureNews;

  @override
  void initState() {
    super.initState();
    formattedDate = DateFormat('MMMM d, y').format(now);
    fetchNews();
    final authService = AuthService();
    futureNews = authService.fetchTrendingNews();
    futureIpo = authService.fetchIpoData();
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
                          height: screenHeight * 0.38,
                          child: newsList.isNotEmpty
                              ? ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: newsList.length,
                                  itemBuilder: (context, index) {
                                    final newsItem = newsList[index];
                                    return NewsCard(
                                        authorName: newsItem.authors![0] ?? "",
                                        articalDescription:
                                            newsItem.summary ?? "",
                                        imagePath: newsItem.bannerImage ?? "",
                                        date: newsItem.timePublished ?? "");
                                    //return ListTile(
                                    //   leading: Image.network(
                                    //     newsItem.bannerImage ?? '',
                                    //     width: 80,
                                    //     height: 80,
                                    //     fit: BoxFit.cover,
                                    //     errorBuilder:
                                    //         (context, error, stackTrace) =>
                                    //             Icon(Icons.error),
                                    //   ),
                                    //   title: Text(newsItem.title ?? 'No Title'),
                                    //   subtitle: Text(
                                    //       newsItem.source ?? 'Unknown Source'),
                                    //   onTap: () {
                                    //     print('Opening: ${newsItem.url}');
                                    //   },
                                    // );
                                  },
                                )
                              : Center(child: CircularProgressIndicator()),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Trending News",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            Text("View All")
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.15,
                          child: FutureBuilder<List<NewsModels2>>(
                            future: futureNews,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error: ${snapshot.error}'));
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.isEmpty) {
                                return Center(
                                    child: Text('No trending news available.'));
                              }

                              List<NewsModels2> newsList =
                                  snapshot.data!.take(5).toList();

                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: newsList.length,
                                itemBuilder: (context, index) {
                                  return ShortNews(
                                    imagePath: 'assets/images/image.png',
                                    title: newsList[index].title ?? 'No title',
                                    source: newsList[index].source ??
                                        'Unknown source',
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //       horizontal: 20.0, vertical: 10),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Text(
                      //         "Trending",
                      //         style: TextStyle(
                      //           fontSize: 20,
                      //           fontWeight: FontWeight.w500,
                      //           color: Colors.black,
                      //         ),
                      //       ),
                      //       Text("View All")
                      //     ],
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: FutureBuilder<ipoModels>(
                          future: futureIpo,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                  child:
                                      CircularProgressIndicator()); // Show loading indicator
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text(
                                      'Error: ${snapshot.error}')); // Handle errors
                            } else if (!snapshot.hasData ||
                                snapshot.data!.ipoCalendar == null ||
                                snapshot.data!.ipoCalendar!.isEmpty) {
                              return Center(
                                  child: Text(
                                      'No IPO data available.')); // No data available
                            }

                            // Extract IPO calendar data
                            List<IpoCalendar>? ipoList =
                                snapshot.data!.ipoCalendar;

                            return ListView.builder(
                              itemCount: ipoList!.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(ipoList[index].name ?? 'No name'),
                                  subtitle: Text(
                                      'Date: ${ipoList[index].date} - Status: ${ipoList[index].status}'),
                                );
                              },
                            );
                          },
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
