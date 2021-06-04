import 'package:flutter/material.dart';
import 'package:myjdmcar/config/internationalization/app_localizations.dart';
import 'package:myjdmcar/src/widgets/decoration/logo_app.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            LogoApp(),
            SizedBox(
              height: 30,
            ),
            Text(
              "v.Alpha 1.0",
              textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyText1,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(AppLocalizations.of(context).translate("appInfoPageText"), style: Theme.of(context).textTheme.bodyText2, textAlign: TextAlign.center,),
            )
          ],
        ),
      ),
    );
  }
}
