import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_common/utils/image_utils.dart';
import 'package:flutter_homepage/model/app_group.dart';
import 'package:flutter_homepage/model/services_app.dart';
import 'package:flutter_common/flutter_common.dart';
import 'Home_section_style.dart';
import '../utils/VersionTransitionUtils.dart';

class HomeStyle3009 extends StatelessWidget {
  AppGroup appGroup;
  List<ServicesApp> appList;

  HomeStyle3009({this.appGroup, Key key}) : super(key: key) {
    this.appList = this.appGroup.appInfoList;
  }

  static double height(AppGroup group) {
    return HomeSectionStyle.height() + group?.appInfoList?.length * ScreenUtil.getInstance().getRatio() * 100.0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        HomeSectionStyle(this.appGroup),
        _cellItemContainer(context),
      ],
    ));
  }

  _cellItemContainer(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: _itemCell(context),
      ),
    );
  }

  //专题服务
  _itemCell(BuildContext context) {
    List<Widget> items = [];
    appList.forEach((model) {
      items.add(_gridNavItemlsit(context, model));
    });
    return items;
  }

  _gridNavItemlsit(BuildContext context, ServicesApp app) {
    return Container(
      child: GestureDetector(
        onTap: () => _onClickedApp(app),
        child: Container(
          height: ScreenUtil.getInstance().getRatio() * 90.0,
          padding: (EdgeInsets.only(left: 0)),
          margin: EdgeInsets.only(
              top: ScreenUtil.getInstance().getRatio() * 10.0,
              right: ScreenUtil.getInstance().getRatio() * 16.0,
              left: ScreenUtil.getInstance().getRatio() * 16.0),
          child: Stack(
            alignment: Alignment.center,
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: ToonImage.networkImage(
                      url: app.appPic,
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: double.infinity),
                ),
              ),
              Positioned(
                left: ScreenUtil.getInstance().getRatio() * 20,
                top: ScreenUtil.getInstance().getRatio() * 32,
                child: Text(
                  app.appTitle,
                  style: TextStyle(
                      fontSize: ScreenUtil.getInstance().getSp(19.0),
                      fontWeight: FontWeight.w400,
                      color: ColorUtils.kColorFFFFFF,
                      decoration: TextDecoration.none),
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onClickedApp(ServicesApp app) {
    VersionTransitionUtils.instance.appItemClick(app);
  }
}
