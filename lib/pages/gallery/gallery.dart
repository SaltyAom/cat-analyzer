import 'package:flutter/material.dart';

import 'package:cat/pages/analyzer/analyzer.dart';
import 'package:cat/pages/cat/cat.dart';
import 'package:cat/pages/profile/profile.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

import 'package:niku/niku.dart';

class GalleryPage extends HookWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  build(context) {
    final controller = useTabController(
      initialLength: 3,
      initialIndex: 1,
    );

    final scrollback = () {
      controller.animateTo(1);
    };

    return TabBarView(
      controller: controller,
      children: [
        AnalyzerPage(scrollback),
        Scaffold(
          appBar: AppBar(
            title: Text("Neko Desuyo"),
            centerTitle: false,
            actions: [
              IconButton(
                onPressed: () {
                  controller.animateTo(0);
                },
                icon: Icon(
                  Icons.search,
                ),
              ),
              CircleAvatar(
                backgroundColor: Colors.grey.shade300,
              ).niku()
                ..mr(12)
                ..on(tap: () {
                  controller.animateTo(2);
                })
                ..builder(
                  (child) => Transform.scale(
                    scale: .9,
                    child: child,
                  ),
                ),
            ],
          ),
          body: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 3 / 5,
            children: List.generate(50, (index) {
              return Container(
                key: key,
                color: Colors.black,
                child: NikuStack([
                  Image.network(
                    "https://www.rd.com/wp-content/uploads/2019/11/cat-10-e1573844975155-scaled.jpg",
                    fit: BoxFit.cover,
                  ).niku()
                    ..aspectRatio(3 / 4),
                  NikuColumn([
                    Niku()
                      ..boxDecoration(
                        BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [0, 0.6, 1],
                            colors: [
                              Colors.transparent,
                              Colors.transparent,
                              Colors.black,
                            ],
                          ),
                        ),
                      )
                      ..aspectRatio(7 / 10)
                  ]),
                  NikuColumn([
                    NikuText("Cat")
                        .fontSize(18)
                        .w600()
                        .color(Colors.white)
                        .niku()
                          ..mb(4),
                    NikuText("British Shorthair")
                        .fontSize(16)
                        .color(Colors.grey.shade400)
                  ]).justifyEnd().itemsStart().niku()
                    ..p(16)
                ]),
              ).niku()
                ..rounded(8)
                ..on(tap: () {
                  Get.to(CatPage());
                });
            }),
          ).niku()
            ..px(12)
            ..pt(12),
        ),
        Profile()
      ],
    );
  }
}
