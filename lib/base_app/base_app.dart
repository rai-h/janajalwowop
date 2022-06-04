import 'package:flutter/material.dart';
import 'package:janajaldoot/ui/screens/login_screen/login_screen.dart';

class BaseApp extends StatefulWidget {
  const BaseApp({Key? key}) : super(key: key);

  @override
  State<BaseApp> createState() => _BaseAppState();
}

class _BaseAppState extends State<BaseApp> {
  @override
  Widget build(BuildContext context) {
    return LoginScreen();
  }
}
