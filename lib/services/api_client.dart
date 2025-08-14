import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'api_config.dart';

class ApiClient {
  static const String _tokenKey = 'auth_token';

  Future<Map<String, String>> _authHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);
    return {
      'Content-Type': 'application/json',
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
  }

  Future<http.Response> get(String path) async {
    final headers = await _authHeaders();
    final uri = Uri.parse('${ApiConfig.baseUrl}$path');
    return http.get(uri, headers: headers);
  }

  Future<http.Response> post(String path, Map<String, dynamic> body) async {
    final headers = await _authHeaders();
    final uri = Uri.parse('${ApiConfig.baseUrl}$path');
    return http.post(uri, headers: headers, body: jsonEncode(body));
  }
}

