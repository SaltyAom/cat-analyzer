import 'package:cat/pages/home/state.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

import 'package:niku/niku.dart';

import 'package:cat/pages/home/components/components.dart';

class HomePage extends StatelessWidget {
  @override
  build(context) {
    Get.put(HomePageState());

    return Scaffold(
      body: NikuColumn([
        NikuStack([
          Camera(),
          CatImagePicker(),
          CameraButton(),
          TypeBalloon(),
          // image.value != ""
          //     ? SafeArea(
          //         child: Image.asset(image.value),
          //       )
          //     : Niku()
        ]).niku().bg(Colors.black).expanded()
      ]).justifyCenter().itemsCenter().niku().fullSize(),
    );
  }
}
