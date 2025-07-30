import '/components/record_widget.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'dashboard_widget.dart' show DashboardWidget;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DashboardModel extends FlutterFlowModel<DashboardWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // Model for record component.
  late RecordModel recordModel1;
  // Model for record component.
  late RecordModel recordModel2;
  // Model for record component.
  late RecordModel recordModel3;
  // Model for record component.
  late RecordModel recordModel4;

  @override
  void initState(BuildContext context) {
    recordModel1 = createModel(context, () => RecordModel());
    recordModel2 = createModel(context, () => RecordModel());
    recordModel3 = createModel(context, () => RecordModel());
    recordModel4 = createModel(context, () => RecordModel());
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    recordModel1.dispose();
    recordModel2.dispose();
    recordModel3.dispose();
    recordModel4.dispose();
  }
}
