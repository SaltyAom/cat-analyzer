import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:get/get.dart';
import 'package:cat/pages/analyzer/state.dart';

import 'package:niku/niku.dart';

class CameraButton extends StatelessWidget {
  const CameraButton({
    Key? key,
  }) : super(key: key);

  VoidCallback createPickImageHandler(Function() requestTakeImage) => () async {
        requestTakeImage();
      };

  @override
  Widget build(BuildContext context) {
    final state = Get.find<AnalyzerPageState>();
    final captureImage = createPickImageHandler(state.requestCaptureImage);

    return NikuStack([
      NikuButton(Niku())
          .onPressed(captureImage)
          .splash(Colors.transparent)
          .niku()
          .size(72, 72)
          .bg(Colors.white)
          .rounded()
          .bottomCenter()
          .builder(
            (child) => SafeArea(
              child: child,
            ),
          )
          .mb(16),
      NikuButton.outlined(Niku())
          .bc(Colors.black)
          .rounded()
          .niku()
          .size(60, 60)
          .bottomCenter()
          .builder(
            (child) => SafeArea(
              child: child,
            ),
          )
          .ignorePointer()
          .mb(22),
    ]);
  }
}
