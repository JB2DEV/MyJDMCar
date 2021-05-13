import 'package:flutter/material.dart';
import 'package:myjdmcar/src/widgets/appbars/home_appbar.dart';
import 'package:myjdmcar/src/widgets/home/car_parts_type_filter_sliver.dart';
import 'package:myjdmcar/src/widgets/home/home_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: HomeDrawer(),
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [HomeSliverAppbar(showDrawer: showDrawer,), CarPartsTypeFilter()],
      ),
    );
  }

  ///Función para mostrar el drawer / menú lateral
  void showDrawer(){
    _scaffoldKey.currentState.openDrawer();
  }

}
