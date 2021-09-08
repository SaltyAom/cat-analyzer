import 'package:cat/pages/gallery/components/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:niku/niku.dart';

import 'package:cat/pages/cat/cat.dart';

import 'package:hive/hive.dart';
import 'package:cat/models/cat.dart';

class GalleryPage extends HookWidget {
  final VoidCallback toAnalyze;
  // final VoidCallback toProfile;

  const GalleryPage({
    Key? key,
    required this.toAnalyze,
    // required this.toProfile,
  }) : super(key: key);

  @override
  build(context) {
    final cats = useState<List<CatModel>>([]);
    final isInit = useState(false);

    updateCat() async {
      final box = await Hive.openBox<CatModel>('cat');

      final localCats = box.toMap();
      final catsKey = localCats.keys;

      final List<CatModel> catsList = [];
      [...catsKey].forEach((cat) {
        final _cat = localCats[cat];

        if (_cat != null) catsList.insert(0, _cat);
      });

      cats.value = catsList;
    }

    useEffect(() {
      updateCat().then((_) {
        isInit.value = true;
      });
    }, []);

    createToCatPageHandler(int index) => () async {
          final catPage = await createCatPage(cats.value[index], updateCat);

          Get.to(catPage);
        };

    return Scaffold(
      appBar: AppBar(
        title: Text("Cat Analyzer"),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: toAnalyze,
            icon: Icon(
              Icons.search,
            ),
          ),
          // CircleAvatar(
          //   backgroundColor: Colors.grey.shade300,
          // ).niku()
          //   ..mr(12)
          //   ..on(tap: toProfile)
          //   ..builder(
          //     (child) => Transform.scale(
          //       scale: .9,
          //       child: child,
          //     ),
          //   ),
        ],
      ),
      body: cats.value.length > 0
          ? GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 3 / 5,
              children: List.generate(cats.value.length, (index) {
                final cat = cats.value[index];

                return CatCard(
                  cat,
                  toCatPage: createToCatPageHandler(index),
                  index: index,
                );
              }),
            ) //
              .niku()
              .px(12)
              .pt(12)
          : NikuColumn([
              if (isInit.value) ...[
                SvgPicture.asset(
                  'assets/cat.svg',
                ) //
                    .niku()
                    .fullWidth()
                    .aspectRatio(2 / 1),
                NikuText(
                  "Welcome to Cat Analyzer!\nAn app to get to know more of your cats!\nSimply start scan your cat to get start!",
                )
                    .fontSize(16)
                    .color(Colors.grey.shade700)
                    .center()
                    .height(1.5)
                    .niku()
                      ..my(32),
                NikuButton.elevated(
                  NikuText("Scan your cat!")
                    ..fontSize(18)
                    ..w600(),
                )
                  ..onPressed(toAnalyze)
                  ..px(28)
                  ..py(16),
              ]
            ]) //
              .justifyCenter()
              .itemsCenter()
              .niku()
              .fullHeight()
              .maxWidth(640)
              .px(20),
    );
  }

  Future<Widget> createCatPage(CatModel cat, Function updateCat) =>
      Future.microtask(
        () => WillPopScope(
            child: CatPage(cat),
            onWillPop: () async {
              await updateCat();

              return true;
            }),
      );
}
