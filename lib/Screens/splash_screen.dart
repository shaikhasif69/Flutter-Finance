import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_finance/router/named_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    myFucntion();
  }

  void myFucntion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    
    Future.delayed(const Duration(seconds: 7), () {
      _controller.forward().then((value) {
        GoRouter.of(context).pushReplacement(CommonRoutes.onBoardScreen);
        if (isLoggedIn) {
            GoRouter.of(context).pushReplacement(UserRoutes.homeScreen);
         
        }
        else{
            GoRouter.of(context).pushReplacement(CommonRoutes.onBoardScreen);
        }
      });
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return FadeTransition(
      opacity: _controller,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/Group 15.png',
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: SizedBox(
                width: screenWidth * 2.6,
                height: screenHeight * 2.6,
                child: LottieBuilder.asset(
                  'assets/Lotty/Animation - 1726336236576.json',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
