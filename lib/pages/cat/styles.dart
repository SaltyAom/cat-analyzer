import 'package:flutter/material.dart';

import 'package:niku/niku.dart';

Niku Function(Widget child) cardStyle() => (child) => child.niku()
  ..fullWidth()
  ..p(16)
  ..bg(Colors.white)
  ..rounded(8)
  ..shadows([
    BoxShadow(
      offset: Offset(0, 4),
      blurRadius: 8,
      color: Colors.black.withOpacity(.0875),
    )
  ])
  ..my(8);

createGridCard({
  required String title,
  required String data,
  required IconData icon,
}) =>
    NikuColumn([
      NikuRow([
        Icon(
          icon,
          color: Colors.grey.shade500,
        ),
        NikuText(title)
          ..fontSize(16)
          ..w600()
          ..color(Colors.grey.shade500),
      ]),
      NikuText(data) //
          .fontSize(32)
          .w600()
          .mt(8)
          .niku()
          .centerLeft()
          .pb(16)
          .expanded()
    ]) //
        .justifyStart()
        .itemsStart()
        .niku()
          ..builder(cardStyle())
          ..fullHeight();

Widget createCard({
  required String title,
  required String data,
  required IconData icon,
}) =>
    NikuColumn([
      NikuRow([
        Icon(
          icon,
          color: Colors.grey.shade500,
        ),
        NikuText(title)
          ..fontSize(16)
          ..w600()
          ..color(Colors.grey.shade500),
      ]),
      NikuText(data) //
          .fontSize(24)
          .w600()
          .mt(8)
          .niku()
          .centerLeft()
          .pb(16)
    ]) //
        .justifyStart()
        .itemsStart()
        .niku()
          ..builder(cardStyle());
