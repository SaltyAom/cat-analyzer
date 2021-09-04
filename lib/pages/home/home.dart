import 'package:flutter/material.dart';

import 'package:cat/pages/analyzer/analyzer.dart';
import 'package:cat/pages/gallery/gallery.dart';
import 'package:cat/pages/profile/profile.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

class HomePage extends HookWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  build(context) {
    final controller = useTabController(
      initialLength: 3,
      initialIndex: 1,
    );

    return TabBarView(
      controller: controller,
      children: [
        AnalyzerPage(() {
          controller.animateTo(1);
        }),
        GalleryPage(
          toAnalyze: () {
            controller.animateTo(0);
          },
          toProfile: () {
            controller.animateTo(2);
          },
        ),
        ProfilePage()
      ],
    );
  }
}
