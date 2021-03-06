import 'package:flutter/material.dart';
import 'package:myjdmcar/api/api_client.dart';
import 'package:myjdmcar/config/app_colors.dart';
import 'package:myjdmcar/models/car_part.dart';

class AddCarPartItemContainer extends StatelessWidget {
  final CarPartModel carPart;

  const AddCarPartItemContainer({Key key, this.carPart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApiClient apiClient = ApiClient();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Container(
          width: double.infinity,
          height: 150,
          decoration: BoxDecoration(
              color: AppColors.greyLight,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.black, width: 1.5)),
          child: Row(
            children: [
              Container(
                width: 180,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(apiClient.httpHead +
                            apiClient.baseUrl +
                            apiClient.imagesUrl +
                            apiClient.carPartsUrl +
                            carPart.image))),
              ),
              Container(
                child: Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        carPart.name,
                        style: Theme.of(context).textTheme.bodyText1,
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
