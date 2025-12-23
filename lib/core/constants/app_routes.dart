import 'package:flutter/material.dart';

abstract class AppRoutes {
  static const String appRoute = "/app";
  static const String scanScreenRoute = "/ScanScreen";
  static const String detailsScreen = "/DetailsScreen";
  static const String generateScreen = "/GenerateScreen";
  static const String wifiScreen = "/WifiScreen";
  
  static const String businessScreen = '/BusinessScreen';
  static const String contactScreen = '/ContactScreen';
  static const String textScreen = '/TextScreen';
  static const String twitterScreen = '/TwitterScreen';
  static const String websiteScreen = '/WebsiteScreen';
  static const String whatsappScreen = '/WhatsAppScreen';
  static const String telephoneScreen = '/TelephoneScreen';
  static const String locationScreen = '/LocationScreen';
  static const String instagramScreen = '/InstagramScreen';
  static const String eventScreen = '/EventScreen';
  static const String emailScreen = '/EmailScreen';

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
