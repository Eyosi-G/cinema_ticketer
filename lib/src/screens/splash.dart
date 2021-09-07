import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/config.dart';
import './screens.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void didChangeDependencies() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final jsonData = preferences.getString(STORAGE_KEY);
      if (jsonData.isNotEmpty) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          Home.routeName,
          ModalRoute.withName(Home.routeName),
        );
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil(
          Login.routeName,
          ModalRoute.withName(Login.routeName),
        );
      }
    } catch (e) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        Login.routeName,
        ModalRoute.withName(Login.routeName),
      );
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Text('loading'),
      ),
    );
  }
}
