import 'package:flutter/material.dart';
import 'package:myjdmcar/config/app_colors.dart';

class HomeSliverAppbar extends StatelessWidget {

  final Function showDrawer;

  const HomeSliverAppbar({Key key, this.showDrawer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppColors.green_jdm_arrow,
      floating: true,
      pinned: false,
      snap: false,
      expandedHeight: 50,
      elevation: 0,
      centerTitle: true,
      title: Text(
        "MyJDMCar",
        style: Theme.of(context).textTheme.headline6,
      ),
      leading: IconButton(
        icon: Icon(Icons.person_rounded),
        onPressed: () {
          showDrawer();
        },
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Icon(Icons.drive_eta_rounded),
        ),
      ],
    );
  }
}
