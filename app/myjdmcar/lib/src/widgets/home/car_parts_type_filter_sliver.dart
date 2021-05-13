import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myjdmcar/config/app_colors.dart';
import 'package:myjdmcar/models/car_parts_model.dart';
import 'package:myjdmcar/provider/car_parts_type_provider.dart';
import 'package:provider/provider.dart';

class CarPartsTypeFilter extends StatefulWidget {
  CarPartsTypeFilter({Key key}) : super(key: key);

  @override
  _CarPartsTypeFilterState createState() => _CarPartsTypeFilterState();
}

class _CarPartsTypeFilterState extends State<CarPartsTypeFilter> {

  List<CarPartsTypeModel> carPartsTypeList;
  Future carPartsType;
  Future getData() async {
    final result =
        await rootBundle.loadString('assets/data/car_parts_type.json');
    print(result);
    final data = json.decode(result);
    print(data);
    carPartsTypeList = (data['data'] as List)
        .map((i) => new CarPartsTypeModel.fromJson(i))
        .toList();

    return data;
  }

  @override
  void initState() {
    carPartsType = getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildListDelegate([
      Center(
        child: Container(
          color: AppColors.yellow_jdm_arrow,
          height: 60,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: FutureBuilder(
              future: carPartsType,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  print("Has data");
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: carPartsTypeList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: GestureDetector(
                            onTap: () {
                              setState(() {
                                Provider.of<CarPartsFilterProvider>(context,
                                        listen: false)
                                    .currentIndex = index;
                                //_visibleBusiness = listBusiness[index]; //List of all business type. We can see this list in globals.dart, in BackOffice section
                              });
                            },
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/" +
                                      carPartsTypeList[index].icon,
                                  height: 30,
                                  width: 30,
                                  color: Provider.of<CarPartsFilterProvider>(
                                                  context,
                                                  listen: false)
                                              .currentIndex ==
                                          index
                                      ? AppColors.green_jdm_arrow
                                      : AppColors.black,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  carPartsTypeList[index].name,
                                  style: TextStyle(
                                      color:
                                          Provider.of<CarPartsFilterProvider>(
                                                          context,
                                                          listen: false)
                                                      .currentIndex ==
                                                  index
                                              ? AppColors.green_jdm_arrow
                                              : AppColors.black),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                              ],
                            )),
                      );
                    },
                  );
                }
                print("No data");
                return CircularProgressIndicator();
              },
            ),
          ),
        ),
      )
    ]));
  }
}
