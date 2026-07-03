import 'package:flutter/material.dart';

abstract class RouteService {
  static final routeObserver = RouteObserver<ModalRoute<void>>();
  static final rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

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
    ScaffoldMessenger.of(context).clearMaterialBanners();
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
