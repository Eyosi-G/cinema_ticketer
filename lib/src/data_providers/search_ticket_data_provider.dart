import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

import '../config/config.dart';
import '../models/models.dart';
import 'package:http/http.dart' as http;

class SearchTicketDataProvider {
  Future<Map<String, dynamic>> searchTicket(String code) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final jsonData = preferences.getString(STORAGE_KEY);
    final credential = jsonDecode(jsonData);
    final response = await http.post(
      Uri.parse('$BASE_URL/tickets'),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: credential["token"],
      },
      body: jsonEncode({"code": code}),
    );
    return jsonDecode(response.body);
  }
}
