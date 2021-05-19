import 'package:flutter/material.dart';
import 'package:myjdmcar/config/app_colors.dart';
import 'package:myjdmcar/models/car_part.dart';

class AddCarPartItemContainer extends StatelessWidget {
  final CarPartModel carPart;

  const AddCarPartItemContainer({Key key, this.carPart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 150,
        color: AppColors.greyLight,
        child: Row(
          children: [
            Container(
              width: 180,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/" + carPart.image))),
            ),
            Container(
              child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      carPart.name,
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
