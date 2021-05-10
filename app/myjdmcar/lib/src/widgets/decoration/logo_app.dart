import 'package:flutter/material.dart';

class LogoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.contain, image: AssetImage('assets/images/logo_provisional.png'))),
    );
  }
}
