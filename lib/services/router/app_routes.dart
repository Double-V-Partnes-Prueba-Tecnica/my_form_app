import 'package:flutter/material.dart';

import 'package:my_form_app/services/models/models.dart';
import 'package:my_form_app/flutter/screens/screens.dart';

class AppRoutes {
  static const initialRoute = '/';

  static const menuOptions = <MenuOption>[];

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    const home = MenuOption(
      title: 'Home',
      route: '/',
      screen: HomeScreen(),
    );

    Map<String, Widget Function(BuildContext)> appRoutes = {};
    // add home to list of routes
    appRoutes[home.route] = (context) => home.screen;
    for (final menuOption in menuOptions) {
      appRoutes[menuOption.route] = (context) => menuOption.screen;
    }

    return appRoutes;
  }

  static Route onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const HomeScreen(),
    );
  }
}
