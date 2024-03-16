import 'dart:io';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echno_attendance/constants/colors_string.dart';
import 'package:echno_attendance/employee/models/employee.dart';
import 'package:echno_attendance/employee/screens/index.dart';
import 'package:echno_attendance/employee/services/employee_service.dart';
import 'package:echno_attendance/employee/widgets/texts.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();

    _controller = CameraController(
      widget.camera,
      ResolutionPreset.ultraHigh,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Colors.black),
        title: const Texts(textData: "Take a picture"),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () async {
          try {
            await _initializeControllerFuture;

            final image = await _controller.takePicture();

            if (!mounted) return;

            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(
                  imagePath: File(image.path),
                ),
              ),
            );
          } catch (e) {
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

class DisplayPictureScreen extends StatefulWidget {
  final File imagePath;
  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  State<DisplayPictureScreen> createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  late final Employee currentEmployee;

  Future<void> fetchCurrentEmployee() async {
    final employee = await EmployeeService.firestore().currentEmployee;
    setState(() {
      currentEmployee = employee;
    });
  }

  Future<void> saveImageUrlToFirestore(String imageUrl) async {
    DateTime todaydate = DateTime.now();
    String formatedToday = DateFormat('yyyy-MM-dd').format(todaydate);
    try {
      FirebaseFirestore.instance
          .collection('attendance')
          .doc(currentEmployee.employeeId)
          .collection('attendancedate')
          .doc(formatedToday)
          .set({"image-url": imageUrl}, SetOptions(merge: true));
    } catch (e) {
      print(e);
    }
  }

  Future<UploadTask> uploadImage(File imageFile) async {
    try {
      final employeeid = currentEmployee.employeeId;
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child('attendance/$employeeid');
      UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
      // TaskSnapshot taskSnapshot = await uploadTask.whenComplete(
      //   () => {
      //     showDialog(
      //         context: context,
      //         builder: (BuildContext context) {
      //           return AlertDialog(
      //             title: const Text('Image Uploaded'),
      //             content: const Text('Your attendance has been marked'),
      //             actions: <Widget>[
      //               TextButton(
      //                   onPressed: () {
      //                     Navigator.pushReplacement(
      //                         context,
      //                         MaterialPageRoute(
      //                             builder: (context) => const HomePage()));
      //                   },
      //                   child: const Text('OK'))
      //             ],
      //           );
      //         })
      //   },
      // );
      return uploadTask;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  @override
  void initState() {
    fetchCurrentEmployee();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Display the Picture',
          style: TextStyle(color: Colors.white),
        ),
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Colors.black),
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          Image.file(widget.imagePath),
          Positioned(
            left: 0,
            right: 0,
            bottom: 10,
            child: Flex(
              direction: Axis.horizontal,
              children: [
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      // final imgUrl = await uploadImage(File(widget.imagePath));
                      // saveImageUrlToFirestore(imgUrl);
                      FutureBuilder<UploadTask>(
                        future:
                            uploadImage(widget.imagePath), // pass the File here
                        builder: (BuildContext context,
                            AsyncSnapshot<UploadTask> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator(); // Show loading screen
                          } else if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }
                            // The upload is complete, show your dialog here
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Image Uploaded'),
                                  content: const Text(
                                      'Your attendance has been marked.'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomePage()),
                                        );
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                            return Container();
                          } else {
                            return Container(); // Return an empty container to avoid build errors
                          }
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: echnoBlueColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      textStyle: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    child: const Text(
                      'Upload',
                      style: TextStyle(
                          fontFamily: 'TT Chocolates', color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: echnoBlueColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      textStyle: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    child: const Text(
                      'Retake',
                      style: TextStyle(
                          fontFamily: 'TT Chocolates', color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
