import 'package:flutter/material.dart';
import 'package:myjdmcar/models/car_part_brand.dart';

class CarPartBrandItemContainer extends StatelessWidget {
  final CarPartBrandModel carPartBrand;
  const CarPartBrandItemContainer({Key key, this.carPartBrand}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        color: Colors.lightBlue,
        width: double.infinity,
        child: Image.asset("assets/images/${carPartBrand.image}"));
  }
}
