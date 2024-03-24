import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A collection of helper functions for common tasks related to Firebase Cloud Storage
/// and Flutter widgets.
class EchnoCloudHelperFunctions {
  /// Checks the state of a single asynchronous snapshot and returns a widget
  /// accordingly.
  ///
  /// Parameters:
  ///   - snapshot: An [AsyncSnapshot] containing data from an asynchronous computation.
  ///
  /// Returns:
  ///   - A widget representing the current state of the snapshot. Returns `null`
  ///     if the snapshot is not in a waiting, error, or no data state.
  ///
  /// If the snapshot's connection state is [ConnectionState.waiting], it returns
  /// a circular progress indicator centered on the screen.
  ///
  /// If the snapshot does not have data ([AsyncSnapshot.hasData] returns `false`)
  /// or if the data is `null`, it returns a centered text widget with the message
  /// "No Data Found!".
  ///
  /// If the snapshot has encountered an error ([AsyncSnapshot.hasError] returns `true`),
  /// it returns a centered text widget with the message "Something went wrong.".
  static Widget? checkSingleRecordState<T>(AsyncSnapshot<T> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }

    if (!snapshot.hasData || snapshot.data == null) {
      return const Center(child: Text('No Data Found!'));
    }

    if (snapshot.hasError) {
      return const Center(child: Text('Something went wrong.'));
    }

    return null;
  }

  /// Checks the state of a list asynchronous snapshot and returns a widget
  /// accordingly.
  ///
  /// Parameters:
  ///   - snapshot: An [AsyncSnapshot] containing a list of data from an asynchronous computation.
  ///   - loader: Optional. A widget to display while data is loading. If not provided, a circular
  ///             progress indicator will be used.
  ///   - error: Optional. A widget to display in case of an error. If not provided, a centered
  ///            text widget with the message "Something went wrong." will be displayed.
  ///   - nothingFound: Optional. A widget to display if the list is empty. If not provided, a
  ///                   centered text widget with the message "No Data Found!" will be displayed.
  ///
  /// Returns:
  ///   - A widget representing the current state of the snapshot. Returns `null`
  ///     if the snapshot is not in a waiting, error, or no data state.
  ///
  /// If the snapshot's connection state is [ConnectionState.waiting], it returns
  /// the provided loader widget or a circular progress indicator centered on the screen.
  ///
  /// If the snapshot does not have data ([AsyncSnapshot.hasData] returns `false`),
  /// if the data is `null`, or if the list is empty, it returns the provided nothingFound
  /// widget or a centered text widget with the message "No Data Found!".
  ///
  /// If the snapshot has encountered an error ([AsyncSnapshot.hasError] returns `true`),
  /// it returns the provided error widget or a centered text widget with the message
  /// "Something went wrong.".
  static Widget? checkMultiRecordState<T>(
      {required AsyncSnapshot<List<T>> snapshot,
      Widget? loader,
      Widget? error,
      Widget? nothingFound}) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      if (loader != null) return loader;
      return const Center(child: CircularProgressIndicator());
    }

    if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
      if (nothingFound != null) return nothingFound;
      return const Center(child: Text('No Data Found!'));
    }

    if (snapshot.hasError) {
      if (error != null) return error;
      return const Center(child: Text('Something went wrong.'));
    }

    return null;
  }

  /// Retrieves the download URL of a file from Firebase Cloud Storage given its file path.
  ///
  /// Parameters:
  ///   - path: The file path in Firebase Cloud Storage.
  ///
  /// Returns:
  ///   - A [Future] that completes with the download URL of the specified file.
  ///
  /// Throws:
  ///   - A [FirebaseException] or [PlatformException] if an error occurs during the process.
  ///   - A generic error message if an unexpected error occurs.
  static Future<String> getURLFromFilePathAndName(String path) async {
    try {
      if (path.isEmpty) return '';
      final ref = FirebaseStorage.instance.ref().child(path);
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      throw e.message!;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw 'Something went wrong.';
    }
  }

  /// Retrieves the download URL of a file from Firebase Cloud Storage given its URL.
  ///
  /// Parameters:
  ///   - url: The URL of the file in Firebase Cloud Storage.
  ///
  /// Returns:
  ///   - A [Future] that completes with the download URL of the specified file.
  ///
  /// Throws:
  ///   - A [FirebaseException] or [PlatformException] if an error occurs during the process.
  ///   - A generic error message if an unexpected error occurs.
  static Future<String> getURLFromURI(String url) async {
    try {
      if (url.isEmpty) return '';
      final ref = FirebaseStorage.instance.refFromURL(url);
      final downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } on FirebaseException catch (e) {
      throw e.message!;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw 'Something went wrong.';
    }
  }
}
