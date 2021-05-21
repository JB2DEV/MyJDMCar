import 'package:flutter/material.dart';
import 'package:myjdmcar/api/api_client_test.dart';
import 'package:myjdmcar/config/app_colors.dart';
import 'package:myjdmcar/src/widgets/buttons/theme_button.dart';
import 'package:myjdmcar/src/widgets/car_part/add_car_part_item.dart';
import 'package:myjdmcar/src/widgets/part_brand/part_brand_item_container.dart';

class AddCarPartPage extends StatefulWidget {
  AddCarPartPage({Key key}) : super(key: key);

  @override
  _AddCarPartPageState createState() => _AddCarPartPageState();
}

class _AddCarPartPageState extends State<AddCarPartPage> {
  List<Widget> items = [];
  Future data;
  ApiClientTest apiTest = ApiClientTest();
  bool carPartBrandSelected = false;
  bool carPartSelected = false;
  DismissDirection direction;

  @override
  void initState() {
    super.initState();
    data = apiTest.addCarPartDynamic(
        carPartBrandSelected, carPartSelected, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Añadir pieza",
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(Icons.notification_important),
          )
        ],
      ),
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverList(
              delegate: SliverChildListDelegate([
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return items[index];
              },
            ),
            FutureBuilder(
              future: data,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Container();
                  case ConnectionState.waiting:
                    print("waiting");
                    return Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                      ],
                    ));
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
                      List<dynamic> dataList = snapshot.data;
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: dataList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                                onTap: () => _checkItemsStateAndAddItems(
                                    direction, dataList[index]),
                                child: carPartBrandSelected
                                    ? AddCarPartItemContainer(
                                        carPart: dataList[index])
                                    : CarPartBrandItemContainer(
                                        carPartBrand: dataList[index],
                                      )),
                          );
                        },
                      );
                    }
                }
                return CircularProgressIndicator();
              },
            ),
            SizedBox(height: 40,),
            getAddButton(addCarPart),
          ]))
        ],
      ),
    );
  }

  ///Función que carga los datos de las marcas o las piezas según el estado de la lista de seleccionados y
  ///añade la marca o la pieza a esta lista
  void _checkItemsStateAndAddItems(DismissDirection direction, dynamic item) {
    setState(() {
      if (items.isEmpty) {
        carPartBrandSelected = true;
        direction = DismissDirection.endToStart;
        CarPartBrandItemContainer newItem = CarPartBrandItemContainer(
          carPartBrand: item,
        );
        _addItem(newItem, direction, MainAxisAlignment.end);
        data = apiTest.addCarPartDynamic(
            carPartBrandSelected, carPartSelected, context);
      } else {
        carPartSelected = true;
        direction = DismissDirection.startToEnd;
        AddCarPartItemContainer newItem = AddCarPartItemContainer(
          carPart: item,
        );
        _addItem(newItem, direction, MainAxisAlignment.start);
        data = null;
      }
    });
  }

  /// Función que añade un widget (marca o pieza) a la lista de seleccionados
  void _addItem(Widget newItem, DismissDirection direction,
      MainAxisAlignment axisAligment) {
    items.add(
      Dismissible(
          direction: direction,
          background: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  mainAxisAlignment: axisAligment,
                  children: [
                    Icon(
                      Icons.delete,
                      color: AppColors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Delete".toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: AppColors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
          onDismissed: (DismissDirection direction) =>
              _checkDismissDirection(direction),
          key: Key(newItem.toString()),
          child: newItem),
    );
  }

  void _checkDismissDirection(DismissDirection direction) {
    setState(() {
      if (direction == DismissDirection.endToStart) {
        items.clear();
        carPartBrandSelected = false;
        carPartSelected = false;
        data = apiTest.addCarPartDynamic(
            carPartBrandSelected, carPartSelected, context);
      } else {
        items.removeAt(1);
        carPartSelected = false;
        data = apiTest.addCarPartDynamic(
            carPartBrandSelected, carPartSelected, context);
      }
    });
  }

  void addCarPart(){
    print("Added");
    Navigator.pop(context);
  }

  Widget getAddButton(Function function) {
    if (carPartBrandSelected && carPartSelected) {
      return SizedBox(
        height: 40,
        child: ThemeButton(
          buttonText: "Añadir",
          function: function,
        ),
      );
    }else{
      return Container();
    }
  }
}
