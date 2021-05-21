import 'package:flutter/material.dart';
import 'package:myjdmcar/config/app_colors.dart';
import 'package:myjdmcar/models/car_part_brand.dart';

class CarPartBrandItemContainer extends StatelessWidget {
  final CarPartBrandModel carPartBrand;
  const CarPartBrandItemContainer({Key key, this.carPartBrand})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.black, width: 1.5),
          borderRadius: BorderRadius.circular(10)
        ),
        height: 150,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Image.asset(
            "assets/images/${carPartBrand.image}",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
