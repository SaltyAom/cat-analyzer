import 'package:flutter/material.dart';

import 'package:niku/niku.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

import 'package:cat/models/cat.dart';
import 'package:cat/services/heroFlight.dart';

class CatCard extends HookWidget {
  final CatModel cat;
  final VoidCallback toCatPage;
  final int index;

  const CatCard(
    this.cat, {
    Key? key,
    required this.toCatPage,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final animation = useAnimationController(
      initialValue: 0,
    );

    useEffect(() {
      Future.delayed(Duration(milliseconds: index * 120)).then((_) {
        animation.animateTo(
          1,
          curve: Curves.easeOutQuad,
          duration: Duration(
            milliseconds: 300,
          ),
        );
      });
    }, []);

    return Container(
      key: key,
      color: Colors.black,
      child: NikuStack([
        Image.memory(
          cat.cover,
          fit: BoxFit.cover,
        ).niku()
          ..heroTag("${cat.name} Image")
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
                ..builder(nikuHero("${cat.name} Name"))
                ..mb(4),
          NikuText(cat.type) //
              .fontSize(16)
              .color(Colors.grey.shade400)
              .niku()
                ..builder(nikuHero("${cat.name} Type"))
        ]).justifyEnd().itemsStart().niku()
          ..p(16)
      ]),
    ).niku()
      ..rounded(8)
      ..animated(
        animation,
        (context, child) => child.niku()
          ..builder(
            (child) => Transform.translate(
              offset: Offset(0, 24 - 24 * animation.value),
              child: child,
            ),
          )
          ..builder(
            (child) => child.niku()..opacity(animation.value),
          ),
      )
      ..on(tap: toCatPage);
  }
}
