import 'package:cat/pages/home/state.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

import 'package:niku/niku.dart';

import 'package:image_picker/image_picker.dart';

class CatImagePicker extends StatelessWidget {
  final ImagePicker picker = ImagePicker();

  CatImagePicker({
    Key? key,
  }) : super(key: key);

  VoidCallback createPickImageHandler(Function(String path) updateImage) =>
      () async {
        final image = await picker.pickImage(
          source: ImageSource.gallery,
        );

        if (image == null) return;

        updateImage(image.path);
      };

  @override
  Widget build(BuildContext context) {
    final state = Get.find<HomePageState>();
    final pickImage = createPickImageHandler(state.takeImage);

    return NikuButton(
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
        .ml(24);
  }
}
