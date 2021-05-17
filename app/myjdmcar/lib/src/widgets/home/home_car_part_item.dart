import 'package:flutter/material.dart';
import 'package:myjdmcar/config/app_colors.dart';
import 'package:myjdmcar/models/car_part.dart';

class HomeCarPartItem extends StatelessWidget {
  final CarPartModel carPart;
  const HomeCarPartItem({Key key, this.carPart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Container(
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
                        image: AssetImage(
                            "assets/images/car_parts/" + carPart.image))),
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
                      SizedBox(height: 10,),
                      SizedBox(height: 10,),
                      Text(carPart.carPartBrand.name)
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
