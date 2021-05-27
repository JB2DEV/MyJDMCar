/*
 *  Security Pig is watching your horrible code
 *        _
 *        ((`)_.._     ,'-. _..._ _._
 *          \,'    '-._.-\  '     ` .-'
 *         .'            /         (
 *        /             |     _   _ \
 *       |              \     a   a  |
 *       ;                     .-.   /
 *        ;       ',       '-.( '')-'
 *         '.      |           ;-'
 *           \    /           /
 *           /   /-._  __,  7 |
 *           \  `\  \``  |  | |
 *            \   \_,\   |  |_,\
 *             '-`'      \_,\
 * 
 *  Please, fix it before it gets angry.
 */

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myjdmcar/api/api_client.dart';

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
import 'package:myjdmcar/src/widgets/filters/home_filter_item.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  ApiClient _apiClient = ApiClient();
  String userName = "";

  @override
  void initState() {
    super.initState();
    carPartsTypeData = _apiClient.getCarPartsTypeData();
    getUserData();
    data = _apiClient.getData(
        0, Provider.of<UserCarProvider>(context, listen: false).carId);
  }

  Future getUserData() async {
    await _apiClient.getActualUserId().then((value) {
      setState(() {
        userCarsData = _apiClient.getUserCarsData(value);
      });
    });
    await _apiClient.getActualUserName().then((value) {
      setState(() {
        userName = value;
      });
    });
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
                        List<CarPartModel> carParts = snapshot.data;
                        return GridView.builder(
                          shrinkWrap: true,
                          itemCount: carParts.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 30,
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
              child: Text(userName),
              alignment: Alignment.bottomCenter,
            ),
          ),
          FutureBuilder<List<CarModel>>(
            future: userCarsData,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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
              Navigator.pushNamed(context, "add_car_page");
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
              Navigator.popAndPushNamed(context, "buttons");
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
              _deleteToken(context);
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
                      return Container();
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
      data = _apiClient.getData(
          Provider.of<CarPartsFilterProvider>(context, listen: false)
              .currentIndex,
          Provider.of<UserCarProvider>(context, listen: false).carId);
    });
  }

  void _changeUserCar({int id, String carBrandName, String carModelName}) {
    Provider.of<UserCarProvider>(context, listen: false).carId = id;
    Provider.of<UserCarProvider>(context, listen: false).carModel =
        carBrandName + " " + carModelName;
    setState(() {
      data = _apiClient.getData(
          0, Provider.of<UserCarProvider>(context, listen: false).carId);
    });

    Navigator.pop(context);
  }

  void _deleteToken(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await _apiClient.logout();
    prefs.setString("accessToken", "").then((value) {
      Navigator.pop(context);
      Navigator.popAndPushNamed(context, "sign_in_page");
    });
  }
}
