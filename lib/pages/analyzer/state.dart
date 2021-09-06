import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';

import 'package:cat/services/classification.dart';

import 'package:cat/pages/preview/preview.dart';

class AnalyzerPageState extends GetxController {
  final classifier = ClassifierQuant();
  final previewPage = PreviewPage();

  var catType = ''.obs;
  var image = Uint8List.fromList([]).obs;
  var confidence = 0.0.obs;
  var requestCapture = 0.obs;

  void updateCatType(String type) {
    catType.value = type;
  }

  void requestCaptureImage() => ++requestCapture;

  Future<void> updateImage(Uint8List buffer) async {
    image.value = buffer;

    await predict();
  }

  Future<void> takeImage(String path) async {
    final buffer = File(path).readAsBytesSync();

    await updateImage(buffer);
  }

  Future<void> predict() async {
    final prediction = await classifier.predict(image.value);

    print("Prediction $prediction");

    catType.value = prediction.label;
    confidence.value = prediction.score;
  }
}
