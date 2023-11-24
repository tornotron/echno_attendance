import 'package:camera/camera.dart';

Future<CameraDescription> cameraObjectProvider() async {
  final cameras = await availableCameras();
  final frontCamera = cameras[1];
  return frontCamera;
}
