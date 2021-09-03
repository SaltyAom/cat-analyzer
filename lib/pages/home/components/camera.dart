import 'dart:async';

import 'package:cat/pages/home/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/instance_manager.dart';

import 'package:niku/niku.dart';

import 'package:camera/camera.dart';

class Camera extends HookWidget {
  late CameraController controller;

  Camera({Key? key}) : super(key: key);

  Future<bool> initCamera() async {
    final cameras = await availableCameras();

    if (cameras.length == 0) return false;

    controller = CameraController(
      cameras.first,
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    await controller.initialize();

    return true;
  }

  void dispose() async {
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cameraAvailable = useState(false);
    final state = Get.find<HomePageState>();

    useEffect(() {
      Timer? interval;

      initCamera().then((success) {
        cameraAvailable.value = success;

        if (!success) return null;

        state.requestCapture.listen((_) async {
          interval?.cancel();

          if (!success) return null;

          final image = await controller.takePicture();
          state.takeImage(image.path);
        });

        interval = Timer.periodic(
          Duration(milliseconds: 600),
          (timer) async {
            final image = await controller.takePicture();

            state.updateImage(image.path);
          },
        );
      });

      return () {
        interval?.cancel();
        dispose();
      };
    }, []);

    if (!cameraAvailable.value) return Niku();

    return useMemoized(
      () => CameraPreview(controller).niku()
        ..fullSize()
        ..bg(Colors.black),
      [controller],
    );
  }
}
