import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'profilefrme_model.dart';
export 'profilefrme_model.dart';

/// Create a round profile picture frame
///
class ProfilefrmeWidget extends StatefulWidget {
  const ProfilefrmeWidget({super.key});

  @override
  State<ProfilefrmeWidget> createState() => _ProfilefrmeWidgetState();
}

class _ProfilefrmeWidgetState extends State<ProfilefrmeWidget> {
  late ProfilefrmeModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfilefrmeModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.0,
      height: 120.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(60.0),
        border: Border.all(
          color: FlutterFlowTheme.of(context).primary,
          width: 3.0,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(57.0),
        child: Image.network(
          'https://images.unsplash.com/photo-1492633423870-43d1cd2775eb?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NTMzNDk3OTV8&ixlib=rb-4.1.0&q=80&w=1080',
          width: 0.0,
          height: 0.0,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
