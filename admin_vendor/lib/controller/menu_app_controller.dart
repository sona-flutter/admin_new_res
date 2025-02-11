// in menu_app_controller.dart
import 'package:flutter/material.dart';

class MenuAppController extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  String _currentRoute = '/dashboard';
  String get currentRoute => _currentRoute;

  void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }

  void navigateTo(BuildContext context, String route) {
    _currentRoute = route;
    Navigator.pushNamed(context, route);
    notifyListeners();
  }
}
