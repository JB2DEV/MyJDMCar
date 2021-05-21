import 'package:flutter/material.dart';
import 'package:myjdmcar/config/app_colors.dart';
import 'package:myjdmcar/models/car_part.dart';

class FrontCardCarPart extends StatelessWidget {
  final CarPartModel carPart;
  final VoidCallback onFlip;
  const FrontCardCarPart(
      {Key key, @required this.carPart, @required this.onFlip})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDetailItem(context),
      child: Container(
          decoration: BoxDecoration(
              color: AppColors.green_jdm_arrow,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black, width: 1.5)),
          child: Column(
            children: [
              Container(
                height: 170,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8.5)),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/" + carPart.image))),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.black, width: 1.5))),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    carPart.name.toUpperCase(),
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ),
            ],
          )),
    );
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
                carPart.name,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              content: Column(
                children: [
                  Text(carPart.description),
                  SizedBox(
                    height: 20,
                  ),
                  _checkDealer(context),
                ],
              ));
        });
  }

  Widget _checkDealer(BuildContext context) {
    if (carPart.url != null && carPart.url.contains("www.dna-autoparts.com")  ) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Distribuidor".toUpperCase(),
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(
            height: 20,
          ),
          Image.asset("assets/images/dna.png"),
        ],
      );
    } else {
      return Container();
    }
  }
}
