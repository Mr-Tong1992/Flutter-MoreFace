import 'dart:core';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_common/flutter_common.dart';
import 'package:flutter_common/utils/image_utils.dart';
import 'package:flutter_homepage/model/home_settings.dart';
import 'package:flutter_homepage/utils/VersionTransitionUtils.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../model/app_group.dart';
import '../model/services_app.dart';

class HomeStyle3007 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeStyle3007State();
  }

  AppGroup appGroup;
  HomeSettings settings;
  List<ServicesApp> appList;
  double headerMargin;

  HomeStyle3007({this.appGroup, this.settings, Key key}) : super(key: key) {
    this.appList = this.appGroup.appInfoList;
    this.headerMargin = ScreenUtil.getInstance().getRatio() * this.settings?.headerMargin ?? 0.0;
    if(Constant.isiPhoneX()){
      this.headerMargin += 24;
    }
  }
}

class HomeStyle3007State extends State<HomeStyle3007> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 0.0),
      color: Colors.white,
      width: ScreenUtil.getInstance().getRatio() * 375.0 ,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            color: ColorUtils.kColor4,
            height: ScreenUtil.getInstance().getRatio() * 270,
            child: Swiper(
              autoplayDelay: 6000,
              itemCount: this.widget.appList.length,
              itemBuilder: (c, i) {
                ServicesApp app = this.widget.appList[i];
                return Container(
                  child: GestureDetector(
                    onTap: () => _onClickedApp(app),
                    child: ToonImage.networkImage(
                        url: app?.appPic,
                        fit: BoxFit.fill,
                        width: double.infinity,
                        height: double.infinity),
                  ),
                );
              },
              pagination: _customSwiperPagination(),
              autoplay: _isAutoPlay(),
              autoplayDisableOnInteraction: _isAutoPlay(),
              physics: _getScrollPhysics(),
              onTap: (index) {
                _onTapAppAtIndex(index);
              },
            ),
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
      padding: EdgeInsets.only(
          left: ScreenUtil.getInstance().getRatio() * 15.0,
          right: ScreenUtil.getInstance().getRatio() * 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  right: ScreenUtil.getInstance().getRatio() * 5.0,
                ),
                child: Container(
                  color: Color(0xffdf3031),
                  width: ScreenUtil.getInstance().getRatio() * 3.0,
                  height: ScreenUtil.getInstance().getRatio() * 15.0,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                section,
                style: TextStyle(
                    fontSize: ScreenUtil.getInstance().getSp(15.0),
                    decoration: TextDecoration.none,
                    color: ColorUtils.kColor222222),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _onTapAppAtIndex(int index) async {
    ServicesApp app = this.widget.appList[index];
    VersionTransitionUtils.instance.appItemClick(app);
  }

  bool _isAutoPlay() {
    return this.widget.appList.length > 1 ? true : false;
  }

  ScrollPhysics _getScrollPhysics() {
    if (_isAutoPlay() == true) {
      return BouncingScrollPhysics();
    }
    return NeverScrollableScrollPhysics();
  }

  SwiperPagination _customSwiperPagination() {
    double top =this.widget.headerMargin ?? 10.0;
    if (top != null){
      top = top - ScreenUtil.getInstance().getRatio() * 10.0;
    }

    double width = ScreenUtil.getScreenW(context);
    if (width >= 414) {
      // plus 机型
      top -= 10.0;
    }

    if (this.widget.appList.length == 0) {
      return null;
    }
    return new SwiperPagination(
        margin: EdgeInsets.only(top: top),
        alignment: Alignment.topCenter,
        builder: DotSwiperPaginationBuilder(
          size: this.widget.appList.length > 1 ? 6 : 0,
          activeSize: this.widget.appList.length > 1 ? 6 : 0,
          color: Color.fromRGBO(255, 255, 255, 0.5),
          activeColor: ColorUtils.kColorFFFFFF,
        ));
  }

  _onClickedApp(ServicesApp app) {
    VersionTransitionUtils.instance.appItemClick(app);
  }
}
