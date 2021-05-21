import 'package:flutter/material.dart';
import 'package:myjdmcar/config/app_colors.dart';
import 'package:myjdmcar/models/car_part.dart';

class BackCardCarPart extends StatelessWidget {
  final CarPartModel carPart;
  final VoidCallback onFlip;
  const BackCardCarPart({Key key, @required this.carPart, @required this.onFlip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
            decoration: BoxDecoration(
                color: AppColors.green_jdm_arrow,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black, width: 1.5)),
            child: Column(
              children: [
                Container(
                  height: 120,
                  color: Colors.red,
                ),
                Text(
                  carPart.carPartBrand.name.toUpperCase(),
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
              ],
            ));
  }
}