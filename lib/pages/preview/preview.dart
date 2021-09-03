import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:cat/pages/analyzer/state.dart';

import 'package:niku/niku.dart';

class PreviewPage extends StatelessWidget {
  @override
  build(context) {
    final state = Get.find<AnalyzerPageState>();

    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: NikuColumn([
        Obx(() {
          final isCat = state.confidence.value > 0.6;
          final catType = isCat ? state.catType.value : "Not cat";

          return NikuColumn([
            Image.file(
              File(state.image.value),
            ).niku()
              ..rounded(8)
              ..shadows([
                BoxShadow(
                  offset: Offset(0, 8),
                  color: Colors.black.withOpacity(.125),
                  blurRadius: 24,
                ),
              ])
              ..maxWidth(560)
              ..px(24)
              ..mb(28),
            NikuText(catType)..fontSize(32),
            isCat
                ? NikuButton.elevated(
                    NikuText("Save cat")
                      ..fontSize(21)
                      ..w500(),
                  )
                    .px(36)
                    .py(12)
                    .shadow(Colors.transparent)
                    .onPressed(() {})
                    .niku()
                    .mt(28)
                : Niku(),
          ])
            ..mb(24);
        }),
      ]).justifyCenter().itemsCenter().niku()
        ..fullWidth(),
    );
  }
}
