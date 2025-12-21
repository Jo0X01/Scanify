import 'package:flutter/material.dart';

abstract class AppRoutes {
  static const String appRoute = "/app";
  static const String scanScreenRoute = "/ScanScreen";
  static const String detailsScreen = "/DetailsScreen";


  static void navigateTo(
    BuildContext context,
    String routeName,
    {
      Object? arguments,
      bool replacement = false
    }
  ){
    final navigat = Navigator.of(context);
    if(replacement){
      navigat.pushReplacementNamed(routeName,arguments: arguments);
      return;
    }
    navigat.pushNamed(routeName,arguments: arguments);
  }
}
