import 'package:flutter/material.dart';

/// A utility class containing various helper functions for common tasks in the applications.
class EchnoHelperFunctions {
  /// Displays a snackbar with the given [message].
  ///
  /// The [context] parameter is required to retrieve the Scaffold's context.
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  /// Navigates to the specified [screen].
  ///
  /// The [context] parameter is required to retrieve the Navigator's context.
  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  /// Checks if the current theme is in dark mode.
  ///
  /// The [context] parameter is required to retrieve the current theme's context.
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  /// Retrieves the screen size.
  ///
  /// The [context] parameter is required to retrieve the MediaQuery's context.
  static Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  /// Retrieves the screen height.
  ///
  /// The [context] parameter is required to retrieve the MediaQuery's context.
  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /// Retrieves the screen width.
  ///
  /// The [context] parameter is required to retrieve the MediaQuery's context.
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// Removes duplicate elements from the given [list].
  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }

  /// Wraps a list of widgets into rows based on the specified [rowSize].
  ///
  /// Returns a list of widgets where each row contains [rowSize] number of widgets.
  /// If the number of widgets is not divisible evenly by [rowSize], the last row may have fewer widgets.
  static List<Widget> wrapWidgets(List<Widget> widgets, int rowSize) {
    final wrappedList = <Widget>[];
    for (var i = 0; i < widgets.length; i += rowSize) {
      final rowChildren = widgets.sublist(
          i, i + rowSize > widgets.length ? widgets.length : i + rowSize);
      wrappedList.add(Row(children: rowChildren));
    }
    return wrappedList;
  }

  /// Greets the user based on the time of the day.
  ///
  /// Returns a greeting message depending on the time of the day:
  /// - Morning: 5:00 AM to 11:59 AM
  /// - Afternoon: 12:00 PM to 4:59 PM
  /// - Evening: 5:00 PM to 8:59 PM
  /// - Night: 9:00 PM to 4:59 AM
  static String greetEmployeeBasedOnTime() {
    String greeting = '';
    var hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      greeting = 'Good morning!';
    } else if (hour >= 12 && hour < 17) {
      greeting = 'Good afternoon!';
    } else if (hour >= 17 && hour < 21) {
      greeting = 'Good evening!';
    } else {
      greeting = 'Good night!';
    }

    return greeting;
  }
}
