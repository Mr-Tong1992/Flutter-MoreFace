import 'dart:core';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_common/utils/image_utils.dart';
import 'package:flutter_homepage/utils/VersionTransitionUtils.dart';
import '../model/app_group.dart';
import '../model/services_app.dart';
import 'package:flutter_common/flutter_common.dart';
import '../style/Home_section_style.dart';

class HomeStyle3008 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeStyle3008State();
  }

  HomeStyle3008({this.appGroup, Key key}) : super(key: key) {
    this.appList = this.appGroup.appInfoList;
  }

  AppGroup appGroup;
  List<ServicesApp> appList;

  static double height(AppGroup group) {
    double sectionHeight = HomeSectionStyle.height();
    double height = ScreenUtil.getInstance().getRatio() *
        (((group?.appInfoList.length / 2).ceil() * 80) +
            11.0 +
            sectionHeight);
    return height +HomeSectionStyle.height();
  }
}

class HomeStyle3008State extends State<HomeStyle3008> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double ratio = size.width / 2.0 / 56.0;

      return Container(
       child: Column(
        children: <Widget>[
          HomeSectionStyle(this.widget.appGroup),
        Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(
                top: ScreenUtil.getInstance().getRatio() * 10.0,
                left: ScreenUtil.getInstance().getRatio() * 18.0,
                right: ScreenUtil.getInstance().getRatio() * 14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: _heightForAllServicesApp(this.widget.appList.length),
                  child: Align(
                    alignment: FractionalOffset.center,
                    child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: (169 * 2 + 5) / (80 * 2 + 5),
                      ),
                      itemCount: this.widget.appList.length,
                      itemBuilder: (context, index) {
                        ServicesApp app = this.widget.appList[index];
                        return _appWidgetAtIndex(app, index);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
        ],
      ),
    );
  }

  Widget _appWidgetAtIndex(ServicesApp app, int index) {
    return GestureDetector(
        onTap: () => _onClickApp(app),
        child: Stack(
          children: <Widget>[
            Container(
              child: ToonImage.networkImage(
                  url: app?.appPic,
                  width: ScreenUtil.getInstance().getRatio() * 169.0,
                  height: ScreenUtil.getInstance().getRatio() * 80.0),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: ScreenUtil.getInstance().getRatio() * 26.0,
                  left: ScreenUtil.getInstance().getRatio() * 12.0),
              child: Text(
                app?.appTitle ?? "",
                style: TextStyle(
                    fontSize: ScreenUtil.getInstance().getSp(15.0),
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    decoration: TextDecoration.none),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: ScreenUtil.getInstance().getRatio() * 51.0,
                  left: ScreenUtil.getInstance().getRatio() * 12.0),
              child: Text(
                app?.appSubTitle ?? "",
                style: TextStyle(
                    fontSize: ScreenUtil.getInstance().getSp(12.0),
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    decoration: TextDecoration.none),
              ),
            ),
          ],
        ));
  }

  double _heightForAllServicesApp(int appCount) {
    double height = ScreenUtil.getInstance().getRatio() *
        (((appCount / 2).ceil() * 80.0) + 11.0);
    return height;
  }

  void _onClickApp(ServicesApp app) async {
    VersionTransitionUtils.instance.appItemClick(app);
  }
}
