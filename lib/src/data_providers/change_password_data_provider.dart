import 'dart:convert';
import 'dart:io';

import 'package:cinema_ticketer/src/config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ChangePasswordDataProvider {
  Future changePassword(String oldPassword, String newPassword) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final jsonData = preferences.getString(STORAGE_KEY);
    final credential = jsonDecode(jsonData);
    final response = await http.patch(
      Uri.parse('$BASE_URL/password'),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: credential["token"],
      },
      body: jsonEncode(
        {
          "oldPassword": oldPassword,
          "newPassword": newPassword,
        },
      ),
    );
    if (response.statusCode != 200)
      throw Exception("changing password failed!");
    return;
  }
}
