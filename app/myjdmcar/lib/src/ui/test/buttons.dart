import 'package:flutter/material.dart';
import 'package:myjdmcar/config/app_colors.dart';
import 'dart:math';

class AppButtons extends StatelessWidget {
  const AppButtons({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: SizedBox(
                width: 230,
                height: 50,
                child: Material(
                  elevation: 8.0,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(
                            begin: FractionalOffset.centerLeft,
                            end: FractionalOffset.centerRight,
                            stops: [
                              0.5,
                              0.5
                            ],
                            colors: [
                              AppColors.yellow_jdm_arrow,
                              AppColors.green_jdm_arrow
                            ])),
                    child: Align(
                        alignment: Alignment.center, child: Text("Horizontal")),
                  ),
                ),
              )),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: SizedBox(
                width: 230,
                height: 50,
                child: Material(
                  elevation: 8.0,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(
                            begin: FractionalOffset.centerLeft,
                            end: FractionalOffset.centerRight,
                            stops: [
                              0.45,
                              0.65
                            ],
                            colors: [
                              AppColors.yellow_jdm_arrow,
                              AppColors.green_jdm_arrow
                            ])),
                    child: Align(
                        alignment: Alignment.center,
                        child: Text("Horizontal Gradient")),
                  ),
                ),
              )),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: SizedBox(
                width: 230,
                height: 50,
                child: Material(
                  elevation: 8.0,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(
                            begin: FractionalOffset.topCenter,
                            end: FractionalOffset.bottomCenter,
                            stops: [
                              0.5,
                              0.5
                            ],
                            colors: [
                              AppColors.yellow_jdm_arrow,
                              AppColors.green_jdm_arrow
                            ])),
                    child: Align(
                        alignment: Alignment.center, child: Text("Vertical")),
                  ),
                ),
              )),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: SizedBox(
                width: 230,
                height: 50,
                child: Material(
                  elevation: 8.0,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(
                            begin: FractionalOffset.topCenter,
                            end: FractionalOffset.bottomCenter,
                            stops: [
                              0.4,
                              0.7
                            ],
                            colors: [
                              AppColors.yellow_jdm_arrow,
                              AppColors.green_jdm_arrow
                            ])),
                    child: Align(
                        alignment: Alignment.center,
                        child: Text("Vertical Gradient")),
                  ),
                ),
              )),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: SizedBox(
                width: 230,
                height: 50,
                child: Material(
                  elevation: 8.0,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            transform: GradientRotation(3.14/2),
                            stops: [0.5,0.5],
                            colors: [
                              AppColors.yellow_jdm_arrow,
                              AppColors.green_jdm_arrow,
                              
                            ])),
                    child: Align(
                        alignment: Alignment.center, child: Text("Diagonal", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),)),
                  ),
                ),
              )),
                    SizedBox(
                height: 20,
              ),
              Center(
                  child: SizedBox(
                width: 230,
                height: 50,
                child: Material(
                  elevation: 8.0,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            transform: GradientRotation(3.14/2),
                            stops: [0.48,0.52],
                            colors: [
                              AppColors.yellow_jdm_arrow,
                              AppColors.green_jdm_arrow,
                              
                            ])),
                    child: Align(
                        alignment: Alignment.center, child: Text("Diagonal", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),)),
                  ),
                ),
              )),
            ],
          ),
        ));
  }
}
