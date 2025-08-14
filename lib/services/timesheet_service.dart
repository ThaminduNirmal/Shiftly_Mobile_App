import 'dart:convert';
import 'employee_service.dart';
import 'api_client.dart';

class TimesheetService {
  final ApiClient _apiClient = ApiClient();

  // Wrapper used by UpdateTimeSheetModel.submit
  Future<bool> createTimesheet({
    required int employeeId,
    required String date, // yyyy-MM-dd
    required String mode,
    required String activity,
    required double hours,
  }) async {
    final payload = {
      'date': date,
      'mode': mode,
      'activity': activity,
      'hours': hours,
    };
    final response = await _apiClient.post(
      '/api/v1/shiftly/ems/timesheets/add/$employeeId',
      payload,
    );
    return response.statusCode == 200 || response.statusCode == 201;
  }

  // Existing method used by dashboard fetching code
  Future<Map<String, dynamic>> createTimesheetRaw(int employeeId, Map<String, dynamic> timesheetData) async {
    try {
      final response = await _apiClient.post(
        '/api/v1/shiftly/ems/timesheets/add/$employeeId',
        timesheetData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to create timesheet: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error creating timesheet: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getTimesheetsForDate(String date) async {
    try {
      // Resolve employeeId via employee endpoint using userId
      final employeeId = await EmployeeService().fetchMyEmployeeId();
      if (employeeId == null) {
        throw Exception('Unable to resolve employee ID');
      }

      final response = await _apiClient.get(
        '/api/v1/shiftly/ems/timesheets/employee/$employeeId',
      );

      if (response.statusCode == 200) {
        final List<dynamic> timesheets = json.decode(response.body);

        final filteredTimesheets = timesheets.where((timesheet) {
          return timesheet['date'] == date;
        }).toList();

        return List<Map<String, dynamic>>.from(filteredTimesheets);
      } else {
        throw Exception('Failed to fetch timesheets: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching timesheets: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getTimesheetsForWeek(String startDate, String endDate) async {
    try {
      final employeeId = await EmployeeService().fetchMyEmployeeId();
      if (employeeId == null) {
        throw Exception('Unable to resolve employee ID');
      }

      final response = await _apiClient.get(
        '/api/v1/shiftly/ems/timesheets/employee/$employeeId',
      );

      if (response.statusCode == 200) {
        final List<dynamic> timesheets = json.decode(response.body);

        final filteredTimesheets = timesheets.where((timesheet) {
          final timesheetDate = timesheet['date'];
          return timesheetDate.compareTo(startDate) >= 0 &&
              timesheetDate.compareTo(endDate) <= 0;
        }).toList();

        return List<Map<String, dynamic>>.from(filteredTimesheets);
      } else {
        throw Exception('Failed to fetch timesheets: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching timesheets: $e');
    }
  }

  // Fetch all timesheets for the resolved employee
  Future<List<Map<String, dynamic>>> getAllTimesheetsForMe() async {
    final employeeId = await EmployeeService().fetchMyEmployeeId();
    if (employeeId == null) {
      throw Exception('Unable to resolve employee ID');
    }
    return getAllTimesheetsForEmployee(employeeId);
  }

  // Fetch all timesheets for a given employeeId
  Future<List<Map<String, dynamic>>> getAllTimesheetsForEmployee(int employeeId) async {
    final response = await _apiClient.get('/api/v1/shiftly/ems/timesheets/employee/$employeeId');
    if (response.statusCode == 200) {
      final List<dynamic> list = json.decode(response.body);
      return List<Map<String, dynamic>>.from(list);
    }
    throw Exception('Failed to fetch timesheets: ${response.statusCode}');
  }
}

