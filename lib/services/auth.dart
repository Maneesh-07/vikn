import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  Future<bool> login(String email, String password) async {
    final SharedPreferences sharedPref = await SharedPreferences.getInstance();
    String token = '';

    const apiUrl = 'https://api.accounts.vikncodes.com/api/v1/users/login';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          // 'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'username': email,
          'password': password,
          'is_mobile': true,
        }),
      );

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        token = result["data"]["access"];
        sharedPref.setString("access", token);
        print(token);
        return true;
      } else {
        print('Failed to fetch data: ${response.statusCode}');
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error: $e');
    }
  }


  logOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('access');
  }
}
