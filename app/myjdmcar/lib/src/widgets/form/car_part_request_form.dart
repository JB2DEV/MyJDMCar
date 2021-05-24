import 'package:flutter/material.dart';
import 'package:myjdmcar/src/widgets/form/textformfields/car_part_brand_textformfield.dart';

class CarPartRequestForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  CarPartRequestForm({Key key, @required this.formKey}) : super(key: key);

  @override
  _CarPartRequestFormState createState() => _CarPartRequestFormState();
}

class _CarPartRequestFormState extends State<CarPartRequestForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          SizedBox(height: 30,),
          CarPartBrandTextFormField(),
        ],
      ),
    );
  }
}
