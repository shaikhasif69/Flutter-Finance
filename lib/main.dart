import 'package:flutter/material.dart';
import 'package:flutter_finance/router/router.dart';
import 'package:flutter_finance/services/auth_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main()async { WidgetsFlutterBinding.ensureInitialized();
  await AuthService.getPref();
  runApp( ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() {

    return _MyAppState();}
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // AuthService().fetchAndStoreInvestmentData();
    // FacultyServices.getUserData();
    
  }

  @override
  final MyGoRouter myGoRouter = MyGoRouter();

  Widget build(BuildContext context) {
    
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Flutter App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          routerConfig: myGoRouter.router,
        );
      },
    );
  }
}
