import 'package:flutter/material.dart';

class MenuOption {
  final String title;
  final String route;
  final Widget screen;

  const MenuOption({
    required this.title,
    required this.route,
    required this.screen,
  });
}
