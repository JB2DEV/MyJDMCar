import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myjdmcar/config/app_colors.dart';
import 'package:myjdmcar/models/car_part_type.dart';
import 'package:myjdmcar/provider/car_parts_type_provider.dart';
import 'package:provider/provider.dart';

class HomeFilterItem extends StatelessWidget {
  final CarPartTypeModel item;
  final int index;

  const HomeFilterItem({Key key, this.item, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          "assets/icons/" + item.icon,
          height: 30,
          width: 30,
          color: Provider.of<CarPartsFilterProvider>(context, listen: false)
                      .currentIndex ==
                  index
              ? AppColors.green_jdm_arrow
              : AppColors.black,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          item.name,
          style: TextStyle(
              color: Provider.of<CarPartsFilterProvider>(context, listen: false)
                          .currentIndex ==
                      index
                  ? AppColors.green_jdm_arrow
                  : AppColors.black),
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
