import 'package:flutter/material.dart';
import 'package:flutter_common/utils/image_utils.dart';
import 'package:flutter_homepage/model/app_group.dart';
import 'package:flutter_homepage/model/services_app.dart';
import 'package:flutter_common/flutter_common.dart';
import 'Home_section_style.dart';
import '../utils/VersionTransitionUtils.dart';

class HomeStyle3006 extends StatefulWidget {
  AppGroup appGroup;
  List<ServicesApp> appList;

  @override
  _homeStyle3006State createState() => _homeStyle3006State();

  HomeStyle3006({this.appGroup, Key key}) : super(key: key) {
    this.appList = this.appGroup.appInfoList;
  }

  static double height(AppGroup group) {
    return HomeSectionStyle.height() +
        group?.appInfoList?.length * ScreenUtil.getInstance().getRatio() * 96;
  }
}

class _homeStyle3006State extends State<HomeStyle3006> {
  @override
  Widget build(BuildContext context) {
    ServicesApp app = this.widget.appList?.first;
    return Container(
      child: Column(
        children: <Widget>[
          HomeSectionStyle(this.widget.appGroup),
          _cellItemContainer(context)
        ],
      ),
    );
  }

  _cellItemContainer(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(bottom: 15),
      child: Column(
        children: _itemCell(context),
      ),
    );
  }

  //专题服务
  _itemCell(BuildContext context) {
    List<Widget> items = [];
    this.widget.appList.forEach((model) {
      items.add(_gridNavItemlsit(context, model));
    });
    return items;
  }

  _gridNavItemlsit(BuildContext context, ServicesApp model) {
    Color startColor = Color(int.parse('0xFFFBFBFB'));
    Color endColor = Color(int.parse('0xFFFBFBFB'));
    return Container(
      child: GestureDetector(
        onTap: () => _onClickedApp(model),
        child: Container(
          height: ScreenUtil.getInstance().getRatio() * 96,
          padding: (EdgeInsets.only(left: 0)),
          width: ScreenUtil.getInstance().getRatio() * 345,
          alignment: Alignment.center,
          //margin: EdgeInsets.only(top: 10,right: 16,left: 16),
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [startColor, endColor])),
          child: PhysicalModel(
            color: ColorUtils.kColorFBFBFB,
            borderRadius: BorderRadius.circular(4),
            clipBehavior: Clip.antiAlias,
            child: FractionallySizedBox(
              widthFactor: 1,
              child: Container(
                height: ScreenUtil.getInstance().getRatio() * 96,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: ToonImage.networkImage(
                      url: model.appPic,
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: double.infinity),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _onClickedApp(ServicesApp app) {
    VersionTransitionUtils.instance.appItemClick(app);
  }
}
