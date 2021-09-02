import 'dart:io';

import 'package:cat/classifier.dart';
import 'package:flutter/material.dart';

import 'package:niku/niku.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

import 'package:image/image.dart' as img;

import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';

import 'package:cat/classification.dart';
import 'package:cat/main.dart';

import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          brightness: Brightness.dark,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends HookWidget {
  final ImagePicker picker = ImagePicker();
  late CameraController controller;
  final _classifier = ClassifierQuant();

  Future<bool> initCamera() async {
    final cameras = await availableCameras();

    if (cameras.length == 0) return false;

    controller = CameraController(
      cameras.first,
      ResolutionPreset.high,
    );

    await controller.initialize();

    return true;
  }

  void dispose() async {
    controller.dispose();
  }

  void Function() pickImageHandler(
    Function(String string) updateState,
    Function(String string) showImage,
  ) =>
      () async {
        final image = await picker.pickImage(
          source: ImageSource.gallery,
        );

        if (image == null) return;

        showImage(image.path);

        final imageInput = File(image.path).readAsBytesSync();
        final prediction = _classifier.predict(img.decodeImage(imageInput)!);

        final String label = prediction.label;
        final double confidence = prediction.score;

        if (confidence < 0.35) return updateState("");
        if (confidence > 0.8) return updateState(label);

        updateState("Maybe $label");
      };

  @override
  build(context) {
    final cameraAvailable = useState(false);
    final catType = useState("");
    final image = useState("");

    final updateCatType = (String type) {
      catType.value = type;
    };

    final updateImage = (String type) {
      image.value = type;
    };

    final pickImage = pickImageHandler(updateCatType, updateImage);

    useEffect(() {
      // Tflite.loadModel(
      //   model: "assets/cats.tflite",
      //   labels: "assets/labels.txt",
      //   numThreads: 2,
      //   isAsset: true,
      // );

      _classifier.loadLabels();

      initCamera().then((success) => {cameraAvailable.value = success});

      return dispose;
    }, []);

    return Scaffold(
      body: NikuColumn([
        NikuStack([
          cameraAvailable.value
              ? CameraPreview(controller).niku().fullSize().bg(Colors.black)
              : Niku(),
          NikuButton(
            Icon(
              Icons.image,
              color: Colors.white,
            ),
          )
              .onPressed(pickImage)
              .splash(Colors.white.withOpacity(.1))
              .niku()
              .size(56, 56)
              .bg(Colors.grey.shade900)
              .rounded(8)
              .bottomLeft()
              .builder(
                (child) => SafeArea(
                  child: child,
                ),
              )
              .mb(24)
              .ml(24),
          NikuButton(Niku())
              .onPressed(() {})
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
          catType.value != ""
              ? NikuText(catType.value)
                  .fontSize(18)
                  .w600()
                  .color(Colors.grey.shade800)
                  .niku()
                  .px(36)
                  .py(12)
                  .bg(Colors.white)
                  .rounded()
                  .bottomCenter()
                  .builder(
                    (child) => SafeArea(
                      child: child,
                    ),
                  )
                  .mb(120)
              : Niku(),
          image.value != ""
              ? SafeArea(
                  child: Image.asset(image.value),
                )
              : Niku()
        ]).niku().bg(Colors.black).expanded()
      ]).justifyCenter().itemsCenter().niku().fullSize(),
    );
  }
}
