import 'package:flutter/material.dart';
import 'package:myjdmcar/src/widgets/form/car_part_request_form.dart';

class CarPartRequestPage extends StatelessWidget {
  const CarPartRequestPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text("CarPartNotFoundTitle"),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              CarPartRequestForm(
                formKey: _formKey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
