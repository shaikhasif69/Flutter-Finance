import 'package:flutter_finance/Screens/News/news_homepage.dart';
import 'package:flutter_finance/Screens/On_Board/on_boarding.dart';
import 'package:flutter_finance/Screens/Personal_Info/personal_info.dart';
import 'package:flutter_finance/Screens/add_new_investment.dart';
import 'package:flutter_finance/Screens/ask_loginPage.dart';
import 'package:flutter_finance/Screens/home_screen.dart';
import 'package:flutter_finance/Screens/investment_page.dart';
import 'package:flutter_finance/Screens/login_screen.dart';
import 'package:flutter_finance/Screens/quiz.dart';
import 'package:flutter_finance/Screens/signup.dart';
import 'package:flutter_finance/Screens/splash_screen.dart';
import 'package:flutter_finance/router/named_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class MyGoRouter {
  final GoRouter router =
      GoRouter(initialLocation: CommonRoutes.splashScreen, routes: [
    GoRoute(
      path: CommonRoutes.splashScreen,
      name: CommonRoutes.splashScreen,
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: CommonRoutes.onBoardScreen,
      name: CommonRoutes.onBoardScreen,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: const on_boarding(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Fade transition
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: UserRoutes.personalInfo,
      name: UserRoutes.personalInfo,
      builder: (context, state) => PersonalInfo(),
    ),
    GoRoute(
      path: UserRoutes.askLoginScreen,
      name: UserRoutes.askLoginScreen,
      builder: (context, state) => AskLoginpage(),
    ),
    GoRoute(
      path: UserRoutes.quiz,
      name: UserRoutes.quiz,
      builder: (context, state) => Quiz(),
    ),
    GoRoute(
      path: UserRoutes.login,
      name: UserRoutes.login,
      builder: (context, state) => UserLogin(),
    ),
    GoRoute(
      path: UserRoutes.signUp,
      name: UserRoutes.signUp,
      builder: (context, state) => SignUpPage(),
    ),
    GoRoute(
      path: UserRoutes.homeScreen,
      name: UserRoutes.homeScreen,
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: UserRoutes.addNewInvestment,
      name: UserRoutes.addNewInvestment,
      builder: (context, state) => AddNewInvestment(),
    ),
    GoRoute(
      path: UserRoutes.newsHomePage,
      name: UserRoutes.newsHomePage,
      builder: (context, state) => NewsHomePage(),
    ),
  ]);
}
