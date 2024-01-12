import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vikn/model/salesitem.dart';

class DataListingProvider extends ChangeNotifier {

  Future<List<SaleItem>> getData() async {
  final SharedPreferences sharedPref = await SharedPreferences.getInstance();
  final String? token = sharedPref.getString('access');

  const apiUrl = 'https://www.api.viknbooks.com/api/v10/sales/sale-list-page/';

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        "BranchID": 1,
        "CompanyID": "1901b825-fe6f-418d-b5f0-7223d0040d08",
        "CreatedUserID": 62,
        "PriceRounding": 3,
        "page_no": 1,
        "items_per_page": 10,
        "type": "Sales",
        "WarehouseID": 1
      }),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      final List<SaleItem> saleItems = data.map((item) => SaleItem.fromJson(item)).toList();

      return saleItems;
    } else {
      print('Failed to fetch data: ${response.statusCode}');
      throw Exception('Failed to fetch data: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
    throw Exception('Error: $e');
  }
}

}
