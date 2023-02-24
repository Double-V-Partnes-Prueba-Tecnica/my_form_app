import 'package:flutter/material.dart';

import 'package:my_form_app/services/models/models.dart';
import 'package:my_form_app/flutter/screens/screens.dart';

class AppRoutes {
  static const initialRoute = '/';

  static const menuOptions = <MenuOption>[
    MenuOption(
      title: 'Home',
      route: '/home',
      screen: HomeScreen(),
    ),
    MenuOption(
      title: 'Singup',
      route: '/singup',
      screen: SingupScreen(),
    ),
    MenuOption(
      title: 'Login',
      route: '/login',
      screen: LoginScreen(),
    ),
  ];

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    const check = MenuOption(
      title: 'Check',
      route: '/',
      screen: CheckAuthScreen(),
    );
    Map<String, Widget Function(BuildContext)> appRoutes = {};
    // add login route
    appRoutes[check.route] = (context) => check.screen;
    for (final menuOption in menuOptions) {
      appRoutes[menuOption.route] = (context) => menuOption.screen;
    }
    return appRoutes;
  }

  static Route onGenerateRoute(RouteSettings settings) {
    // Borrar todo el stack de rutas y volver a la ruta inicial
    MaterialPageRoute(
      builder: (context) => const CheckAuthScreen(),
      settings: const RouteSettings(name: '/'),
    );
    return MaterialPageRoute(
      builder: (context) => const CheckAuthScreen(),
    );
  }
}
