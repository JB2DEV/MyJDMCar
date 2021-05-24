import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myjdmcar/api/api_client_test.dart';
import 'package:myjdmcar/config/app_colors.dart';
import 'package:myjdmcar/config/internationalization/app_localizations.dart';
import 'package:myjdmcar/models/car.dart';
import 'package:myjdmcar/models/car_part.dart';
import 'package:myjdmcar/models/car_part_type.dart';
import 'package:myjdmcar/provider/car_parts_type_provider.dart';
import 'package:myjdmcar/provider/user_car_provider.dart';
import 'package:myjdmcar/src/widgets/appbars/home_appbar.dart';
import 'package:myjdmcar/src/widgets/car_part/back_card_car_part.dart';
import 'package:myjdmcar/src/widgets/car_part/front_card_car_part.dart';
import 'package:myjdmcar/src/widgets/animations/page_flip_builder.dart';
import 'package:myjdmcar/src/widgets/home/home_drawer.dart';
import 'package:myjdmcar/src/widgets/home/home_filter_item.dart';
import 'package:myjdmcar/utils/utils.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future data;
  Future carPartsTypeData;
  Future userCarsData;
  ApiClientTest apiClientTest = ApiClientTest();
  String userName;

  @override
  void initState() {
    super.initState();
    carPartsTypeData = apiClientTest.getCarPartsTypeData();
    apiClientTest.getActualUserId().then((value) {
      setState(() {
        userCarsData = apiClientTest.getUserCarsData(value);
      });
    });

    apiClientTest.getActualUserName().then((value) {
      setState(() {
        userName = value;
      });
    });
    data = apiClientTest.getData(
        0, Provider.of<UserCarProvider>(context, listen: false).carId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: _drawer(), //HomeDrawer(),
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          HomeSliverAppbar(
            showDrawer: showDrawer,
          ),
          _carPartsTypeFilter(),
          SliverList(
              delegate: SliverChildListDelegate([
            FutureBuilder<List<CarPartModel>>(
                future: data,
                builder: (BuildContext context,
                    AsyncSnapshot<List<CarPartModel>> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Text('Input a URL to start');
                    case ConnectionState.waiting:
                      print("waiting");
                      return CircularProgressIndicator();
                    case ConnectionState.active:
                      print("active");
                      return Text('active');
                    case ConnectionState.done:
                      print("done");
                      if (snapshot.hasError) {
                        print("has Error");
                        return Text(
                          '${snapshot.error}',
                          style: TextStyle(color: Colors.red),
                        );
                      } else {
                        print(snapshot.data.toString());
                        List<CarPartModel> carParts = snapshot.data;
                        return GridView.builder(
                          shrinkWrap: true,
                          itemCount: carParts.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisExtent: 250),
                          itemBuilder: (BuildContext context, int index) {
                            final pageFlipKey =
                                GlobalKey<PageFlipBuilderState>();
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: PageFlipBuilder(
                                key: pageFlipKey,
                                frontBuilder: (_) => FrontCardCarPart(
                                  onFlip: () =>
                                      pageFlipKey.currentState?.flip(),
                                  carPart: carParts[index],
                                ),
                                backBuilder: (_) => BackCardCarPart(
                                  onFlip: () =>
                                      pageFlipKey.currentState?.flip(),
                                  carPart: carParts[index],
                                ),
                              ),
                            );
                          },
                        );
                      }
                  }
                  return CircularProgressIndicator();
                }),
          ])),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, "add_car_part_page"),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _drawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.green_jdm_arrow,
            ),
            child: Align(
              child: Text(capitalize(userName)),
              alignment: Alignment.bottomCenter,
            ),
          ),
          FutureBuilder<List<CarModel>>(
            future: userCarsData,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              print("SNAPSHOT ERROR");
              print(snapshot.error);
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Text('Input a URL to start');
                case ConnectionState.waiting:
                  print("waiting");
                  return CircularProgressIndicator();
                case ConnectionState.active:
                  print("active");
                  return Text('active');
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    print("has Error");
                    return Text(
                      '${snapshot.error}',
                      style: TextStyle(color: Colors.red),
                    );
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        List<CarModel> userCarsList = snapshot.data;

                        return ListTile(
                          leading: Icon(
                            Icons.drive_eta,
                            color: AppColors.green_jdm_arrow,
                            size: 35,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_sharp,
                            size: 18,
                            color: AppColors.green_jdm_arrow,
                          ),
                          title: Text(userCarsList[index].carBrand.name,
                              textAlign: TextAlign.center),
                          subtitle: Text(
                            userCarsList[index].carModel.name,
                            textAlign: TextAlign.center,
                          ),
                          onTap: () => _changeUserCar(
                              id: userCarsList[index].id,
                              carBrandName: userCarsList[index].carBrand.name,
                              carModelName: userCarsList[index].carModel.name),
                        );
                      },
                    );
                  }
              }
              return CircularProgressIndicator();
            },
          ),
          ListTile(
            leading: Icon(
              Icons.add,
              color: AppColors.green_jdm_arrow,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_sharp,
              size: 18,
              color: AppColors.green_jdm_arrow,
            ),
            title: Text(
                AppLocalizations.of(context).translate("homeDrawerAddCar"),
                textAlign: TextAlign.center),
            onTap: () {
              print("Navigate to create car");
              Navigator.pushNamed(context, "routeName");
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: AppColors.green_jdm_arrow,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_sharp,
              size: 18,
              color: AppColors.green_jdm_arrow,
            ),
            title: Text(
              AppLocalizations.of(context).translate("homeDrawerSettings"),
              textAlign: TextAlign.center,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            trailing: Icon(
              Icons.arrow_forward_ios_sharp,
              size: 18,
              color: AppColors.green_jdm_arrow,
            ),
            leading: Icon(
              Icons.login_outlined,
              color: AppColors.green_jdm_arrow,
            ),
            title: Text(
              AppLocalizations.of(context).translate("homeDrawerLogout"),
              textAlign: TextAlign.center,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _carPartsTypeFilter() {
    return SliverList(
        delegate: SliverChildListDelegate([
      Center(
        child: Container(
          color: AppColors.yellow_jdm_arrow,
          height: 60,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: FutureBuilder<List<CarPartTypeModel>>(
                future: carPartsTypeData,
                builder: (BuildContext context,
                    AsyncSnapshot<List<CarPartTypeModel>> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Text('Input a URL to start');
                    case ConnectionState.waiting:
                      print("waiting");
                      return CircularProgressIndicator();
                    case ConnectionState.active:
                      print("active");
                      return Text('active');
                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        print("has Error");
                        return Text(
                          '${snapshot.error}',
                          style: TextStyle(color: Colors.red),
                        );
                      } else {
                        List<CarPartTypeModel> carPartsTypeList = snapshot.data;
                        return ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: carPartsTypeList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: GestureDetector(
                                  onTap: () => _changeFilter(index),
                                  child: HomeFilterItem(
                                    index: index,
                                    item: carPartsTypeList[index],
                                  )),
                            );
                          },
                        );
                      }
                  }
                  return CircularProgressIndicator();
                }),
          ),
        ),
      )
    ]));
  }

  ///Función para mostrar el drawer / menú lateral
  void showDrawer() {
    _scaffoldKey.currentState.openDrawer();
  }

  ///Función que cambia el tipo de pieza que queremos mostrar
  void _changeFilter(int index) {
    setState(() {
      Provider.of<CarPartsFilterProvider>(context, listen: false).currentIndex =
          index;
      data = apiClientTest.getData(
          Provider.of<CarPartsFilterProvider>(context, listen: false)
              .currentIndex,
          Provider.of<UserCarProvider>(context, listen: false).carId);
    });
  }

  void _changeUserCar({int id, String carBrandName, String carModelName}) {
    print(id);
    Provider.of<UserCarProvider>(context, listen: false).carId = id;
    Provider.of<UserCarProvider>(context, listen: false).carModel =
        carBrandName + " " + carModelName;
    print(Provider.of<UserCarProvider>(context, listen: false).carModel);
    data = apiClientTest.getData(
        0, Provider.of<UserCarProvider>(context, listen: false).carId);

    Navigator.pop(context);
  }
}
