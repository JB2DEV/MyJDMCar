import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:myjdmcar/api/api_client_test.dart';
import 'package:myjdmcar/config/app_colors.dart';
import 'package:myjdmcar/models/car.dart';
import 'package:myjdmcar/provider/user_car_provider.dart';
import 'package:myjdmcar/utils/utils.dart';
import 'package:provider/provider.dart';

class HomeDrawer extends StatefulWidget {
  HomeDrawer({Key key}) : super(key: key);

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  Future userCarsData;
  ApiClientTest apiClientTest = ApiClientTest();
  String userName;
  @override
  void initState() {
    super.initState();
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
              child: Text(capitalize(userName)),
              alignment: Alignment.bottomCenter,
            ),
          ),
          FutureBuilder<List<CarModel>>(
            future: userCarsData,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FocusedMenuHolder(
                              openWithTap: true,
                              menuOffset: 100,
                              blurSize: 2,
                              menuWidth: 200,
                              animateMenuItems: false,
                              duration: Duration(milliseconds: 200),
                              menuItems: <FocusedMenuItem>[
                                FocusedMenuItem(
                                    title: Text("Open Detail"),
                                    onPressed: () {},
                                    trailingIcon: Icon(Icons.open_in_new, color: AppColors.green_jdm_arrow,)),
                                FocusedMenuItem(
                                    title: Text("Delete", style: TextStyle(color: AppColors.white),),
                                    onPressed: () => _deleteCar(),
                                    backgroundColor: Colors.redAccent,
                                    trailingIcon: Icon(Icons.delete, color: AppColors.white,)),
                              ],
                              onPressed: null,
                              child: ListTile(
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
                                  Provider.of<UserCarProvider>(context,
                                          listen: false)
                                      .carId = userCarsList[index].id;
                                  Provider.of<UserCarProvider>(context,
                                              listen: false)
                                          .carModel =
                                      userCarsList[index].carBrand.name +
                                          " " +
                                          userCarsList[index].carModel.name;
                                  print(Provider.of<UserCarProvider>(context,
                                          listen: false)
                                      .carModel);
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ],
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

  void _deleteCar(){
    print("Delete car");
  }
}
