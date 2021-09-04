import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/instance_manager.dart';
import 'package:cat/pages/analyzer/state.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:niku/niku.dart';

import 'package:camera/camera.dart';

class Camera extends HookWidget {
  const Camera({Key? key}) : super(key: key);

  Future<CameraController?> initCamera() async {
    final cameras = await availableCameras();

    if (cameras.length == 0) return null;

    final controller = CameraController(
      cameras.first,
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    await controller.initialize();

    return controller;
  }

  @override
  Widget build(BuildContext context) {
    final cameraState = useState<CameraController?>(null);
    final cameraAvailable = useState(false);
    final state = Get.find<AnalyzerPageState>();

    useEffect(() {
      Timer? interval;
      CameraController? _controller;

      initCamera().then((camera) {
        cameraAvailable.value = camera != null;

        if (camera == null) return null;

        cameraState.value = camera;

        state.requestCapture.listen((_) async {
          interval?.cancel();

          final image = await camera.takePicture();
          state.takeImage(image.path);
        });

        interval = Timer.periodic(
          Duration(milliseconds: 600),
          (timer) async {
            final image = await camera.takePicture();

            state.updateImage(image.path);
          },
        );
      });

      return () {
        interval?.cancel();

        if (_controller != null) _controller.dispose();
      };
    }, []);

    if (!cameraAvailable.value ||
            cameraState.value == null ||
            !cameraState.value!.value.isInitialized //
        ) return Niku();

    return CameraPreview(cameraState.value!).niku()
      ..fullSize()
      ..bg(Colors.black);
  }
}
