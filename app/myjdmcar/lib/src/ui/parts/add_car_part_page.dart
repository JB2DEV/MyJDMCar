import 'package:flutter/material.dart';
import 'package:myjdmcar/api/api_client.dart';
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
  ApiClient _apiClient = ApiClient();
  bool carPartBrandSelected = false;
  bool carPartSelected = false;
  final TextEditingController _textController = TextEditingController();
  bool search = false;
  int idCarPart = 0;
  int idCarPartBrand = 0;

  @override
  void initState() {
    super.initState();
    dataList = [];
    visibleItems = [];
    data = _apiClient.listCarPartDynamic(
        carPartBrandSelected, carPartSelected, context, idCarPartBrand);
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
              expandedHeight: 60,
              backgroundColor: AppColors.green_jdm_arrow,
              floating: true,
              pinned: false,
              snap: false,
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
                padding: EdgeInsets.only(top: 10),
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
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              search ? visibleItems.length : dataList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                                onTap: () => _checkItemsStateAndAddItems(
                                     visibleItems.isNotEmpty
                                            ? visibleItems[index]
                                            : dataList[index]),
                                child: carPartBrandSelected
                                    ? AddCarPartItemContainer(
                                        carPart: visibleItems.isNotEmpty
                                            ? visibleItems[index]
                                            : dataList[index])
                                    : CarPartBrandItemContainer(
                                        carPartBrand: visibleItems.isNotEmpty
                                            ? visibleItems[index]
                                            : dataList[index]));
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

  ///Funci??n que carga los datos de las marcas o las piezas seg??n el estado de la lista de seleccionados y
  ///a??ade la marca o la pieza a esta lista
  void _checkItemsStateAndAddItems(dynamic item) {
    print("ITEM NAME " + item.name);
    setState(() {
      if (items.isEmpty) {
        carPartBrandSelected = true;
        DismissDirection direction = DismissDirection.endToStart;
        CarPartBrandItemContainer newItem = CarPartBrandItemContainer(
          carPartBrand: item,
        );
        idCarPartBrand = newItem.carPartBrand.id;
        _addItem(
            newItem, direction, MainAxisAlignment.end, newItem.carPartBrand.id);
        data = _apiClient.listCarPartDynamic(carPartBrandSelected,
            carPartSelected, context, newItem.carPartBrand.id);
        _textController.clear();
        search = false;
        visibleItems.clear();
      } else {
        carPartSelected = true;
        DismissDirection direction = DismissDirection.startToEnd;
        AddCarPartItemContainer newItem = AddCarPartItemContainer(
          carPart: item,
        );
        _addItem(newItem, direction, MainAxisAlignment.start, idCarPartBrand);
        data = null;
        idCarPart = newItem.carPart.id;
      }
    });
  }

  /// Funci??n que a??ade un widget (marca o pieza) a la lista de seleccionados
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
                      AppLocalizations.of(context).translate("addCarPartPageDissmissibleText").toUpperCase(),
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

  ///Funci??n que obtiene las marcas de las piezas o las piezas seg??n
  ///la direcci??n de borrado
  void _checkDismissDirection(DismissDirection direction, int brandId) {
    setState(() {
      if (direction == DismissDirection.endToStart) {
        items.clear();
        carPartBrandSelected = false;
        carPartSelected = false;
        data = _apiClient.listCarPartDynamic(
            carPartBrandSelected, carPartSelected, context, brandId);
      } else {
        items.removeAt(1);
        carPartSelected = false;
        data = _apiClient.listCarPartDynamic(
            carPartBrandSelected, carPartSelected, context, brandId);
      }
    });
  }

  ///Funci??n que a??ade la pieza al coche actual del usuario
  void addCarPart() async {
    bool insert = await _apiClient.addCarPart(context, idCarPart);
    if (insert) Navigator.of(context).popAndPushNamed("home_page");
  }

  ///M??todo que devuelve el bot??n para a??adir si se ha seleccionado
  ///la marca y la pieza
  Widget getAddButton(Function function) {
    if (carPartBrandSelected && carPartSelected) {
      return SizedBox(
        height: 40,
        child: ThemeButton(
          buttonText: AppLocalizations.of(context).translate("addCarPartPageButtonText"),
          function: function,
        ),
      );
    } else {
      return Container();
    }
  }

  ///M??todo que devuelve el buscador
  Widget _searchDelegate() {
    return Container(
      height: 50,
      color: AppColors.green_jdm_arrow,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
                hintText: AppLocalizations.of(context)
                    .translate("addCarPartPageSearchHint"),
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
              search = true;
              print(_textController.text);
              setState(() {
                print(value);
                if (value.isEmpty) {
                  visibleItems = [];
                  search = false;
                } else {
                  visibleItems = dataList
                      .where((item) =>
                          item.name.toLowerCase().contains(value.toLowerCase()))
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
