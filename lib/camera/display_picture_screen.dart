import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echno_attendance/common_widgets/loading_screen.dart';
import 'package:echno_attendance/constants/colors_string.dart';
import 'package:echno_attendance/employee/models/employee.dart';
import 'package:echno_attendance/employee/screens/homepage_screen.dart';
import 'package:echno_attendance/employee/services/employee_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

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

  Future<String> uploadImage(File imageFile) async {
    try {
      final employeeid = currentEmployee.employeeId;
      DateTime attdate = DateTime.now();
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child('attendance/$employeeid/$attdate');
      UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
      LoadingScreen().show(context: context, text: "Uploading Image");
      TaskSnapshot taskSnapshot = await uploadTask
          .whenComplete(() => {LoadingScreen().hide()})
          .whenComplete(
        () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Image Uploaded'),
                  content: const Text('Your attendance has been marked'),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () {
                          // Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => const HomePage()));
                        },
                        child: const Text('OK'))
                  ],
                );
              });
        },
      );
      return await taskSnapshot.ref.getDownloadURL();
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
    Widget content = Scaffold(
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
                      final imgUrl = await uploadImage(widget.imagePath);
                      saveImageUrlToFirestore(imgUrl);
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
    return content;
  }
}
