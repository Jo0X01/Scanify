import 'package:flutter/material.dart';
import 'package:scanify/core/services/route_service.dart';
import 'package:scanify/core/enum/app_routes.dart' show AppRouteKeys;
import 'package:scanify/core/l10n/app_localizations.dart';

extension XContextAddOns on BuildContext {
  AppLocalizations get l => AppLocalizations.of(this)!;
  MediaQueryData get mq => MediaQuery.of(this);
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorTheme => Theme.of(this).colorScheme;

  Future<void> goToSettings() =>
      RouteService.navigateTo(this, AppRouteKeys.settingsScreen.path);

  Future<void> goToDetails([Object? arguments]) => RouteService.navigateTo(
    this,
    AppRouteKeys.detailsScreen.path,
    arguments: arguments,
  );

  void goBack() => RouteService.goBack(this);
  Future<void> goTo(
    AppRouteKeys route, {
    Object? arguments,
    bool? replace,
  }) async {
    if (mounted) {
      if (replace ?? false) {
        await RouteService.replaceWith(this, route.path, arguments: arguments);
      } else {
        await RouteService.navigateTo(this, route.path, arguments: arguments);
      }
    }
  }
}
