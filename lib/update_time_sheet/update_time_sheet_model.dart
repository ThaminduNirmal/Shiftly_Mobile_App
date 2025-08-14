import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'update_time_sheet_widget.dart' show UpdateTimeSheetWidget;
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../services/employee_service.dart';
import '../services/timesheet_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateTimeSheetModel extends FlutterFlowModel<UpdateTimeSheetWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for DateText widget.
  FocusNode? dateTextFocusNode;
  TextEditingController? dateTextTextController;
  late MaskTextInputFormatter dateTextMask;
  String? Function(BuildContext, String?)? dateTextTextControllerValidator;
  DateTime? datePicked;
  // Removed project selection
  // State field(s) for ActivityDes widget.
  FocusNode? activityDesFocusNode;
  TextEditingController? activityDesTextController;
  String? Function(BuildContext, String?)? activityDesTextControllerValidator;
  // State field(s) for WorkMode widget.
  FormFieldController<List<String>>? workModeValueController;
  String? get workModeValue => workModeValueController?.value?.firstOrNull;
  set workModeValue(String? val) =>
      workModeValueController?.value = val != null ? [val] : [];
  // State field(s) for TimeHours widget.
  FocusNode? timeHoursFocusNode;
  TextEditingController? timeHoursTextController;
  String? Function(BuildContext, String?)? timeHoursTextControllerValidator;
  // State field(s) for TimeMinutes widget.
  FocusNode? timeMinutesFocusNode;
  TextEditingController? timeMinutesTextController;
  String? Function(BuildContext, String?)? timeMinutesTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    dateTextFocusNode?.dispose();
    dateTextTextController?.dispose();

    activityDesFocusNode?.dispose();
    activityDesTextController?.dispose();

    timeHoursFocusNode?.dispose();
    timeHoursTextController?.dispose();

    timeMinutesFocusNode?.dispose();
    timeMinutesTextController?.dispose();
  }

  /// Action blocks.
  Future submit(BuildContext context) async {
    // Validate minimal fields
    final hours = int.tryParse(timeHoursTextController?.text.trim() ?? '0') ?? 0;
    final minutes = int.tryParse(timeMinutesTextController?.text.trim() ?? '0') ?? 0;
    final double doubleHours = hours + (minutes.clamp(0, 59) / 100.0);
    if (datePicked == null || (activityDesTextController?.text.trim().isEmpty ?? true)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill required fields')),
      );
      return;
    }
    if (doubleHours <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter time worked')),
      );
      return;
    }
    // Show confirm snackbar with action
    final messenger = ScaffoldMessenger.of(context);
    final confirmed = await messenger
        .showSnackBar(
          SnackBar(
            content: const Text('Submit timesheet?'),
            action: SnackBarAction(label: 'Submit', onPressed: () {}),
            duration: const Duration(seconds: 3),
          ),
        )
        .closed;
    if (confirmed != SnackBarClosedReason.action) return;

    // Map mode to backend expected string
    final modeText = workModeValue == 'On-site' ? 'OFFICE' : 'ONLINE';
    // Format date yyyy-MM-dd
    final d = datePicked!;
    final dateStr = '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

    try {
      // fetch employee id and submit via services
      final employeeService = EmployeeService();
      final timesheetService = TimesheetService();
      // Prefer employeeId saved at login from debug fetch; fallback to service resolution
      final prefs = await SharedPreferences.getInstance();
      int? employeeId = prefs.getInt('employee_id');
      employeeId ??= await employeeService.fetchMyEmployeeId();
      if (employeeId == null) {
        messenger.showSnackBar(const SnackBar(content: Text('Unable to resolve employee ID')));
        return;
      }
      final ok = await timesheetService.createTimesheet(
        employeeId: employeeId,
        date: dateStr,
        mode: modeText,
        activity: activityDesTextController!.text.trim(),
        hours: doubleHours,
      );
      if (ok) {
        messenger.showSnackBar(const SnackBar(content: Text('Timesheet submitted')));
      } else {
        messenger.showSnackBar(const SnackBar(content: Text('Submission failed')));
      }
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }
}
