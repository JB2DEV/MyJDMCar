import 'package:flutter/material.dart';
import 'package:myjdmcar/models/car_brand.dart';
import 'package:myjdmcar/models/car_model.dart';
import 'package:myjdmcar/src/widgets/form/add_car_form.dart';

class AddCarPage extends StatefulWidget {
  const AddCarPage({Key key}) : super(key: key);

  @override
  _AddCarPageState createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add car title"),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 100),
            child: Column(
              children: [
                AddCarForm(
                  formKey: _formKey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
