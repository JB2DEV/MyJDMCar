import 'package:flutter/material.dart';
import 'package:myjdmcar/src/widgets/form/textformfields/car_part_brand_textformfield.dart';
import 'package:myjdmcar/src/widgets/form/textformfields/car_part_textformfield.dart';
import 'package:myjdmcar/src/widgets/form/textformfields/other_info_textformfield.dart';

class CarPartRequestForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController carPartBrandController;
  final TextEditingController carPartController;
  final TextEditingController otherInfoController;

  CarPartRequestForm(
      {Key key,
      @required this.formKey,
      @required this.carPartBrandController,
      @required this.carPartController,
      @required this.otherInfoController})
      : super(key: key);

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
          SizedBox(
            height: 30,
          ),
          CarPartBrandTextFormField(controller: widget.carPartBrandController),
          SizedBox(
            height: 30,
          ),
          CarPartTextFormField(controller: widget.carPartController),
          SizedBox(
            height: 30,
          ),
          OtherInfoTextFormField(controller: widget.otherInfoController,),
        ],
      ),
    );
  }
}
