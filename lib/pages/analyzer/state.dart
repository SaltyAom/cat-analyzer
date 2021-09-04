import 'package:get/get.dart';

import 'package:cat/services/classification.dart';

import 'package:cat/pages/preview/preview.dart';

class AnalyzerPageState extends GetxController {
  final classifier = ClassifierQuant();
  final previewPage = PreviewPage();

  var catType = ''.obs;
  var image = ''.obs;
  var confidence = 0.0.obs;
  var requestCapture = 0.obs;

  void updateCatType(String type) {
    catType.value = type;
  }

  void requestCaptureImage() => ++requestCapture;

  Future<void> updateImage(String path) async {
    image.value = path;

    await predict();
  }

  Future<void> takeImage(String path) async {
    await updateImage(path);
  }

  Future<void> predict() async {
    final prediction = classifier.predict(image.value);

    print("Prediction $prediction");

    catType.value = prediction.label;
    confidence.value = prediction.score;
  }
}