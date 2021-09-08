import 'dart:io';

import 'package:cat/services/heroFlight.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cat/models/cat.dart';
import 'package:hive/hive.dart';

import 'package:niku/niku.dart';

import 'package:get/get.dart';

class CatPage extends StatelessWidget {
  final CatModel cat;

  const CatPage(
    this.cat, {
    Key? key,
  }) : super(key: key);

  createDeleteHandler(String key) => () async {
        Get.dialog(
          Platform.isIOS
              ? CupertinoAlertDialog(
                  title: Text("Remove cat"),
                  content: Text("Are you to remove this cat?"),
                  actions: [
                    CupertinoButton(
                      child: Text("No"),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    CupertinoButton(
                      child: NikuText("Yes")
                        ..color(CupertinoColors.destructiveRed),
                      onPressed: createDeleteCatHandler(key),
                    )
                  ],
                )
              : AlertDialog(
                  title: Text("Remove cat"),
                  content: Text("Are you sure to remove this cat?"),
                  actions: [
                    NikuButton(Text("No"))
                      ..onPressed(() {
                        Get.back();
                      }),
                    NikuButton(NikuText("Yes")..color(Colors.red))
                      ..onPressed(createDeleteCatHandler(key)),
                  ],
                ),
        );
      };

  createDeleteCatHandler(String key) => () async {
        final box = Hive.box<CatModel>("cat");

        await box.delete(key);

        Get.back();
        Navigator.of(Get.context!).maybePop();
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cat.name.capitalizeFirst!),
        actions: [
          IconButton(
            onPressed: createDeleteHandler(cat.name),
            icon: Icon(
              Icons.delete_forever,
            ),
          ).niku().tooltip("Remove cat")
        ],
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
              ..builder(nikuHero("${cat.name} Name"))
              ..mt(24)
              ..mb(8),
        NikuText(cat.type) //
            .fontSize(18)
            .color(Colors.grey.shade500)
            .niku()
              ..builder(nikuHero("${cat.name} Type"))
      ]),
    );
  }
}
