import 'package:flutter/material.dart';
import './src/screens/screens.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Home.routeName:
      return MaterialPageRoute(
        builder: (ctx) {
          return Home();
        },
      );

    case Login.routeName:
      return MaterialPageRoute(
        builder: (ctx) {
          return Login();
        },
      );
  }
}
