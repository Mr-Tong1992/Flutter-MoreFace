import 'package:flutter/material.dart';
import 'package:flutter_common/flutter_common.dart';
import 'package:flutter_common/utils/color_utils.dart';
import 'package:flutter_common/utils/image_utils.dart';
import 'package:flutter_homepage/model/app_group.dart';
import 'package:flutter_homepage/model/services_app.dart';
import 'Home_section_style.dart';
import '../utils/VersionTransitionUtils.dart';

class HomeStyle3005 extends StatefulWidget {
  AppGroup appGroup;
  List<ServicesApp> appList;

  @override
  _HomeStyle3005State createState() => _HomeStyle3005State();

  HomeStyle3005({this.appGroup, Key key}) : super(key: key) {
    this.appList = this.appGroup.appInfoList;
  }

  static double height() {
    return HomeSectionStyle.height() + ScreenUtil.getInstance().getRatio() * 91;
  }
}

class _HomeStyle3005State extends State<HomeStyle3005> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        HomeSectionStyle(this.widget.appGroup),
        _cellItemContainer(context)
      ],
    ));
  }

  _cellItemContainer(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
          padding: EdgeInsets.only(
              top: ScreenUtil.getInstance().getRatio() * 10,
              bottom: ScreenUtil.getInstance().getRatio() * 15),
          child: Column(
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                    color: ColorUtils.kColorFFFFFF,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: ScreenUtil.getInstance().getRatio() * 66,
                        child: ListView(
                          padding: EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 10.0),
                          scrollDirection: Axis.horizontal,
                          children: this
                              .widget
                              .appList
                              .map<Widget>((item) => _SelectItem(
                                    item: item,
                                  ))
                              .toList(),
                        ),
                      ),
                    ],
                  )),
            ],
          )),
    );
  }
}

class _SelectItem extends StatelessWidget {
  final ServicesApp item;

  _SelectItem({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () => _onClickedApp(item),
      child: Container(
        width: ScreenUtil.getInstance().getRatio() * 124,
        margin:
            EdgeInsets.only(left: ScreenUtil.getInstance().getRatio() * 10.0),
        decoration: BoxDecoration(
          color: ColorUtils.kColorFBFBFB,
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        child: LayoutBuilder(builder: (context, constraint) {
          return Container(
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              fit: StackFit.expand,
              children: <Widget>[
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: ToonImage.networkImage(
                        url: item.appPic,
                        fit: BoxFit.fill,
                        width: double.infinity,
                        height: double.infinity),
                  ),
                ),
                Positioned(
                  top: ScreenUtil.getInstance().getRatio() * 14.0,
                  left: ScreenUtil.getInstance().getRatio() * 8,
                  child: Container(
                    child: Text(
                      item.appTitle ?? "",
                      style: TextStyle(
                          fontSize: ScreenUtil.getInstance().getSp(14),
                          color: ColorUtils.kColor000000,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                Positioned(
                  top: ScreenUtil.getInstance().getRatio() * 35.0,
                  left: ScreenUtil.getInstance().getRatio() * 8,
                  child: Container(
                    child: Text(
                      item.appSubTitle ?? "",
                      style: TextStyle(
                          fontSize: ScreenUtil.getInstance().getSp(12),
                          color: ColorUtils.kColor8E8E93,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  _onClickedApp(ServicesApp app) {
    VersionTransitionUtils.instance.appItemClick(app);
  }
}
