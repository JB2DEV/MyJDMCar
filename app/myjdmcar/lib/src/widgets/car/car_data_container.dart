import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myjdmcar/config/app_colors.dart';

class CarDataContainer extends StatelessWidget {

  final String icon;
  final String text;
  const CarDataContainer({Key key, this.icon, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.green_jdm_arrow,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            height: 60,
            width: 60,
          ),
          SizedBox(height: 5,),
          Text(text, style: Theme.of(context).textTheme.bodyText1,)
        ],
      ),
    );
  }
}
