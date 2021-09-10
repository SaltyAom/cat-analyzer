import 'package:flutter/material.dart';

import 'package:niku/niku.dart';

Niku Function(Widget child) cardStyle(Brightness brightness) =>
    (child) => child.niku()
      ..fullWidth()
      ..p(16)
      ..bg(
        brightness == Brightness.light
            ? Colors.grey.shade200
            : Colors.grey.shade800,
      )
      ..rounded(8);

Widget createGridCard({
  required String title,
  required String data,
  required IconData icon,
  required Brightness brightness,
}) =>
    NikuColumn([
      NikuRow([
        Icon(
          icon,
          color: Colors.grey.shade500,
        ).niku()
          ..mr(4),
        NikuText(title)
          ..fontSize(16)
          ..w600()
          ..color(Colors.grey.shade500),
      ])
        ..itemsCenter(),
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
          ..builder(cardStyle(brightness))
          ..fullHeight();

Widget createCard({
  required String title,
  required String data,
  required IconData icon,
  required Brightness brightness,
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
          ..builder(cardStyle(brightness));

Widget createCustomCard({
  required String title,
  required Widget data,
  required IconData icon,
  required Brightness brightness,
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
      data
    ]) //
        .justifyStart()
        .itemsStart()
        .niku()
          ..builder(cardStyle(brightness))
          ..my(8);
