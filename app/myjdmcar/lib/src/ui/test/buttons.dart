import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myjdmcar/config/app_colors.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:myjdmcar/config/globals.dart';
import 'package:myjdmcar/src/widgets/form/textformfields/email_textformfield.dart';
import 'package:myjdmcar/src/widgets/form/textformfields/password_textformfield.dart';

class AppButtons extends StatelessWidget {
  const AppButtons({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              ElevatedButton(onPressed: selectAll, child: Text("testSelect")),
              ElevatedButton(onPressed: insertOne, child: Text("testInsert")),
              ElevatedButton(
                  onPressed: selectOne, child: Text("testSelectOne")),
              ElevatedButton(onPressed: selectAll, child: Text("testDelete")),
              SizedBox(
                height: 20,
              ),
              EmailTextFormField(),
              SizedBox(
                height: 20,
              ),
              PasswordTextFormField()
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
    );
  }

  void selectAll() async {
    var url = '10.0.2.2:80';
    var test = '/test/usuario.php';
    final response = await http.post(Uri.http(url, test));
    final decodedJson = await json.decode(response.body);
    print(decodedJson);
  }

  void insertOne() async {
    var url = '10.0.2.2:80';
    var test = '/test/insert.php';
    Map<String, dynamic> toJson() =>
        {'user': variable1, 'email': variable1, 'pass': variable2};
    final response = await http.post(Uri.http(url, test), body: toJson());
    final decodedJson = await json.decode(response.body);
    print(decodedJson);
  }

  void selectOne() async {
    var url = '10.0.2.2:80';
    var test = '/test/getOne.php';
    Map<String, dynamic> toJson() => {'user': variable1};
    final response = await http.post(Uri.http(url, test), body: toJson());
    final decodedJson = await json.decode(response.body);
    print(decodedJson);
  }
}
