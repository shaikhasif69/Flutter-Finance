import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_finance/Screens/dashboard_screen.dart';
import 'package:flutter_finance/Screens/investment_page.dart';
import 'package:flutter_finance/Screens/portfolio_page.dart';
import 'package:flutter_finance/Screens/side_bar.dart';
import 'package:flutter_finance/components/constant.dart';
import 'package:flutter_finance/widgets/stock_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final List<Widget> _pages = [
    DashboardScreen(),
    PortfolioPage(),
    InvestmentPage(),
    Container(color: Colors.white),
    Container(color: Colors.white),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.appBackGround,
      appBar: _page == 0 ? AppBar(
        backgroundColor: MyColors.appBackGround,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hi, Welcome Back",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Text(
              "Good Morning",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Icon(Icons.notifications_active, color: Colors.black),
          ),
        ],
      ) : null,
      drawer: SideBar(),
      // body:
      body: _pages[_page],
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 65.0,
        items: const <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: Colors.black,
          ),
          Icon(
            Icons.badge_outlined,
            size: 30,
            color: Colors.black,
          ),
          Icon(
            Icons.money_outlined,
            size: 30,
            color: Colors.black,
          ),
          Icon(
            Icons.movie_edit,
            size: 30,
            color: Colors.black,
          ),
          Icon(
            Icons.perm_identity,
            size: 30,
            color: Colors.black,
          ),
        ],
        color: MyColors.bottomNavColor,
        buttonBackgroundColor: MyColors.ourPrimary,
        backgroundColor: MyColors.appBackGround,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 300),
        onTap: (index) {
          setState(() {
            _page = index;
            print(_page);
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}
