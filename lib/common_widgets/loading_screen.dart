import 'dart:async';

import 'package:echno_attendance/constants/colors.dart';
import 'package:echno_attendance/utilities/loading_screen_controller.dart';
import 'package:flutter/material.dart';

class LoadingScreen {
  factory LoadingScreen() => _shared;
  static final LoadingScreen _shared = LoadingScreen._sharedInstance();
  LoadingScreen._sharedInstance();

  LoadingScreenController? controller;

  void show({
    required BuildContext context,
    required String text,
  }) {
    if (controller?.update(text) ?? false) {
      return;
    } else {
      controller = showOverlay(
        context: context,
        text: text,
      );
    }
  }

  void hide() {
    controller?.close();
    controller = null;
  }

  LoadingScreenController showOverlay({
    required BuildContext context,
    required String text,
  }) {
    final streamText = StreamController<String>();
    streamText.add(text);

    final state = Overlay.of(context);
    // final renderBox = context.findRenderObject() as RenderBox;
    // final size = renderBox.size;

    final overlay = OverlayEntry(
      builder: (context) {
        bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
        return Material(
          color: EchnoColors.black.withOpacity(0.5),
          child: Center(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  constraints: BoxConstraints(
                    maxWidth: constraints.maxWidth * 0.8,
                    maxHeight: constraints.maxHeight * 0.8,
                    minWidth: constraints.minWidth * 0.5,
                  ),
                  decoration: BoxDecoration(
                    color: isDarkMode ? EchnoColors.grey : EchnoColors.white,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 10),
                          const LinearProgressIndicator(),
                          const SizedBox(height: 20),
                          StreamBuilder(
                            stream: streamText.stream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  snapshot.data as String,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  textAlign: TextAlign.center,
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );

    state.insert(overlay);

    return LoadingScreenController(
      close: () {
        streamText.close();
        overlay.remove();
        return true;
      },
      update: (text) {
        streamText.add(text);
        return true;
      },
    );
  }
}
