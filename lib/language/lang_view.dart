import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'AppLanguage.dart';
class LanguageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AppLanguage());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 26),
              margin: EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Text(
                'Choose language',
                style: TextStyle(
                  color: Colors.blue,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ),
            ListTile(
                dense: true,
                // isThreeLine: true,
                title: Text(
                  'عربي',
                ),
                subtitle: Text(
                  'عربي',
                ),
                onTap: () {
                  controller.changeLanguage('ar');
                  Get.updateLocale(Locale('ar'));
                }),
            buildDivider(),
            ListTile(
                dense: true,
                title: Text(
                  'English',
                ),
                subtitle: Text(
                  'English',
                ),
                onTap: () {
                  controller.changeLanguage('en');
                  Get.updateLocale(Locale('en'));
                }),
            buildDivider(),
          ],
        ),
      ),
    );
  }

  Container buildDivider() => Container(
        margin: EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Divider(
          color: Colors.grey,
        ),
      );
}
