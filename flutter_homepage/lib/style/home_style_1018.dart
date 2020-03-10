import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_common/flutter_common.dart';
import 'package:flutter_common/utils/image_utils.dart';
import 'package:flutter_homepage/utils/VersionTransitionUtils.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../model/app_group.dart';
import '../model/services_app.dart';


class HomeStyle1018 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeStyle1018State();
  }

  HomeStyle1018({
    this.appGroup,
    Key key
  }) : super(key: key) {
    this.appList = this.appGroup.appInfoList;
  }

  AppGroup appGroup;
  List<ServicesApp> appList;

}

class HomeStyle1018State extends State<HomeStyle1018> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double contentHeight = (size.width * 90 / 375);
    double footerHeight = 10.0;
    double titleHeight = 47.0;

    String title = this.widget.appGroup.title;
    if (title == null || title.isEmpty) {
      titleHeight = 0.0;
    }

    return Container(
      color: Colors.red,
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
            color: ColorUtils.kColor4,
            height: contentHeight,
            child: Padding(
              padding: EdgeInsets.only(left: 0.0, right: 0.0),
              child: Swiper(
                  itemCount: this.widget.appList.length,
                  itemBuilder: (BuildContext context, int index) {
                    ServicesApp app = this.widget.appList[index];
                    return ToonImage.networkImage(url: app?.appPic);
                  },
                  pagination: _customSwiperPagination(),
                  autoplay: _isAutoPlay(),
                  autoplayDisableOnInteraction: _isAutoPlay(),
                  physics:  _getScrollPhysics(),
                  onTap: (index) {
                    _onTapAppAtIndex(index);
                  },
              ),
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

  _onTapAppAtIndex(int index) async {
    ServicesApp app = this.widget.appList[index];
    VersionTransitionUtils.instance.appItemClick(app);
  }

  bool _isAutoPlay() {
    return this.widget.appList.length > 1 ? true : false;
  }

  ScrollPhysics _getScrollPhysics() {
    if(_isAutoPlay() == true){
      return BouncingScrollPhysics();
    }
    return NeverScrollableScrollPhysics();
  }

  SwiperPagination _customSwiperPagination() {
    if(this.widget.appList.length == 0) {
      return null;
    }

    return new SwiperPagination(
        margin:  EdgeInsets.all(5.0),
        alignment: Alignment.bottomCenter,
        builder: DotSwiperPaginationBuilder(
          size: 6,
          activeSize: 6,
          color:Color.fromRGBO(255, 255, 255, 0.5),
          activeColor: ColorUtils.kColorFFFFFF,
        )
    );

//    return SwiperPagination(
//      alignment: Alignment.bottomCenter,
//      builder: new SwiperCustomPagination(
//        builder: (BuildContext context, SwiperPluginConfig config) {
//          return new PageIndicator(
//            layout: PageIndicatorLayout.SLIDE,
//            size: 5.0,
//            space: 10.0,
//            color: Color.fromRGBO(0, 0, 0, 0.1),
//            activeColor: Color.fromRGBO(0, 0, 0, 0.1),
//            count: this.widget.appList.length,
//            controller: config.pageController,
//          );
//        },
//      ),
//    );
  }

}