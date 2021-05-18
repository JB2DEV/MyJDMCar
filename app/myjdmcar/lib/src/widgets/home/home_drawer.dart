import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myjdmcar/config/app_colors.dart';
import 'package:myjdmcar/models/car.dart';
import 'package:myjdmcar/provider/user_car_provider.dart';
import 'package:provider/provider.dart';

class HomeDrawer extends StatefulWidget {
  HomeDrawer({Key key}) : super(key: key);

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  List<CarModel> userCarsList;
  Future userCarsData;
  Future getUserCarsData() async {
    final result = await rootBundle.loadString('assets/data/user_cars.json');
    print(result);
    final data = json.decode(result);
    print(data);
    userCarsList =
        (data['data'] as List).map((i) => new CarModel.fromJson(i)).toList();

    return data;
  }

  @override
  void initState() {
    super.initState();
    userCarsData = getUserCarsData();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.green_jdm_arrow,
            ),
            child: Align(
              child: Text('Username'),
              alignment: Alignment.bottomCenter,
            ),
          ),
          FutureBuilder(
            future: userCarsData,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: userCarsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
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
                          onTap: () {
                            print(userCarsList[index].id);
                            Provider.of<UserCarProvider>(context, listen: false)
                                .carId = userCarsList[index].id;
                            Provider.of<UserCarProvider>(context, listen: false)
                                .carModel = userCarsList[index].carBrand.name + " " + userCarsList[index].carModel.name;
                                print(Provider.of<UserCarProvider>(context, listen: false)
                                .carModel);
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
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
            title: Text('Añadir otro coche', textAlign: TextAlign.center),
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
              'Ajustes',
              textAlign: TextAlign.center,
            ),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
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
              'Logout',
              textAlign: TextAlign.center,
            ),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
