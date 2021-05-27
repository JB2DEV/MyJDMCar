import 'package:flutter/material.dart';
import 'package:myjdmcar/api/api_client.dart';
import 'package:myjdmcar/config/app_colors.dart';
import 'package:myjdmcar/config/internationalization/app_localizations.dart';
import 'package:myjdmcar/models/car_part.dart';

class BackCardCarPart extends StatefulWidget {
  final CarPartModel carPart;
  final VoidCallback onFlip;
  const BackCardCarPart(
      {Key key, @required this.carPart, @required this.onFlip})
      : super(key: key);

  @override
  _BackCardCarPartState createState() => _BackCardCarPartState();
}

class _BackCardCarPartState extends State<BackCardCarPart> {
  @override
  Widget build(BuildContext context) {
    ApiClient _apiClient = ApiClient();
    return Container(
        decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black, width: 1.5)),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => _showDetailItem(context),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                height: 210,
                child: Image.network(_apiClient.httpHead +
                    _apiClient.baseUrl +
                    _apiClient.imagesUrl +
                    _apiClient.carPartsBrandsUrl +
                    widget.carPart.carPartBrand.image),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            GestureDetector(
              onTap: () => _deleteCarPart(context, _apiClient),
              child: Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    AppLocalizations.of(context)
                        .translate("homeBackCardItemDelete")
                        .toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: AppColors.white),
                  ),
                ],
              )),
            ),
          ],
        ));
  }

  Future _showDetailItem(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              scrollable: true,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              title: Text(
                widget.carPart.carPartBrand.name.toUpperCase(),
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.carPart.carPartBrand.description,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ));
        });
  }

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

  void _deleteCarPart(BuildContext context, ApiClient _apiClient) async {
    print("Delete carPart with ID: ${widget.carPart.id}");
    _apiClient.deleteCarPartFromCar(context, widget.carPart.id).then((value) {
      Navigator.of(context).popAndPushNamed("home_page");
    });
  }
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

}
