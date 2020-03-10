import 'dart:core';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_common/utils/image_utils.dart';
import 'package:flutter_homepage/utils/VersionTransitionUtils.dart';
import '../model/app_group.dart';
import '../model/services_app.dart';
import 'package:flutter_common/flutter_common.dart';
import '../style/Home_section_style.dart';

class HomeStyle1012 extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return HomeStyle1012State();
  }

  HomeStyle1012({this.appGroup, Key key}) : super(key: key) {
    this.appList = this.appGroup.appInfoList;
  }

  AppGroup appGroup;
  List<ServicesApp> appList;

  static double height(AppGroup group){
    double sectionHeight = HomeSectionStyle.height();
    double height = ScreenUtil.getInstance().getRatio() * (((group?.appInfoList.length / 2).ceil() * 56.0) + 11.0 + sectionHeight);
    return height;
  }
}

class HomeStyle1012State extends State<HomeStyle1012> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    double ratio = size.width / 2.0 / 56.0;

    return Container(
      color: Colors.white,

      child: Padding(
        padding: EdgeInsets.only(top: ScreenUtil.getInstance().getRatio() * 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            HomeSectionStyle(this.widget.appGroup),
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
          ],
        ),
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
            Padding(
              padding: EdgeInsets.only(left: ScreenUtil.getInstance().getRatio() * 15.0),
              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DecoratedBox(
                    decoration: BoxDecoration(color:  Colors.white,),
                    child: ToonImage.networkImage(url: app?.appIcon, width: ScreenUtil.getInstance().getRatio() * 40.0, height: ScreenUtil.getInstance().getRatio() * 40.0),
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: ScreenUtil.getInstance().getRatio() * 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      app.appTitle,
                      style: TextStyle(fontSize: ScreenUtil.getInstance().getSp(15.0), fontWeight: FontWeight.w400,
                          color: ColorUtils.kColor222222,
                          decoration: TextDecoration.none),
                      maxLines: 1,
                    ),
                    Text(
                      app.appSubTitle,
                      style: TextStyle(fontSize: ScreenUtil.getInstance().getSp(12.0), fontWeight: FontWeight.w400,
                          color: ColorUtils.kColor8E8E93,
                          decoration: TextDecoration.none),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _heightForAllServicesApp(int appCount) {
    double height = ScreenUtil.getInstance().getRatio() *  (((appCount / 2).ceil() * 56.0) + 11.0);
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