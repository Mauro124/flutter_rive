import 'package:flutter/material.dart';

import '../shared/styles/theme.dart';
import '../widgets/avatar.dart';
import '../widgets/face_detector_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: kPaddingApp,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              FaceDetectorView(),
              Expanded(child: Avatar()),
            ],
          ),
        ),
      ),
    );
  }
}
