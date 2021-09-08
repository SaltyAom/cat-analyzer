import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:get/instance_manager.dart';

import 'package:niku/niku.dart';

import './state.dart';
import './components/components.dart';

class AnalyzerPage extends HookWidget {
  final VoidCallback scrollback;

  const AnalyzerPage(
    this.scrollback, {
    Key? key,
  }) : super(key: key);

  @override
  build(context) {
    Get.put(AnalyzerPageState());

    useEffect(() {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
        ),
      );
    }, []);

    return Scaffold(
      body: NikuColumn([
        NikuStack([
          NikuButton.icon(
            Icon(
              Icons.close,
              color: Colors.white,
            ),
          ) //
              .label(Niku())
              .onPressed(scrollback)
              .rounded()
              .niku()
                ..builder(
                  (child) => SafeArea(
                    child: child,
                  ),
                )
                ..topRight(),
          Camera(),
          CatImagePicker(),
          CameraButton(),
          // TypeBalloon(),
        ]) //
            .niku()
            .bg(Colors.black)
            .expanded()
      ]) //
          .justifyCenter()
          .itemsCenter()
          .niku()
          .fullSize(),
    );
  }
}
