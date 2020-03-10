import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_common/flutter_common.dart';
import 'package:flutter_common/utils/image_utils.dart';
import 'package:flutter_homepage/utils/VersionTransitionUtils.dart';
import '../model/app_group.dart';
import '../model/services_app.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomeStyle1006 extends StatefulWidget {
  @override
  _HomeStyle1006State createState() => new _HomeStyle1006State();

  HomeStyle1006({this.appGroup, Key key}) : super(key: key) {
    this.appList = this.appGroup.appInfoList;
  }

  AppGroup appGroup;
  List<ServicesApp> appList;
}

class _HomeStyle1006State extends State<HomeStyle1006> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

    double contentWidth = size.width - 30.0;
    double contentHeight = (contentWidth * 112.0 / 345.0 + 10.0) * this.widget.appList.length;
    double footerHeight = 10.0;
    double titleHeight = 47.0;

    String title = this.widget.appGroup.title;
    if (title == null || title.isEmpty) {
      titleHeight = 0.0;
    }

    return Container(
      color: Colors.grey,
      height: (titleHeight + contentHeight + footerHeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            color: Colors.white,
            height: titleHeight,
            child: _widgetForSection(this.widget.appGroup.title),
          ),
          Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  child: SizedBox(
                    height: contentHeight,
                    child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1, //每行四列
                        ),
                        itemCount: this.widget.appList.length,
                        itemBuilder: (context, index) {
                          ServicesApp app = this.widget.appList[index];
                          return appWidgetAtIndex(app, index);
                        }),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: ColorUtils.kColor5,
            height: footerHeight,
          ),
        ],
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
            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 5.0,),
                child: Container(
                  color: Color(0xffdf3031),
                  width: 3.0,
                  height: 15.0,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                section,
                style: TextStyle(fontSize: 15.0,
                    decoration: TextDecoration.none,
                    color: ColorUtils.kColor222222),
              ),
            ],
          ),

        ],
      ),
    );
  }

  Widget appWidgetAtIndex(ServicesApp app, int index) {

    Size size = MediaQuery
        .of(context)
        .size;
    double height = (size.width - 30.0) * 112.0 / 345.0;


    return GestureDetector(
      child: Column(
        children: <Widget>[
          Container(
            constraints: BoxConstraints(maxHeight: height),
            decoration: getDecorationWithIndex(index),
            child: imageWidgetBySrc(app.appPic),
          ),
        ],
      ),
      onTap: () => _onClickedServiceApp(app, index),
    );
  }

  Widget imageWidgetBySrc(String src) {
    Size size = MediaQuery
        .of(context)
        .size;

    if(src.startsWith('http') || src.startsWith('https')){
      return ToonImage.networkImage(url: src, width: size.width - 30.0);
    }else{
      Image img = new Image.asset(
        src,
        package: 'flutter_homepage',
        width: size.width - 30.0,
      );
      return img;
    }
  }

  BoxDecoration getDecorationWithIndex(int index) {
    if(index == 7) {
      return BoxDecoration( color: Colors.white);
    }
    return BoxDecoration( color: ColorUtils.kColorf8f8fb);
  }

  _onClickedServiceApp(ServicesApp app, int index) async {
    VersionTransitionUtils.instance.appItemClick(app);
  }
}
