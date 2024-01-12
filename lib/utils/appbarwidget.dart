import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vikn/core/color.dart';
import 'package:vikn/services/auth.dart';
import 'package:vikn/views/login/auth_page.dart';

class AppbarWidget extends StatelessWidget {
  final String title;

  const AppbarWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firstLetter = title.isNotEmpty ? title[0] : '';
    final restOfTitle = title.substring(1);

    return AppBar(
      centerTitle: true,
      backgroundColor: kWhiteColor,
      // leading: IconButton(
      //   onPressed: () {
      //     Get.back();
      //   },
      //   icon: const Icon(
      //     Icons.arrow_back,
      //     color: backgroundcolor,
      //   ),
      // ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
                text: firstLetter,
                style: GoogleFonts.robotoSlab(
                  textStyle: const TextStyle(
                    color: Color.fromARGB(255, 123, 54, 226),
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    letterSpacing: 4,
                  ),
                ),
                children: [
                  TextSpan(
                    text: restOfTitle,
                    style: GoogleFonts.robotoSlab(
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: backgroundcolor),
                    ),
                  ),
                ]),
          ),
        ],
      ),
      actions: [
        IconButton(
            onPressed: () {
              showLogoutDialog(context);
            },
            icon: const Icon(
              Icons.logout,
              size: 25,
              color: Colors.black,
            ))
      ],
    );
  }

  Future<void> showLogoutDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout Confirmation'),
          content: const Text('Are you sure you want to log out?'),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          actionsPadding: const EdgeInsets.symmetric(horizontal: 16),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Logout'),
              onPressed: () {
                final audioPlayerProvider =
                    Provider.of<AuthProvider>(context, listen: false);
                audioPlayerProvider.logOut();

                Navigator.of(context).pop();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const AuthPage(),
                    ),
                    (route) => false);
              },
            ),
          ],
        );
      },
    );
  }
}
