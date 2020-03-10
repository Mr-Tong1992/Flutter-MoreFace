import 'dart:core';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_common/utils/image_utils.dart';
import 'package:flutter_homepage/utils/VersionTransitionUtils.dart';
import '../model/app_group.dart';
import '../model/services_app.dart';
import 'package:flutter_common/flutter_common.dart';

//
class HomeStyle1002 extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return HomeStyle1002State();
  }

  HomeStyle1002({this.appGroup, Key key}) : super(key: key) {
    this.appList = this.appGroup.appInfoList;
  }

  AppGroup appGroup;
  List<ServicesApp> appList;
}

class HomeStyle1002State extends State<HomeStyle1002> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    double ratio = size.width / 2.0 / 84.0;

    return Container(
      color: Colors.white,

      child: Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _widgetForSection(this.widget.appGroup.title),
            SizedBox(
              height: _heightForAllServicesApp(this.widget.appList.length),
              child: GridView.builder(
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: ratio,
                ),
                itemCount: this.widget.appList.length,
                itemBuilder: (context, index) {
                  ServicesApp app = this.widget.appList[index];
                  return _appWidgetAtIndex(app, index);
                },
              ),
            ),
            Container(
              color: ColorUtils.kColor5,
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _widgetForSection(String section) {
    if (section.isEmpty || section == null) {
      return null;
    }
    return Padding(
      padding: EdgeInsets.only(left: 15.0, right: 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 5.0, top: 3.0),
                child: Container(
                  color: Color(0xffdf3031),
                  width: 3.0,
                  height: 15.0,
                ),
              ),
            ],
          ),

          Text(
            section,
            style: TextStyle(fontSize: 15.0,
                decoration: TextDecoration.none,
                color: ColorUtils.kColor222222),
          ),
        ],
      ),
    );
  }

  Widget _appWidgetAtIndex(ServicesApp app, int index) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: _borderAtIndex(index),
      ),
      child: GestureDetector(
        onTap: () => _onClickApp(app),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      app.appTitle,
                      style: TextStyle(fontSize: 15.0,
                          color: ColorUtils.kColor222222,
                          decoration: TextDecoration.none),
                      maxLines: 1,
                    ),
                    Text(
                      app.appSubTitle,
                      style: TextStyle(fontSize: 12.0,
                          color: ColorUtils.kColor8E8E93,
                          decoration: TextDecoration.none),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DecoratedBox(
                    decoration: BoxDecoration(color: Colors.white),
                    child: ToonImage.networkImage(url: app?.appPic, width: 90.0, height: 60.0),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _heightForAllServicesApp(int appCount) {
    double height = ((appCount / 2).ceil() * 84.0);
    return height;
  }

  void _onClickApp(ServicesApp app) async {
    VersionTransitionUtils.instance.appItemClick(app);
  }

  Border _borderAtIndex(int index) {
    if (index % 2 != 0) {
      return Border(
        left: BorderSide(width: 0.5,
            style: BorderStyle.solid,
            color: ColorUtils.kColorf8f8fb),
        bottom: BorderSide(width: 0.5,
            style: BorderStyle.solid,
            color: ColorUtils.kColorf8f8fb),
      );
    } else {
      return Border(
        right: BorderSide(width: 0.5,
            style: BorderStyle.solid,
            color: ColorUtils.kColorf8f8fb),
        bottom: BorderSide(width: 0.5,
            style: BorderStyle.solid,
            color: ColorUtils.kColorf8f8fb),
      );
    }
  }
}