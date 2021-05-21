import 'package:flutter/material.dart';
import 'package:myjdmcar/config/app_colors.dart';
import 'package:myjdmcar/models/car_part.dart';

class FrontCardCarPart extends StatelessWidget {
  final CarPartModel carPart;
  final VoidCallback onFlip;
  const FrontCardCarPart({Key key, @required this.carPart, @required this.onFlip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: AppColors.green_jdm_arrow,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black, width: 1.5)),
        child: Column(
          children: [
            Container(
              height: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8.5)),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image:
                          AssetImage("assets/images/" + carPart.image))),
            ),
            Container(
              decoration: BoxDecoration(
                  border:
                      Border(top: BorderSide(color: Colors.black, width: 1.5))),
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  carPart.name.toUpperCase(),
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 30,
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