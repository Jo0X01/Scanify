import 'package:flutter/material.dart';

abstract class AppRoutes {
  static final routeObserver = RouteObserver<ModalRoute<void>>();

  static const String appRoute = '/';
  static const String scanScreen = '/scan';
  static const String detailsScreen = '/details';
  static const String generateScreen = '/generate';
  static const String historyScreen = '/history';
  static const String settingsScreen = '/settings';
  static const String templateScreen = '/generate-template';

  static Future navigateToSettings(BuildContext context) {
    return Navigator.of(context).pushNamed(AppRoutes.settingsScreen);
  }

  static Route<dynamic>? pureNavigateRoute(Widget screen) {
    return MaterialPageRoute(builder: (_) => screen);
  }

  static Future<T?> navigate<T extends Object?>(
    BuildContext context,
    Widget screen,
  ) {
    return Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => screen));
  }

  static Future<T?> navigateTo<T>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.of(context).pushNamed<T>(routeName, arguments: arguments);
  }

  static Future<T?> replaceWith<T>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.of(
      context,
    ).pushReplacementNamed<T, dynamic>(routeName, arguments: arguments);
  }

  static void goBack<T>(BuildContext context, [T? result]) {
    Navigator.of(context).pop(result);
  }

  static void popUntil(BuildContext context, String routeName) {
    Navigator.of(context).popUntil(ModalRoute.withName(routeName));
  }

  static void registerObserver(RouteAware screen, BuildContext context) {
    routeObserver.unsubscribe(screen);
    routeObserver.subscribe(screen, ModalRoute.of(context)!);
  }

  static void unregisterObserver(RouteAware screen) {
    routeObserver.unsubscribe(screen);
  }
}
