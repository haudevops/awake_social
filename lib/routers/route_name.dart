import 'package:awake_social/page/navigation_pages.dart';
import 'package:awake_social/page/page_export.dart';
import 'package:awake_social/page/people_social/people_social_page.dart';
import 'package:awake_social/routers/screen_arguments.dart';
import 'package:awake_social/routers/slide_left_route.dart';
import 'package:flutter/material.dart';

class RouterSettings {
  static Route<dynamic> allRoutes(RouteSettings settings) {
    late ScreenArguments arg;
    final Object? arguments = settings.arguments;
    if (arguments != null) {
      arg = arguments as ScreenArguments;
    }
    switch (settings.name) {
      case SplashPage.routeName:
        return SlideLeftRoute(const SplashPage());
      case LoginPage.routeName:
        return SlideLeftRoute(const LoginPage());
      case HomePage.routeName:
        return SlideLeftRoute(HomePage());
      case NavigationPage.routeName:
        return SlideLeftRoute(const NavigationPage());
      case PeopleSocialPage.routeName:
        return SlideLeftRoute(const PeopleSocialPage());
      case LivePage.routeName:
        return SlideLeftRoute(const LivePage());
      case NotificationPage.routeName:
        return SlideLeftRoute(const NotificationPage());
      case SettingPage.routeName:
        return SlideLeftRoute(const SettingPage());
      default:
        throw ('this routers name does not exist');
    }
  }
}
