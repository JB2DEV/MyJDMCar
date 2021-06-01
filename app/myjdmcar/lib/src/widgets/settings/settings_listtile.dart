import 'package:flutter/material.dart';

class SettingsListTile extends StatelessWidget {

  final String title;
  final String routeName;

  const SettingsListTile({Key key, @required this.title, @required this.routeName}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20),
      title: Text(title, style: TextStyle(color: Colors.black, fontSize: 18),),
      trailing: Icon(Icons.arrow_forward_ios_rounded, size: 20, color: Colors.black,),
      onTap: () => Navigator.pushNamed(context, routeName),
    );
  }
}
