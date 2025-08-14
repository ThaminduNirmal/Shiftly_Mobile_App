import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_client.dart';

class EmployeeService {
  final ApiClient _client = ApiClient();

  Future<int?> fetchMyEmployeeId() async {
    // Try preferred endpoint using userId → employee record
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString('userDTO');
      if (raw != null) {
        final user = jsonDecode(raw) as Map<String, dynamic>;
        final int? userId = (user['id'] ?? user['userId']) as int?;
        if (userId != null) {
          final res = await _client.get('/api/v1/shiftly/ems/employee/$userId');
          if (res.statusCode == 200) {
            final map = jsonDecode(res.body) as Map<String, dynamic>;
            final eid = map['employeeId'] as int?;
            if (eid != null) return eid;
          }
        }
      }
    } catch (_) {
      // fall back below
    }
    // Fallback to profile endpoint if available
    final res = await _client.get('/api/v1/shiftly/ems/employee/profile');
    if (res.statusCode == 200) {
      final map = jsonDecode(res.body) as Map<String, dynamic>;
      return map['employeeId'] as int?;
    }
    return null;
  }

  Future<Map<String, dynamic>?> fetchMyEmployeeProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('userDTO');
    if (raw == null) return null;
    final user = jsonDecode(raw) as Map<String, dynamic>;
    final int? userId = (user['id'] ?? user['userId']) as int?;
    if (userId == null) return null;
    final res = await _client.get('/api/v1/shiftly/ems/employee/$userId');
    if (res.statusCode == 200) {
      return jsonDecode(res.body) as Map<String, dynamic>;
    }
    return null;
  }
}

