import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A utility class containing various helper functions for device-related tasks in the applications.
class DeviceUtilityHelpers {
  /// Hides the keyboard.
  ///
  /// The [context] parameter is required to retrieve the focus scope.
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  /// Sets the color of the status bar.
  static Future<void> setStatusBarColor(Color color) async {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: color),
    );
  }

  /// Checks if the device is in landscape orientation.
  ///
  /// The [context] parameter is required to retrieve the MediaQuery's context.
  static bool isLandscapeOrientation(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets;
    return viewInsets.bottom == 0;
  }

  /// Checks if the device is in portrait orientation.
  ///
  /// The [context] parameter is required to retrieve the MediaQuery's context.
  static bool isPortraitOrientation(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets;
    return viewInsets.bottom != 0;
  }

  /// Sets the app to full-screen mode.
  static void setFullScreen(bool enable) {
    SystemChrome.setEnabledSystemUIMode(
        enable ? SystemUiMode.immersiveSticky : SystemUiMode.edgeToEdge);
  }

  /// Retrieves the screen height.
  ///
  /// The [context] parameter is required to retrieve the MediaQuery's context.
  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /// Retrieves the screen width.
  ///
  /// The [context] parameter is required to retrieve the MediaQuery's context.
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// Retrieves the device pixel ratio.
  ///
  /// The [context] parameter is required to retrieve the MediaQuery's context.
  static double getPixelRatio(BuildContext context) {
    return MediaQuery.of(context).devicePixelRatio;
  }

  /// Retrieves the height of the status bar.
  ///
  /// The [context] parameter is required to retrieve the MediaQuery's context.
  static double getStatusBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  /// Retrieves the height of the bottom navigation bar.
  static double getBottomNavigationBarHeight() {
    return kBottomNavigationBarHeight;
  }

  /// Retrieves the height of the app bar.
  static double getAppBarHeight() {
    return kToolbarHeight;
  }

  /// Retrieves the height of the keyboard.
  ///
  /// The [context] parameter is required to retrieve the MediaQuery's context.
  static double getKeyboardHeight(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets;
    return viewInsets.bottom;
  }

  /// Checks if the keyboard is currently visible.
  ///
  /// The [context] parameter is required to retrieve the MediaQuery's context.
  static Future<bool> isKeyboardVisible(BuildContext context) async {
    final viewInsets = MediaQuery.of(context).viewInsets;
    return viewInsets.bottom > 0;
  }

  /// Checks if the app is running on a physical device.
  static Future<bool> isPhysicalDevice() async {
    return Platform.isAndroid || Platform.isIOS;
  }

  /// Triggers device vibration for a specified duration.
  static void vibrate(Duration duration) {
    HapticFeedback.vibrate();
    Future.delayed(duration, () => HapticFeedback.vibrate());
  }

  /// Sets preferred screen orientations.
  static Future<void> setPreferredOrientations(
      List<DeviceOrientation> orientations) async {
    await SystemChrome.setPreferredOrientations(orientations);
  }

  /// Hides the status bar.
  static void hideStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  /// Shows the status bar.
  static void showStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  /// Checks for internet connectivity.
  static Future<bool> hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  /// Checks if the app is running on iOS.
  static bool isIOS() {
    return Platform.isIOS;
  }

  /// Checks if the app is running on Android.
  static bool isAndroid() {
    return Platform.isAndroid;
  }
}
