import 'package:flutter/material.dart';
import 'package:flutter_finance/components/constant.dart';
import 'package:flutter_finance/router/named_routes.dart';
import 'package:flutter_finance/services/auth_services.dart';
import 'package:flutter_finance/widgets/input_text_container.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final AuthService _authService = AuthService();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  void _signup() async {
    setState(() {
      _isLoading = true;
    });

    String email = _emailController.text;
    String username = _usernameController.text;
    String password = _passwordController.text;

    final result = await _authService.signUp(email, username, password);

    setState(() {
      _isLoading = false; 
    });

    if (result['success']) {
         SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true); 
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign-up successful!')),
      );

      GoRouter.of(context).pushNamed(UserRoutes.personalInfo);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'] ?? 'Sign-up failed')),
      );
    }
  }

  @override
  void initState() {
    _emailController = TextEditingController();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * 0.1,
              ),
              SizedBox(
                height: screenHeight * 0.35,
                width: double.infinity,
                child: Image.asset(
                  "assets/images/ACADEMICVERSE.png",
                  fit: BoxFit.fitHeight,
                ),
              ),
              InputTextContainer(
                con: _emailController,
                label: "College ID",
              ),
              const SizedBox(height: 10),
              InputTextContainer(
                con: _usernameController,
                label: "Username",
              ),
              const SizedBox(height: 10),
              InputTextContainer(
                con: _passwordController,
                label: "Password",
                isPassword: true,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 24.0),
                    child: Text(
                      "Forgot Password?",
                      style: GoogleFonts.aBeeZee(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  _signup();
                  // GoRouter.of(context).pushNamed(StudentsRoutes.studentSetup);
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                      color: MyColors.ourPrimary,
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Sign Up",
                          style: GoogleFonts.aBeeZee(
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
