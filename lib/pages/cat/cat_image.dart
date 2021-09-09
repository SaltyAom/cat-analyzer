import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:niku/niku.dart';

import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CatImage extends StatelessWidget {
  final Uint8List image;
  final Null Function() removeCatImage;
  final VoidCallback closeDialog;

  const CatImage({
    Key? key,
    required this.image,
    required this.closeDialog,
    required this.removeCatImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.memory(
      image,
      fit: BoxFit.cover,
    ) //
        .niku()
        .on(tap: () {
      showCupertinoModalBottomSheet(
        context: context,
        builder: (context) => Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                icon: Icon(Icons.delete_forever_rounded),
                onPressed: () {
                  Get.dialog(
                    Platform.isIOS
                        ? CupertinoAlertDialog(
                            title: Text("Remove cat"),
                            content: Text(
                              "Are you to remove this cat?",
                            ),
                            actions: [
                              CupertinoButton(
                                child: Text("No"),
                                onPressed: () {
                                  closeDialog();
                                },
                              ),
                              CupertinoButton(
                                child: NikuText("Yes")
                                  ..color(CupertinoColors.destructiveRed),
                                onPressed: removeCatImage,
                              )
                            ],
                          )
                        : AlertDialog(
                            title: Text("Remove cat"),
                            content: Text("Are you sure to remove this cat?"),
                            actions: [
                              NikuButton(Text("No"))
                                ..onPressed(() {
                                  closeDialog();
                                }),
                              NikuButton(NikuText("Yes")..color(Colors.red))
                                ..onPressed(removeCatImage)
                            ],
                          ),
                  );
                },
              ),
            ],
          ),
          body: Image.memory(
            image,
            fit: BoxFit.contain,
          ).niku()
            ..fullWidth()
            ..builder((child) => SafeArea(child: child))
            ..center(),
        ),
      );
    });
  }
}
