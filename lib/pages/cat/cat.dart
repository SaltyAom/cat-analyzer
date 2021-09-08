import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive/hive.dart';
import 'package:cat/models/cat.dart';

import 'package:niku/niku.dart';

import 'package:get/get.dart';

import 'package:cat/pages/cat/in_depth.dart';
import 'package:cat/pages/cat/info.dart';

class CatPage extends HookWidget {
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
  build(context) {
    final tab = useState(0);

    final controller = useTabController(
      initialLength: 2,
    );

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        title: CupertinoSlidingSegmentedControl(
          groupValue: tab.value,
          children: {
            0: NikuText("Info").fontSize(16).niku().py(8).px(16),
            1: NikuText("In-depth").fontSize(16),
          },
          onValueChanged: (index) {
            tab.value = int.parse(index.toString());
            controller.animateTo(tab.value);
          },
        ),
        actions: [
          IconButton(
            onPressed: createDeleteHandler(cat.name),
            icon: Icon(
              Icons.delete_forever,
            ),
          ).niku()
            ..tooltip("Remove cat")
        ],
      ),
      body: TabBarView(
        controller: controller,
        children: [CatInfo(cat), InDepthCat(cat)],
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }
}
