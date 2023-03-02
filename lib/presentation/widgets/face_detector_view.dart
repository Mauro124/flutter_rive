import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import '../providers/avatar_provider/avatar_providers.dart';
import 'camera_view.dart';

class FaceDetectorView extends ConsumerStatefulWidget {
  const FaceDetectorView({Key? key}) : super(key: key);

  @override
  ConsumerState<FaceDetectorView> createState() => _FaceDetectorViewState();
}

class _FaceDetectorViewState extends ConsumerState<FaceDetectorView> {
  int pointX = 0;
  int pointY = 0;
  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableLandmarks: true,
      enableClassification: true,
    ),
  );

  @override
  void dispose() {
    _faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CameraView(
          onImage: (inputImage) => _processImage(inputImage),
        ),
        // PointNose(pointX: pointX.toDouble(), pointY: pointY.toDouble()),
      ],
    );
  }

  Future<void> _processImage(InputImage inputImage) async {
    final List<Face> faces = await _faceDetector.processImage(inputImage);
    for (Face face in faces) {
      final FaceLandmark noseBase = face.landmarks[FaceLandmarkType.noseBase]!;
      final Point<int> noseBasePos = noseBase.position;

      _changeEyesPositionState(noseBasePos);

      if (face.smilingProbability != null) {
        final double? smileProb = face.smilingProbability;
        _changeEmotionState(smileProb ?? 0);
      }
    }
  }

  void _changeEmotionState(double smileProb) {
    if (smileProb > 0.9) {
      ref.read(emotionStateProvider.notifier).state = AvatarEmotionState.HAPPY;
    } else {
      ref.read(emotionStateProvider.notifier).state = AvatarEmotionState.NEUTRAL;
    }
  }

  void _changeEyesPositionState(Point<int> points) {
    bool left = points.x > 170;
    bool right = points.x < 60;
    bool top = points.y < 70;
    bool bottom = points.y > 240;
    bool centerX = !left && !right;
    bool centerY = !top && !bottom;
    AvatarEyesPositionState state = AvatarEyesPositionState.CENTER;

    setState(() {
      pointX = points.x;
      pointY = points.y;
    });

    if (left && top) {
      state = AvatarEyesPositionState.TOP_LEFT;
    } else if (centerX && top) {
      state = AvatarEyesPositionState.TOP_CENTER;
    } else if (right && top) {
      state = AvatarEyesPositionState.TOP_RIGHT;
    } else if (centerY && left) {
      state = AvatarEyesPositionState.CENTER_LEFT;
    } else if (centerY && centerX) {
      state = AvatarEyesPositionState.CENTER;
    } else if (centerY && right) {
      state = AvatarEyesPositionState.CENTER_RIGHT;
    } else if (bottom && left) {
      state = AvatarEyesPositionState.BOTTOM_LEFT;
    } else if (bottom && centerX) {
      state = AvatarEyesPositionState.BOTTOM_CENTER;
    } else if (bottom && right) {
      state = AvatarEyesPositionState.BOTTOM_RIGHT;
    }

    ref.read(eyesPositionProviders.notifier).state = state;
  }
}
