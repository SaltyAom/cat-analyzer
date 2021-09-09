import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:niku/niku.dart';
import 'package:get/get.dart';

import 'package:cat/models/cat.dart';

import 'package:cat/services/heroFlight.dart';

import './styles.dart';

class InDepthCat extends StatelessWidget {
  final CatModel cat;

  const InDepthCat(
    this.cat, {
    Key? key,
  }) : super(key: key);

  @override
  build(context) {
    // if (true)
    //   return NikuColumn([
    //     SvgPicture.asset(
    //       'assets/chilling.svg',
    //     ) //
    //         .niku()
    //         .fullWidth()
    //         .aspectRatio(2 / 1),
    //     NikuText(
    //       "Get premium to get more of your cat.\nMore feature like using HealthKit with your cat to track their step, frequent location, graph visualization and more!",
    //     ) //
    //         .fontSize(16)
    //         .color(Colors.grey.shade700)
    //         .center()
    //         .height(1.5)
    //         .niku()
    //           ..my(32)
    //           ..px(24),
    //     NikuButton.elevated(
    //       NikuText("Go Premium")
    //         ..fontSize(18)
    //         ..w600(),
    //     )
    //       ..onPressed(() {
    //         Get.dialog(
    //           Platform.isIOS
    //               ? CupertinoAlertDialog(
    //                   title: Text("Coming Soon"),
    //                   content: Text(
    //                     "Premium feature is coming soon in the future and not availble on beta yet.",
    //                   ),
    //                   actions: [
    //                     CupertinoButton(
    //                       child: Text("Ok"),
    //                       onPressed: () {
    //                         Get.back();
    //                       },
    //                     ),
    //                   ],
    //                 )
    //               : AlertDialog(
    //                   title: Text("Remove cat"),
    //                   content: Text(
    //                     "Premium feature is coming soon in the future and not availble on beta yet.",
    //                   ),
    //                   actions: [
    //                     NikuButton(Text("Ok"))
    //                       ..onPressed(() {
    //                         Get.back();
    //                       }),
    //                   ],
    //                 ),
    //         );
    //       })
    //       ..px(28)
    //       ..py(16),
    //   ])
    //     ..justifyCenter()
    //     ..itemsCenter();

    final brightness = MediaQuery.of(context).platformBrightness;

    return NikuColumn([
      NikuText(cat.name.capitalizeFirst!) //
          .fontSize(36)
          .w600()
          .niku()
            ..builder(nikuHero("${cat.name} Name"))
            ..mt(24)
            ..mb(12),
      NikuText(cat.type) //
          .fontSize(18)
          .color(Colors.grey.shade500)
          .niku()
            ..builder(nikuHero("${cat.name} Type"))
            ..mb(12),
      GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisSpacing: 16,
        children: [
          createGridCard(
            title: "Age",
            data: "${cat.age} years",
            icon: Icons.cake,
            brightness: brightness,
          ),
          createGridCard(
            title: "Weight",
            data: "3.6 kg",
            icon: Icons.arrow_downward_rounded,
            brightness: brightness,
          ),
          createGridCard(
            title: "Step",
            data: "4,216",
            icon: Icons.directions_walk_rounded,
            brightness: brightness,
          ),
          createGridCard(
            title: "Location",
            data: "Living Room",
            icon: Icons.pin_drop,
            brightness: brightness,
          ),
        ],
      ),
      Text("Notice"),
      createCard(
        title: "Energy",
        data: "${cat.name.capitalizeFirst!} tends to walk around more by 21%",
        icon: Icons.local_fire_department_rounded,
        brightness: brightness,
      ),
      createCard(
        title: "Energy",
        data:
            "${cat.name.capitalizeFirst!} tends to have lesser sleep than usual",
        icon: Icons.nightlight_round,
        brightness: brightness,
      ),
      Text("Condition").niku()..mt(16),
      GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisSpacing: 16,
        children: [
          createGridCard(
            title: "Sleep",
            data: "4 hours",
            icon: Icons.nightlight_round,
            brightness: brightness,
          ),
          createGridCard(
            title: "Max speed",
            data: "16 km/h",
            icon: Icons.speed_rounded,
            brightness: brightness,
          ),
        ],
      ),
    ]) //
        .justifyStart()
        .itemsStart()
        .niku()
          ..px(16)
          ..scrollable();
  }
}

class Weight {
  final double weight;
  final String date;

  const Weight(this.date, this.weight);
}
