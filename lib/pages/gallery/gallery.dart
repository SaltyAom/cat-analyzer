import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:niku/niku.dart';

import 'package:cat/pages/cat/cat.dart';

import 'package:hive/hive.dart';
import 'package:cat/models/cat.dart';

class GalleryPage extends HookWidget {
  final VoidCallback toAnalyze;
  final VoidCallback toProfile;

  const GalleryPage({
    Key? key,
    required this.toAnalyze,
    required this.toProfile,
  }) : super(key: key);

  @override
  build(context) {
    final cats = useState<List<CatModel>>([]);

    useEffect(() {
      (() async {
        final box = await Hive.openBox<CatModel>('cat');

        final localCats = box.toMap();
        final catsKey = localCats.keys;

        final List<CatModel> catsList = [];
        [...catsKey].forEach((cat) {
          final _cat = localCats[cat];

          if (_cat != null) catsList.insert(0, _cat);
        });

        cats.value = catsList;
      })();
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: Text("Neko Desuyo"),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: toAnalyze,
            icon: Icon(
              Icons.search,
            ),
          ),
          CircleAvatar(
            backgroundColor: Colors.grey.shade300,
          ).niku()
            ..mr(12)
            ..on(tap: toProfile)
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
        children: List.generate(cats.value.length, (index) {
          final cat = cats.value[index];

          return Container(
            key: key,
            color: Colors.black,
            child: NikuStack([
              Image.memory(
                cat.cover,
                fit: BoxFit.cover,
              ).niku()
                ..aspectRatio(3 / 4),
              Niku()
                ..boxDecoration(
                  BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0, 0.5, 0.9],
                      colors: [
                        Colors.transparent,
                        Colors.transparent,
                        Colors.black,
                      ],
                    ),
                  ),
                )
                ..aspectRatio(7 / 10),
              NikuColumn([
                NikuText(cat.name.capitalizeFirst!) //
                    .fontSize(18)
                    .w600()
                    .color(Colors.white)
                    .niku()
                      ..mb(4),
                NikuText(cat.type) //
                    .fontSize(16)
                    .color(Colors.grey.shade400)
              ]).justifyEnd().itemsStart().niku()
                ..p(16)
            ]),
          ).niku()
            ..rounded(8)
            ..on(tap: () {
              Get.to(() => CatPage(cat));
            });
        }),
      ).niku()
        ..px(12)
        ..pt(12),
    );
  }
}
