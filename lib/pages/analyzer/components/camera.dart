import 'dart:async';

import 'package:cat/pages/preview/preview.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
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
        bool allow = true;

        var runImageStream = () async {};

        final handleImagePreview = (CameraImage image) async {
          if (!allow || camera.value.isTakingPicture) return null;
          allow = false;

          await camera.stopImageStream();

          final plane = image.planes[0].bytes;

          await state.updateImage(plane);

          Future.delayed(Duration(seconds: 1), () async {
            await runImageStream();
            allow = true;
          });
        };

        runImageStream = () async {
          await camera.startImageStream(handleImagePreview);
        };

        state.requestCapture.listen((_) async {
          if (camera.value.isTakingPicture) return null;
          if (camera.value.isStreamingImages) await camera.stopImageStream();

          final image = await camera.takePicture();
          await state.takeImage(image.path);

          Get.to(() => PreviewPage());

          runImageStream();
        });

        // runImageStream();
      });

      return () {
        interval?.cancel();

        if (_controller != null) {
          _controller.stopImageStream();
          _controller.dispose();
        }
      };
    }, []);

    if (!cameraAvailable.value ||
        cameraState.value == null ||
        !cameraState.value!.value.isInitialized) return Niku();

    return useMemoized(
      () => CameraPreview(cameraState.value!).niku()
        ..aspectRatio(
          cameraState.value!.value.previewSize!.height /
              cameraState.value!.value.previewSize!.width,
        )
        ..center()
        ..bg(Colors.black),
      [cameraState.value],
    );
  }
}
