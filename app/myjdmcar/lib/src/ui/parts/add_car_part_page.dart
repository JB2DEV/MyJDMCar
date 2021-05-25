import 'package:flutter/material.dart';
import 'package:myjdmcar/api/api_client_test.dart';
import 'package:myjdmcar/config/app_colors.dart';
import 'package:myjdmcar/config/internationalization/app_localizations.dart';
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
  List<dynamic> dataList;
  List<dynamic> visibleItems;
  Future data;
  ApiClientTest apiTest = ApiClientTest();
  bool carPartBrandSelected = false;
  bool carPartSelected = false;
  DismissDirection direction;
  final TextEditingController _textController = TextEditingController();
  bool focus = false;
  int idPieza = -1;

  @override
  void initState() {
    super.initState();
    dataList = [];
    visibleItems = [];
    data = apiTest.listCarPartDynamic(
        carPartBrandSelected, carPartSelected, context, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: [
            SliverAppBar(
              backgroundColor: AppColors.green_jdm_arrow,
              floating: true,
              pinned: false,
              snap: false,
              elevation: 0,
              centerTitle: true,
              title: Text(
                AppLocalizations.of(context).translate("addCarPartPageTitle"),
                style: Theme.of(context).textTheme.headline6,
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: IconButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, "car_part_request_page"),
                      icon: Icon(Icons.notification_important)),
                )
              ],
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              _searchDelegate(),
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
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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
                        dataList = snapshot.data;
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: visibleItems.isEmpty
                              ? dataList.length
                              : visibleItems.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                                onTap: () => _checkItemsStateAndAddItems(
                                    direction, dataList[index]),
                                child: carPartBrandSelected
                                    ? AddCarPartItemContainer(
                                        carPart: visibleItems.isEmpty
                                            ? dataList[index]
                                            : visibleItems[index])
                                    : CarPartBrandItemContainer(
                                        carPartBrand: visibleItems.isEmpty
                                            ? dataList[index]
                                            : visibleItems[index],
                                      ));
                          },
                        );
                      }
                  }
                  return CircularProgressIndicator();
                },
              ),
              SizedBox(
                height: 40,
              ),
              getAddButton(addCarPart),
            ]))
          ],
        ),
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
        _addItem(
            newItem, direction, MainAxisAlignment.end, newItem.carPartBrand.id);
        data = apiTest.listCarPartDynamic(carPartBrandSelected, carPartSelected,
            context, newItem.carPartBrand.id);
      } else {
        carPartSelected = true;
        direction = DismissDirection.startToEnd;
        AddCarPartItemContainer newItem = AddCarPartItemContainer(
          carPart: item,
        );
        _addItem(newItem, direction, MainAxisAlignment.start, 0);
        data = null;
        idPieza = newItem.carPart.id;
      }
    });
  }

  /// Función que añade un widget (marca o pieza) a la lista de seleccionados
  void _addItem(Widget newItem, DismissDirection direction,
      MainAxisAlignment axisAligment, int brandId) {
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
              _checkDismissDirection(direction, brandId),
          key: Key(newItem.toString()),
          child: newItem),
    );
    FocusScope.of(context).unfocus();
  }

  ///Función que obtiene las marcas de las piezas o las piezas según
  ///la dirección de borrado
  void _checkDismissDirection(DismissDirection direction, int brandId) {
    setState(() {
      if (direction == DismissDirection.endToStart) {
        items.clear();
        carPartBrandSelected = false;
        carPartSelected = false;
        data = apiTest.listCarPartDynamic(
            carPartBrandSelected, carPartSelected, context, 0);
      } else {
        items.removeAt(1);
        carPartSelected = false;
        data = apiTest.listCarPartDynamic(
            carPartBrandSelected, carPartSelected, context, brandId);
      }
    });
  }

  ///Función que añade la pieza al coche actualdel usuario
  void addCarPart(int idPieza) {
    print("Added");
    apiTest.addCarPart(context, idPieza);
    Navigator.pop(context);
  }

  ///Método que devuelve el botón para añadir si se ha seleccionado
  ///la marca y la pieza
  Widget getAddButton(Function function) {
    if (carPartBrandSelected && carPartSelected) {
      return SizedBox(
        height: 40,
        child: ThemeButton(
          buttonText: "Añadir",
          function: function,
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _searchDelegate() {
    return Container(
      height: 50,
      color: AppColors.green_jdm_arrow,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.white),
          child: TextField(
            controller: _textController,
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.bottom,
            cursorColor: Colors.grey,
            cursorWidth: 1,
            decoration: InputDecoration(
                fillColor: Colors.grey[200],
                hintText: "Search",
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
                focusColor: Colors.grey,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1.5,
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(20)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1.5,
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(20)),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                )),
            onChanged: (value) {
              print(_textController.text);
              setState(() {
                print(value);
                if (value.isEmpty) {
                  visibleItems = [];
                } else {
                  visibleItems = dataList
                      .where((item) => item.name
                          .toString()
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                }
              });
            },
          ),
        ),
      ),
    );
  }
}
