import 'package:flutter/material.dart';
import 'package:myjdmcar/config/app_colors.dart';
import 'package:myjdmcar/models/car_part.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeCarPartItem extends StatelessWidget {
  final CarPartModel carPart;
  const HomeCarPartItem({Key key, this.carPart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: GestureDetector(
        onTap: () => showDetailItem(context),
        child: Container(
            decoration: BoxDecoration(
                color: AppColors.green_jdm_arrow,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black, width: 1.5)),
            child: Column(
              children: [
                Container(
                  height: 120,
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
                    border: Border(top: BorderSide(color: Colors.black, width: 1.5))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      carPart.name.toUpperCase(), style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  carPart.carPartBrand.name.toUpperCase(), style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
              ],
            )),
      ),
    );
  }

  Future showDetailItem(BuildContext context) {
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
                  getImages(),
                ],
              ));
        });
  }

  Future launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget getImages() {
    if (carPart.url.contains("www.dna-autoparts.com")) {
      return Column(
        children: [
          GestureDetector(
            onTap: () {}, //TODO - Naviagte to brand detail page,
            child: Container(
              child: Container(
                width: double.infinity,
                child: Image.network(carPart.carPartBrand.image),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          GestureDetector(
            onTap: () => launchURL(carPart.url),
            child: Container(child: Image.asset("assets/images/dna.png")),
          )
        ],
      );
    } else {
      return GestureDetector(
        onTap: () {}, //TODO - Naviagte to brand detail page,
        child: Container(
          child: Container(
            width: double.infinity,
            child: Image.network(carPart.carPartBrand.image),
          ),
        ),
      );
    }
  }
}
