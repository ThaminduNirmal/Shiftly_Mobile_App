import '/components/record_widget.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'dashboard_model.dart';
export 'dashboard_model.dart';

/// Home page
class DashboardWidget extends StatefulWidget {
  const DashboardWidget({super.key});

  static String routeName = 'Dashboard';
  static String routePath = '/dashboard';

  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget>
    with TickerProviderStateMixin {
  late DashboardModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DashboardModel());

    _model.tabBarController = TabController(
      vsync: this,
      length: 7,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Widget _buildDayContent(BuildContext context, int dayIndex) {
    final dayTimesheets = _model.weekTimesheets[dayIndex];
    final totalHours = _model.weekTotalHours[dayIndex];
    final overtimeHours = _model.weekOvertimeHours[dayIndex];

    return Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      return SingleChildScrollView(
                                        physics: const BouncingScrollPhysics(),
                                        child: ConstrainedBox(
                                          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Column(
                                            mainAxisSize: MainAxisSize.min,
            children: [
                                        Align(
                  alignment: const AlignmentDirectional(-1.0, 0.0),
                  child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 6.0, 0.0, 0.0),
                                              child: Text(
                                                'Timesheet Record',
                    style: FlutterFlowTheme.of(context).titleLarge.override(
                          fontFamily: FlutterFlowTheme.of(context).titleLargeFamily,
                                                          letterSpacing: 0.0,
                          useGoogleFonts: !FlutterFlowTheme.of(context).titleLargeIsCustom,
                                                        ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 70.0),
                child: dayTimesheets.isEmpty
                    ? Center(
                        child: Text(
                          'No timesheets for this day',
                          style: FlutterFlowTheme.of(context).bodyMedium,
                        ),
                      )
                                                : ListView(
                                                    shrinkWrap: true,
                                                    physics: const NeverScrollableScrollPhysics(),
                        children: dayTimesheets.map((timesheet) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: RecordWidget(
                              activity: timesheet['activity'] ?? 'No Activity',
                              mode: timesheet['mode'] ?? 'Unknown',
                              hours: (timesheet['hours'] as num?)?.toDouble() ?? 0.0,
                            ),
                          );
                        }).toList(),
                      ),
                                        ),
            // Total Hours Worked Card
                                                                Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
                                          child: Material(
                                            color: Colors.transparent,
                                            elevation: 3.0,
                                            shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                                            ),
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                                boxShadow: const [
                                                  BoxShadow(
                                                    blurRadius: 4.0,
                                                    color: Color(0x1F000000),
                        offset: Offset(0.0, 2.0),
                                                  )
                                                ],
                    borderRadius: BorderRadius.circular(8.0),
                                                border: Border.all(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                                                  width: 1.0,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 4.0),
                                                      child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 12.0, 12.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                                            Align(
                                        alignment: const AlignmentDirectional(-1.0, 0.0),
                                              child: Text(
                                                                      'Total Hours Worked',
                                          style: FlutterFlowTheme.of(context).titleLarge.override(
                                                fontFamily: FlutterFlowTheme.of(context).titleLargeFamily,
                                                          letterSpacing: 0.0,
                                                useGoogleFonts: !FlutterFlowTheme.of(context).titleLargeIsCustom,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                                                  child: Text(
                                                                    'Total working hours of the day.',
                                        style: FlutterFlowTheme.of(context).labelMedium.override(
                                              fontFamily: FlutterFlowTheme.of(context).labelMediumFamily,
                                              letterSpacing: 0.0,
                                              useGoogleFonts: !FlutterFlowTheme.of(context).labelMediumIsCustom,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 60.0,
                                                            height: 60.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).primaryBackground,
                                  shape: BoxShape.circle,
                                                            ),
                                                            child: Align(
                                  alignment: const AlignmentDirectional(0.0, 0.0),
                                                              child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                                                child: Text(
                                      '${totalHours.toStringAsFixed(1)}Hr',
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                            fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                            fontSize: 15.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                            useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
            // Overtime Card
                                        Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
                                          child: Material(
                                            color: Colors.transparent,
                                            elevation: 3.0,
                                            shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                                            ),
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                                boxShadow: const [
                                                  BoxShadow(
                                                    blurRadius: 4.0,
                                                    color: Color(0x1F000000),
                        offset: Offset(0.0, 2.0),
                                                  )
                                                ],
                    borderRadius: BorderRadius.circular(8.0),
                                                border: Border.all(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                                                  width: 1.0,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 4.0),
                                                      child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 12.0, 12.0),
                                                            child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(
                                                                  'Over Time',
                                      style: FlutterFlowTheme.of(context).titleLarge.override(
                                            fontFamily: FlutterFlowTheme.of(context).titleLargeFamily,
                                            letterSpacing: 0.0,
                                            useGoogleFonts: !FlutterFlowTheme.of(context).titleLargeIsCustom,
                                                                      ),
                                                                ),
                                                                Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                                                  child: Text(
                                        'Overtime calculated for the day',
                                        style: FlutterFlowTheme.of(context).labelMedium.override(
                                              fontFamily: FlutterFlowTheme.of(context).labelMediumFamily,
                                                          letterSpacing: 0.0,
                                              useGoogleFonts: !FlutterFlowTheme.of(context).labelMediumIsCustom,
                                                        ),
                                              ),
                                            ),
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 60.0,
                                                            height: 60.0,
                                              decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).primaryBackground,
                                  shape: BoxShape.circle,
                                                            ),
                                                            child: Align(
                                  alignment: const AlignmentDirectional(0.0, 0.0),
                                                              child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                                                child: Text(
                                      overtimeHours > 0 ? '${overtimeHours.toStringAsFixed(1)}Hr' : '0Hr',
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                            fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                            fontSize: 15.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                            useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                            const SizedBox(height: 16.0),
                                      ],
                                    ),
                                  ),
                                      );
                                    },
                                  ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: AppBar(
            backgroundColor: const Color(0xFFE80A4D),
            automaticallyImplyLeading: false,
            actions: const [],
            flexibleSpace: FlexibleSpaceBar(
              title: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                                              child: Text(
                  'Welcome Back!',
                  style: FlutterFlowTheme.of(context).headlineMedium.override(
                                                          fontFamily:
                            FlutterFlowTheme.of(context).headlineMediumFamily,
                        color: FlutterFlowTheme.of(context).secondary,
                                                          letterSpacing: 0.0,
                        useGoogleFonts: !FlutterFlowTheme.of(context)
                            .headlineMediumIsCustom,
                                                        ),
                                              ),
                                            ),
              centerTitle: false,
              expandedTitleScale: 1.0,
            ),
          ),
        ),
        body: SafeArea(
          top: true,
                                                child: Column(
            mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                          Container(
                                              width: double.infinity,
                height: 45.73,
                                              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      FlutterFlowTheme.of(context).primary,
                      FlutterFlowTheme.of(context).secondary
                    ],
                    stops: const [0.0, 1.0],
                    begin: const AlignmentDirectional(0.0, -1.0),
                    end: const AlignmentDirectional(0, 1.0),
                  ),
                                                            ),
                                                            child: Align(
                  alignment: const AlignmentDirectional(-1.0, 0.0),
                                                              child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                                                                child: Text(
                      _model.getWeekTitle(),
                      style: FlutterFlowTheme.of(context).titleSmall.override(
                                                                        fontFamily:
                                FlutterFlowTheme.of(context).titleSmallFamily,
                            color: const Color(0xB3FFFFFF),
                                                          letterSpacing: 0.0,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .titleSmallIsCustom,
                                                        ),
                                              ),
                                            ),
                                          ),
                                        ),
                                                                Expanded(
                                            child: Container(
                                              width: double.infinity,
                  height: 600.0,
                                              decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                            ),
                                                            child: Align(
                    alignment: const AlignmentDirectional(0.0, 0.0),
                                    child: Column(
                                      children: [
                        Align(
                          alignment: const Alignment(-1.0, 0),
                          child: FlutterFlowButtonTabBar(
                            useToggleButtonStyle: false,
                            isScrollable: true,
                            labelStyle: FlutterFlowTheme.of(context)
                                .titleMedium
                                                        .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .titleMediumFamily,
                                                          letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .titleMediumIsCustom,
                                ),
                            unselectedLabelStyle: FlutterFlowTheme.of(context)
                                .titleMedium
                                                                          .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .titleMediumFamily,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .titleMediumIsCustom,
                                ),
                            labelColor:
                                FlutterFlowTheme.of(context).secondaryText,
                            unselectedLabelColor:
                                FlutterFlowTheme.of(context).secondaryText,
                            backgroundColor:
                                FlutterFlowTheme.of(context).primary,
                            unselectedBackgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                            borderColor: FlutterFlowTheme.of(context).tertiary,
                            borderWidth: 2.0,
                            borderRadius: 10.0,
                                            elevation: 3.0,
                            labelPadding: const EdgeInsetsDirectional.fromSTEB(
                                10.0, 0.0, 0.0, 35.0),
                            buttonMargin: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 8.0, 0.0),
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                10.0, 5.0, 0.0, 0.0),
                            tabs: _model.weekDays.map((date) {
                              final dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                              final dayIndex = date.weekday - 1;
                              return Tab(
                                text: '${dayNames[dayIndex]}   \n  ${date.day}',
                              );
                            }).toList(),
                            controller: _model.tabBarController,
                            onTap: (i) async {
                              // Handle tab tap if needed
                            },
                          ),
                        ),
                                                                Expanded(
            child: _model.isLoading
                ? const Center(child: CircularProgressIndicator())
                : TabBarView(
                                  controller: _model.tabBarController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: List.generate(7, (dayIndex) {
                      return _buildDayContent(context, dayIndex);
                    }),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
