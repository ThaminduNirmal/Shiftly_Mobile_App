import '/components/record_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dashboard_widget.dart' show DashboardWidget;
import 'package:flutter/material.dart';
import '../services/timesheet_service.dart';

class DashboardModel extends FlutterFlowModel<DashboardWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // Week data
  List<DateTime> weekDays = [];
  List<List<Map<String, dynamic>>> weekTimesheets = [];
  List<double> weekTotalHours = [];
  List<double> weekOvertimeHours = [];
  bool isLoading = true;

  // Model for record components (one for each day)
  late RecordModel recordModel1;
  late RecordModel recordModel2;
  late RecordModel recordModel3;
  late RecordModel recordModel4;
  late RecordModel recordModel5;
  late RecordModel recordModel6;
  late RecordModel recordModel7;

  @override
  void initState(BuildContext context) {
    recordModel1 = createModel(context, () => RecordModel());
    recordModel2 = createModel(context, () => RecordModel());
    recordModel3 = createModel(context, () => RecordModel());
    recordModel4 = createModel(context, () => RecordModel());
    recordModel5 = createModel(context, () => RecordModel());
    recordModel6 = createModel(context, () => RecordModel());
    recordModel7 = createModel(context, () => RecordModel());
    
    _initializeWeek();
    _loadWeekData();
  }

  void refreshData() {
    _loadWeekData();
  }

  void _initializeWeek() {
    final now = DateTime.now();
    final monday = now.subtract(Duration(days: now.weekday - 1));
    
    weekDays = List.generate(7, (index) => monday.add(Duration(days: index)));
    weekTimesheets = List.generate(7, (index) => []);
    weekTotalHours = List.generate(7, (index) => 0.0);
    weekOvertimeHours = List.generate(7, (index) => 0.0);
  }

  Future<void> _loadWeekData() async {
    try {
      isLoading = true;
      
      final timesheetService = TimesheetService();
      final startDate = _formatDate(weekDays.first);
      final endDate = _formatDate(weekDays.last);
      
      final weekData = await timesheetService.getTimesheetsForWeek(startDate, endDate);
      
      // Group timesheets by date
      for (int i = 0; i < weekDays.length; i++) {
        final date = _formatDate(weekDays[i]);
        final dayTimesheets = weekData.where((ts) => ts['date'] == date).toList();
        
        weekTimesheets[i] = dayTimesheets;
        
        // Calculate total hours for the day
        double totalHours = 0.0;
        for (final timesheet in dayTimesheets) {
          totalHours += (timesheet['hours'] as num).toDouble();
        }
        
        weekTotalHours[i] = totalHours;
        
        // Calculate overtime (hours > 8)
        weekOvertimeHours[i] = totalHours > 8.0 ? totalHours - 8.0 : 0.0;
      }
    } catch (e) {
      // Error loading week data - could be logged to a proper logging service
      debugPrint('Error loading week data: $e');
    } finally {
      isLoading = false;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  String getWeekTitle() {
    if (weekDays.isEmpty) return '';
    final start = weekDays.first;
    final end = weekDays.last;
    final month = _getMonthName(start.month);
    return '${start.day}${_getDaySuffix(start.day)} - ${end.day}${_getDaySuffix(end.day)} $month ${start.year}';
  }

  String _getMonthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }

  String _getDaySuffix(int day) {
    if (day >= 11 && day <= 13) return 'th';
    switch (day % 10) {
      case 1: return 'st';
      case 2: return 'nd';
      case 3: return 'rd';
      default: return 'th';
    }
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    recordModel1.dispose();
    recordModel2.dispose();
    recordModel3.dispose();
    recordModel4.dispose();
    recordModel5.dispose();
    recordModel6.dispose();
    recordModel7.dispose();
  }
}
