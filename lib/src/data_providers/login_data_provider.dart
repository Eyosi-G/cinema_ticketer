import 'dart:convert';

import 'package:http/http.dart' as http;
import '../config/config.dart';

class LoginDataProvider {
  Future<String> login(String username, String password) async {
    final response = await http.post(
      Uri.parse("$BASE_URL/login"),
      body: jsonEncode(
        {
          "username": username,
          "password": password,
        },
      ),
      headers: {"content-type": "application/json"},
    );
    if (response.statusCode == 200) {
      return response.body;
    }
    throw Exception("login failed!");
  }
}
