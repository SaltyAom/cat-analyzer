import 'dart:typed_data';

import 'package:cat/pages/cat/cat_image.dart';
import 'package:cat/services/cat_wiki.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:hive/hive.dart';
import 'package:cat/models/cat.dart';

import 'package:niku/niku.dart';
import 'package:get/get.dart';

import 'package:cat/services/heroFlight.dart';

import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import './styles.dart';

class CatInfo extends HookWidget {
  final CatModel cat;

  const CatInfo(
    this.cat, {
    Key? key,
  }) : super(key: key);

  @override
  build(context) {
    final ImagePicker picker = ImagePicker();
    final catBox = Hive.box<CatModel>("cat");

    final localImages = useState<List<Uint8List>>(cat.images);

    final closeDialog = () {
      Get.back();
      Get.back();
    };

    final removeCatImageAt = (int index) => () {
          final _copied = [...localImages.value];
          _copied.removeAt(index);
          // Remove at doesn't trigger re-render
          localImages.value = _copied;

          closeDialog();

          catBox.put(
            cat.name,
            CatModel(
              name: cat.name,
              type: cat.type,
              age: cat.age,
              owned: cat.owned,
              allergies: cat.allergies,
              cover: cat.cover,
              images: _copied,
            ),
          );
        };

    final brightness = MediaQuery.of(context).platformBrightness;

    return NikuColumn([
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
            ..builder(nikuHero("${cat.name} Type")),
      GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisSpacing: 16,
        padding: EdgeInsets.only(
          top: 24,
          left: 16,
          right: 16,
          bottom: 0,
        ),
        children: [
          createGridCard(
            title: "Age",
            data: "${cat.age} years",
            icon: Icons.cake,
            brightness: brightness,
          ),
          createGridCard(
            title: "Owned",
            data: cat.owned ? "Owned" : "Found",
            icon: cat.owned ? Icons.check : Icons.clear_rounded,
            brightness: brightness,
          )
        ],
      ),
      if (catWiki.containsKey(cat.type))
        createCustomCard(
          title: cat.type,
          data: NikuText("Read more on Wikipedia").fontSize(18).niku()..mt(8),
          icon: Icons.book_rounded,
          brightness: brightness,
        ).niku()
          ..on(tap: () async {
            final url = catWiki[cat.type];

            if (await canLaunch(url!)) await launch(url);
          })
          ..px(16)
          ..mt(8),
      NikuRow([
        Icon(
          Icons.image_outlined,
          color: Colors.grey.shade500,
        ).niku().mr(4),
        NikuText("Gallery")..fontSize(18),
      ]) //
          .itemsCenter()
          .niku()
            ..px(16)
            ..mt(16),
      GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        childAspectRatio: 1 / 1,
        children: [
          NikuButton.outlined(
            NikuColumn([
              Icon(
                Icons.add_rounded,
                size: 36,
                color: Colors.grey.shade500,
              ),
              NikuText("Add more") //
                  .color(Colors.grey.shade500)
                  .niku()
                    ..mt(8),
            ]).justifyCenter().itemsCenter(),
          ).onPressed(() async {
            final image = await picker.pickImage(
              source: ImageSource.gallery,
            );

            if (image == null) return;

            final imageBytes = await image.readAsBytes();

            localImages.value = [imageBytes, ...localImages.value];

            catBox.put(
              cat.name,
              CatModel(
                name: cat.name,
                type: cat.type,
                age: cat.age,
                owned: cat.owned,
                allergies: cat.allergies,
                cover: cat.cover,
                images: localImages.value,
              ),
            );
          })
            ..splash(Colors.grey.shade200),
          ...localImages.value
              .asMap()
              .map(
                (index, image) => MapEntry(
                  index,
                  CatImage(
                    image: image,
                    closeDialog: closeDialog,
                    removeCatImage: removeCatImageAt(index),
                  ),
                ),
              )
              .values
              .toList(growable: false)
        ],
      ).niku()
        ..p(16),
    ]).niku()
      ..scrollable();
  }
}
