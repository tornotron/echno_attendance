import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

const echnoMapView = "EchnoMapView";

class EchnoMapView extends StatefulWidget {
  const EchnoMapView({super.key});

  @override
  State<EchnoMapView> createState() => _EchnoMapViewState();
}

class _EchnoMapViewState extends State<EchnoMapView> {
  final channel = const MethodChannel('echnoMapView');
  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? AndroidView(
            viewType: echnoMapView,
            layoutDirection: TextDirection.ltr,
            creationParams: null,
            creationParamsCodec: const StandardMessageCodec(),
            onPlatformViewCreated: _onPlatformViewCreated,
          )
        : UiKitView(
            viewType: echnoMapView,
            layoutDirection: TextDirection.ltr,
            creationParams: null,
            creationParamsCodec: const StandardMessageCodec(),
            onPlatformViewCreated: _onPlatformViewCreated,
          );
  }

  void _onPlatformViewCreated(int id) {
    channel.setMethodCallHandler(_handleMethod);
  }

  Future<dynamic> _handleMethod(MethodCall call) async {
    switch (call.method) {
      case "sendFromNative":
        String text = call.arguments as String;
        debugPrint("Received from native: $text");
    }
  }
}
