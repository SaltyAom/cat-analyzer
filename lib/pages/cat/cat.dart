import 'package:flutter/material.dart';

import 'package:cat/models/cat.dart';

import 'package:niku/niku.dart';

import 'package:get/get.dart';

class CatPage extends StatelessWidget {
  final CatModel cat;

  const CatPage(
    this.cat, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cat.name.capitalizeFirst!),
      ),
      body: NikuColumn([
        Image.memory(
          cat.cover,
          fit: BoxFit.cover,
        ).niku()
          ..aspectRatio(1 / 1)
          ..heroTag("${cat.name} Image"),
        NikuText(cat.name.capitalizeFirst!) //
            .fontSize(32)
            .w600()
            .niku()
              ..heroTag("${cat.name} Name")
              ..mt(24)
              ..mb(8),
        NikuText(cat.type) //
            .fontSize(18)
            .color(Colors.grey.shade500)
            .niku()
              ..heroTag("${cat.name} Type"),
      ]),
    );
  }
}
