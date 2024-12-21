import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class FaceBodyValidationScreen extends StatefulWidget {
  @override
  _FaceBodyValidationScreenState createState() =>
      _FaceBodyValidationScreenState();
}

class _FaceBodyValidationScreenState extends State<FaceBodyValidationScreen> {
  late CameraController _controller;
  late List<CameraDescription> cameras;
  bool _isInitialized = false;
  String _step = 'face'; // Steps: 'face' -> 'body'
  String _message = 'Align your face within the circle';

  // Bounding box dimensions for upper body alignment
  final double boxTop = 10; // Top padding
  final double boxLeft = 10; // Left padding
  final double boxWidth = 10000; // Width of the box
  final double boxHeight = 10000; // Height of the box

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();

    // Find the front camera (selfie camera)
    CameraDescription frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () =>
          cameras.first, // Default to the first camera if front is not found
    );

    // Initialize the front camera for selfie mode
    _controller = CameraController(frontCamera, ResolutionPreset.high);
    await _controller.initialize();

    // Start the face detection process
    _startFaceDetection();

    setState(() {
      _isInitialized = true;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Start the face detection and capture process
  Future<void> _startFaceDetection() async {
    // Continuously detect faces
    while (_controller.value.isInitialized) {
      await Future.delayed(
          const Duration(seconds: 1)); // Capture image every second

      final image = await _controller.takePicture();
      final imageFile = File(image.path);

      bool isFaceValid = await _validateFace(imageFile);
      if (isFaceValid) {
        setState(() {
          _step = 'body';
          _message = 'Align your upper body within the rectangle';
        });

        // Show success dialog and proceed to body detection
        _showFaceValidationDialog(imageFile, "Face Detection", "Face");
        break; // Stop face detection after success
      } else {
        return;
      }
    }
  }

  // Show success dialog after face is detected
  Future<void> _showFaceValidationDialog(
      File imageFile, String title, String desc) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must press button to close
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Your $desc has been successfully detected.'),
                desc == "Face"
                    ? const Text('Proceeding to upper body alignment...')
                    : Container(),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                desc == "Face"
                    ? {
                        Navigator.of(context).pop(), // Close the dialog
                        _startBodyDetection(imageFile)
                      }
                    : Get.back(); //hedhi hezou lel model screen
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> _validateFace(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final faceDetector = GoogleMlKit.vision.faceDetector(FaceDetectorOptions(
      enableContours: true,
      enableClassification: true,
    ));
    final faces = await faceDetector.processImage(inputImage);

    faceDetector.close();
    return faces.isNotEmpty; // True if a face is detected
  }

  Future<void> _startBodyDetection(File imageFile) async {
    bool isBodyValid = await _validateBody(imageFile);
    if (isBodyValid) {
      _showFaceValidationDialog(imageFile, "Body Detection", "Body");
      // Proceed with your next steps (like loading 3D model or navigating)
    } else {
      return;
    }
  }

  Future<bool> _validateBody(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final poseDetector = GoogleMlKit.vision.poseDetector();
    final poses = await poseDetector.processImage(inputImage);

    bool isValid = false;

    for (Pose pose in poses) {
      // Check for specific key landmarks: shoulders, head
      bool upperBodyInsideBox = true;

      // Checking shoulders
      PoseLandmark? leftShoulder =
          pose.landmarks[PoseLandmarkType.leftShoulder];
      PoseLandmark? rightShoulder =
          pose.landmarks[PoseLandmarkType.rightShoulder];
      if (!_isLandmarkInsideBox(leftShoulder) ||
          !_isLandmarkInsideBox(rightShoulder)) {
        upperBodyInsideBox = false;
      }
      PoseLandmark? leftEar = pose.landmarks[PoseLandmarkType.leftEar];
      PoseLandmark? rightEar = pose.landmarks[PoseLandmarkType.rightEar];
      if (!_isLandmarkInsideBox(leftEar) || !_isLandmarkInsideBox(rightEar)) {
        upperBodyInsideBox = false;
      }

      PoseLandmark? leftElbow = pose.landmarks[PoseLandmarkType.leftElbow];
      PoseLandmark? rightElbow = pose.landmarks[PoseLandmarkType.rightElbow];
      if (!_isLandmarkInsideBox(leftElbow) ||
          !_isLandmarkInsideBox(rightElbow)) {
        upperBodyInsideBox = false;
      }

      // If both shoulders and optionally head are inside the bounding box, the upper body is aligned
      if (upperBodyInsideBox) {
        isValid = true;
     

        break; // Stop checking if the upper body is aligned
      }
    }

    poseDetector.close();
    return isValid;
  }

  // Helper function to check if a landmark is inside the bounding box
  bool _isLandmarkInsideBox(PoseLandmark? landmark) {
    if (landmark == null) return false;
    double x = landmark.x;
    double y = landmark.y;

    return x >= boxLeft &&
        x <= boxLeft + boxWidth &&
        y >= boxTop &&
        y <= boxTop + boxHeight;
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: Stack(
        children: [
          // Fullscreen Camera Preview
          Positioned.fill(
            child: CameraPreview(_controller),
          ),

          // Overlay Circle for Face Detection
          Positioned(
            top: 200, // Adjust position for the head
            left: 40,
            right: 40, // Adjust position for the head
            child: _step == 'face'
                ? Container(
                    width: 350, // Head size (circle radius)
                    height: 350, // Head size (circle radius)
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                      border: Border.all(color: Colors.red, width: 3),
                    ),
                  )
                : const SizedBox.shrink(),
          ),

          // Overlay Rectangle for Upper Body Detection
          Positioned(
            top: 120, // Adjust position for the upper body
            left: 20,
            right: 20, // Adjust position for the upper body
            child: _step == 'body'
                ? Container(
                    width: boxWidth, // Adjust for upper body
                    height: Get.height / 1.2, // Adjust for upper body
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Colors.blue, width: 3),
                    ),
                  )
                : const SizedBox.shrink(),
          ),

          // Instruction Message
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Text(
              _message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                backgroundColor: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
