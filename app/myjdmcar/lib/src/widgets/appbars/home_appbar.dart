import 'package:flutter/material.dart';
import 'package:myjdmcar/config/app_colors.dart';
import 'package:myjdmcar/provider/user_car_provider.dart';
import 'package:provider/provider.dart';

class HomeSliverAppbar extends StatelessWidget {
  final Function showDrawer;

  const HomeSliverAppbar({Key key, this.showDrawer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = Provider.of<UserCarProvider>(context).carModel;

    return SliverAppBar(
      backgroundColor: AppColors.green_jdm_arrow,
      floating: true,
      pinned: false,
      snap: false,
      elevation: 0,
      centerTitle: true,
      title: Text(
        "$title",
        style: Theme.of(context).textTheme.headline6,
      ),
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
          showDrawer();
        },
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: IconButton(
            icon: Icon(Icons.directions_car_sharp),
            onPressed: () =>
                Navigator.popAndPushNamed(context, "user_car_detail_page"),
          ),
        ),
      ],
    );
  }
}
