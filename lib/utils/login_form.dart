import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vikn/core/color.dart';
import 'package:vikn/core/config.dart';
import 'package:vikn/services/auth.dart';
import 'package:vikn/utils/button.dart';
import 'package:vikn/views/home/homeScreen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  // final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();
  bool obsecurePass = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Config.spaceBig,
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            cursorColor: Config.primaryColor,
            validator: (value) =>
                value!.isEmpty ? 'Email cannot be empty!' : null,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(10),
              hintText: 'Email Address',
              labelText: 'Email',
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.email_outlined),
              prefixIconColor: Color.fromARGB(255, 3, 3, 101),
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(255, 0, 5, 7)),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
          Config.spaceSmall,
          TextFormField(
            controller: _confirmPassController,
            keyboardType: TextInputType.visiblePassword,
            cursorColor: Config.primaryColor,
            obscureText: obsecurePass,
            validator: (value) =>
                value!.isEmpty ? 'password cannot be empty!' : null,
            decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 0, 5, 7)),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                hintText: 'Password',
                labelText: 'Password',
                alignLabelWithHint: true,
                prefixIcon: const Icon(Icons.lock_outline),
                prefixIconColor: const Color.fromARGB(255, 3, 3, 101),
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obsecurePass = !obsecurePass;
                      });
                    },
                    icon: obsecurePass
                        ? const Icon(
                            Icons.visibility_off_outlined,
                            color: Colors.black38,
                          )
                        : const Icon(
                            Icons.visibility_outlined,
                            color: Config.primaryColor,
                          ))),
          ),
          Config.spaceSmall,
          Consumer<AuthProvider>(
            builder: (context, auth, child) {
              return Button(
                width: double.infinity,
                title: 'Sign In',
                onPressed: () async {
                  //login here
                  FocusScope.of(context).unfocus();
                  SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();
                  if (_formKey.currentState!.validate()) {
                    bool login = await auth.login(
                        _emailController.text, _confirmPassController.text);

                    if (login == true) {
                      Fluttertoast.showToast(
                        msg: 'Welcome ${sharedPreferences.get('displayName')}.',
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.green,
                      );
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                          (route) => false);
                    } else {
                      Fluttertoast.showToast(
                          msg: 'Login failed. Please try again.',
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.black,
                          textColor: colorGrey);
                    }
                  }
                },
                disable: false,
              );
            },
          )
        ],
      ),
    );
  }
}
