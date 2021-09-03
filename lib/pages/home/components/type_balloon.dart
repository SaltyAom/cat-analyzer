import 'package:cat/pages/home/state.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:niku/niku.dart';

import 'package:cat/services/classification.dart';

class TypeBalloon extends StatelessWidget {
  final classifier = ClassifierQuant();

  TypeBalloon({Key? key}) : super(key: key);

  predict(String image, Function(String newState) updateState) {
    final prediction = classifier.predict(image);

    final String label = prediction.label;
    final double confidence = prediction.score;

    if (confidence < 0.35) return updateState("");
    if (confidence > 0.8) return updateState(label);

    updateState("Maybe $label");
  }

  String getPrediction(HomePageState state) {
    final catType = state.catType.value;
    final confidence = state.confidence.value;

    if (confidence < 0.45) return "";
    if (confidence > 0.8) return catType;

    return "Maybe $catType";
  }

  @override
  Widget build(BuildContext context) {
    final state = Get.find<HomePageState>();

    return Obx(() {
      final catType = getPrediction(state);

      if (catType == "") return Niku();

      return NikuText(catType)
          .fontSize(18)
          .w600()
          .color(Colors.grey.shade800)
          .niku()
          .px(24)
          .py(12)
          .bg(Colors.white)
          .rounded()
          .bottomCenter()
          .builder(
            (child) => SafeArea(
              child: child,
            ),
          )
          .mb(120);
    });
  }
}
