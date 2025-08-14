import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_config.dart';

class AuthService {
  static const String _tokenKey = 'auth_token';
  static const String _userDtoKey = 'userDTO';

  Future<String?> login({required String username, required String password}) async {
    final uri = Uri.parse('${ApiConfig.baseUrl}/api/auth/login');
    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body) as Map<String, dynamic>;
      final token = body['jwttoken'] as String?;
      final userDto = body['userDTO'] as Map<String, dynamic>?;
      final prefs = await SharedPreferences.getInstance();
      if (userDto != null) {
        // Log user id to terminal output
        final dynamic idVal = userDto['id'];
        debugPrint('Logged-in userId: $idVal');
        // Persist raw JSON for downstream services (employeeId resolution)
        await prefs.setString(_userDtoKey, jsonEncode(userDto));
      }
      if (token != null && token.isNotEmpty) {
        await prefs.setString(_tokenKey, token);
        // Immediately resolve Employee record using userId and log employeeId
        try {
          final dynamic idVal = userDto?['id'];
          if (idVal != null) {
            final empUri = Uri.parse('${ApiConfig.baseUrl}/api/v1/shiftly/ems/employee/$idVal');
            final empRes = await http.get(
              empUri,
              headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $token',
              },
            );
            if (empRes.statusCode == 200) {
              final emp = jsonDecode(empRes.body) as Map<String, dynamic>;
              final dynamic eid = emp['employeeId'];
              debugPrint('Resolved employeeId: $eid');
              try {
                final int? eidInt = (eid is int) ? eid : int.tryParse(eid?.toString() ?? '');
                if (eidInt != null) {
                  await prefs.setInt('employee_id', eidInt);
                  // Fetch and log all timesheets for this employee
                  final tsUri = Uri.parse('${ApiConfig.baseUrl}/api/v1/shiftly/ems/timesheets/employee/$eidInt');
                  final tsRes = await http.get(
                    tsUri,
                    headers: {
                      'Content-Type': 'application/json',
                      'Authorization': 'Bearer $token',
                    },
                  );
                  if (tsRes.statusCode == 200) {
                    final list = jsonDecode(tsRes.body) as List<dynamic>;
                    debugPrint('Timesheets(${list.length}) for employeeId $eidInt:');
                    for (final t in list) {
                      debugPrint(t.toString());
                    }
                  } else {
                    debugPrint('Failed to fetch timesheets for employeeId $eidInt: ${tsRes.statusCode}');
                  }
                }
              } catch (_) {}
            } else {
              debugPrint('Failed to fetch employee by userId ($idVal): ${empRes.statusCode}');
            }
          }
        } catch (e) {
          debugPrint('Error resolving employeeId: $e');
        }
        return token;
      }
      return null;
    }

    // Unauthorized or other errors
    return null;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userDtoKey);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }
}

