import 'package:flutter/material.dart';
import 'package:instagram_bloc/screens/screens.dart';

class CustomRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print("Route is ${settings.name}");
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          settings: const RouteSettings(
            name: '/'
          ),
          builder: (_) => Scaffold(),);
        break;
      case SplashScreen.routeName:
        return SplashScreen.route();

      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
          settings: const RouteSettings(
            name: '/error'
          ),
          builder: (_) => Scaffold(
            appBar: AppBar(
              title: const Text('Error'),
            ),
            body: Center(
              child: Text('Something went wrong'),
            ),
          ),);
  }
}
