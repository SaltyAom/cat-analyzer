import 'package:flutter/material.dart';

Widget _flightShuttleBuilder(
  BuildContext flightContext,
  Animation<double> animation,
  HeroFlightDirection flightDirection,
  BuildContext fromHeroContext,
  BuildContext toHeroContext,
) =>
    DefaultTextStyle(
      style: DefaultTextStyle.of(toHeroContext).style,
      child: toHeroContext.widget,
    );

Widget Function(Widget child) nikuHero(String tag) => (child) => Hero(
      tag: tag,
      child: child,
      flightShuttleBuilder: _flightShuttleBuilder,
    );
