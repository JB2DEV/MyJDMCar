import 'package:flutter/material.dart';
import 'package:myjdmcar/config/app_colors.dart';
import 'package:myjdmcar/config/internationalization/app_localizations.dart';
import 'package:myjdmcar/models/car_part.dart';

class BackCardCarPart extends StatelessWidget {
  final CarPartModel carPart;
  final VoidCallback onFlip;
  const BackCardCarPart(
      {Key key, @required this.carPart, @required this.onFlip})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                child: Image.network(carPart.carPartBrand.image),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            GestureDetector(
              onTap: () => _deleteCarPart(),
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
                              .translate("homeBackCardItemDelete").toUpperCase(),
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
                carPart.carPartBrand.name.toUpperCase(),
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    carPart.carPartBrand.description,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ));
        });
  }

  void _deleteCarPart() {
    print("Delete carPart with ID: ${carPart.id}");
  }
}
