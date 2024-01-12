import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vikn/core/color.dart';
import 'package:vikn/views/home/homescreen.dart';
import 'package:vikn/views/login/auth_page.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  late bool isLogin;
  @override
  void initState() {
    super.initState();

    checkLoginStatus();

    // Navigator.of(context).push(MaterialPageRoute(
    //   builder: (context) => const ProfileSelecting(),
    // ));
  }

  checkLoginStatus() async {
    final SharedPreferences sharedPrefer =
        await SharedPreferences.getInstance();
    isLogin = sharedPrefer.containsKey('access');

    await Future.delayed(const Duration(seconds: 4));
    if (isLogin) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ));
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => AuthPage(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: kWhiteColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ClipRRect(
                child: Lottie.asset(
                  'assets/Animation.json',
                  width: 270,
                ),
              ),
            ),
            const SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                strokeWidth: 4,
                color: Color.fromARGB(255, 232, 15, 0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
