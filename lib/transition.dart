import 'package:flutter/material.dart';

// FADE ANIMATION
class FadeRoute extends PageRouteBuilder {
  final Widget page;
  @override
  final RouteSettings settings;
  FadeRoute({
    required this.page,
    required this.settings,
  }) : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          settings: settings,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}