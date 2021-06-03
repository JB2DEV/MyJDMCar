import 'package:flutter/material.dart';
import 'package:myjdmcar/api/api_client.dart';
import 'package:myjdmcar/config/app_colors.dart';
import 'package:myjdmcar/config/internationalization/app_localizations.dart';
import 'package:myjdmcar/models/car_part.dart';
import 'package:url_launcher/url_launcher.dart';

class FrontCardCarPart extends StatelessWidget {
  final CarPartModel carPart;
  final VoidCallback onFlip;

  const FrontCardCarPart(
      {Key key, @required this.carPart, @required this.onFlip})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApiClient _apiClient = ApiClient();

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
                        image: NetworkImage(_apiClient.httpHead +
                            _apiClient.baseUrl +
                            _apiClient.imagesUrl +
                            _apiClient.carPartsUrl +
                            carPart.image))),
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
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ),
              ),
            ],
          )),
    );
  }

  ///Método que muestra la información en detalle de una pieza
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

  ///Método que comprueba si el distribuidor tiene la pieza en su tienda.
  ///Si es así, lo muestra
  Widget _checkDealer(BuildContext context) {
    if (carPart.url != null && carPart.url.contains("www.dna-autoparts.com")) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)
                .translate("homeFrontCardDetailDealer")
                .toUpperCase(),
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () async{
              const url = 'https://google.com';
              if(await canLaunch(url)){
                await launch(url);
              } else{
                throw 'Could not launch $url';
              }
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage("assets/images/dna.png"))),
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  void _launchURL() async {
    print("taped");
    await canLaunch('https://flutter.io')
        ? await launch('https://flutter.io')
        : throw 'Could not launch https://flutter.io';
  }
}
