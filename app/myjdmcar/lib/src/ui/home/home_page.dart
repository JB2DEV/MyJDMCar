import 'package:flutter/material.dart';
import 'package:myjdmcar/api/api_client_test.dart';
import 'package:myjdmcar/config/app_colors.dart';
import 'package:myjdmcar/models/car_part.dart';
import 'package:myjdmcar/models/car_part_type.dart';
import 'package:myjdmcar/provider/car_parts_type_provider.dart';
import 'package:myjdmcar/src/widgets/appbars/home_appbar.dart';
import 'package:myjdmcar/src/widgets/car_part/back_card_car_part.dart';
import 'package:myjdmcar/src/widgets/car_part/front_card_car_part.dart';
import 'package:myjdmcar/src/widgets/animations/page_flip_builder.dart';
import 'package:myjdmcar/src/widgets/home/home_drawer.dart';
import 'package:myjdmcar/src/widgets/home/home_filter_item.dart';
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
  ApiClientTest apiTest = ApiClientTest();

  @override
  void initState() {
    super.initState();
    carPartsTypeData = apiTest.getCarPartsTypeData();
    data = apiTest.getData(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: HomeDrawer(),
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
      data = apiTest.getData(
          Provider.of<CarPartsFilterProvider>(context, listen: false)
              .currentIndex);
    });
  }
}
