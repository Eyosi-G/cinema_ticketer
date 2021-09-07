import 'dart:convert';
import 'dart:io';

import 'package:cinema_ticketer/src/config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ApproveTicketDataProvider {
  Future<String> approveTicket(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final jsonData = preferences.getString(STORAGE_KEY);
    final credential = jsonDecode(jsonData);
    final response = await http.patch(
      Uri.parse('$BASE_URL/tickets/$id/approve'),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: credential["token"],
      },
    );
    return jsonDecode(response.body);
  }
}
