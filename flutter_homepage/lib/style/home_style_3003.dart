import 'package:flutter/material.dart';
import 'package:flutter_common/flutter_common.dart';
import 'package:flutter_common/utils/color_utils.dart';
import 'package:flutter_common/utils/font_utils.dart';
import 'package:flutter_common/utils/image_utils.dart';
import 'package:flutter_homepage/model/app_group.dart';
import 'package:flutter_homepage/model/services_app.dart';
import 'package:flutter_homepage/utils/VersionTransitionUtils.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'Home_section_style.dart';

class HomeStyle3003 extends StatefulWidget {
  @override
  _HomeStyle3003State createState() => _HomeStyle3003State();
  AppGroup appGroup;
  List<ServicesApp> appList; // 所有应用

  List<List<ServicesApp>> appSections = []; //每个分组的应用（每三个应用一组）
  HomeStyle3003({this.appGroup, Key key}) : super(key: key) {
    this.appList = this.appGroup.appInfoList;

    /// 每三个一组，组装数据
    List<ServicesApp> list = [];
    //取数组中3的倍数
    int length = (this.appList.length ~/ 3) * 3;
    for (int i = 0; i < length; i++) {
      if (i % 3 == 0) {
        list = new List();
        this.appSections.add(list);
      }
      list.add(this.appList[i]);
      //当最后一组不是3的倍数移除最后一组，确保是3的倍数
//      if(this.appSections.last.length < 3){
//        this.appSections.removeLast();
//      }
    }
  }

  static double height() {
    return ScreenUtil.getInstance().getRatio() *
        (HomeSectionStyle.height() + 169.0);
  }
}

class _HomeStyle3003State extends State<HomeStyle3003> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            HomeSectionStyle(this.widget.appGroup),
            _cellItemContainer(context)
          ],
        ));
  }

  _cellItemContainer(BuildContext context) {
    return Container(
      height: ScreenUtil.getInstance().getRatio() * 169.0,
      margin: EdgeInsets.only(
          left: ScreenUtil.getInstance().getRatio() * 16,
          right: ScreenUtil.getInstance().getRatio() * 16),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: _cellItem(context),
    );
  }

  _cellItem(BuildContext context) {
    return new SizedBox(
      child: new Swiper(
        itemCount: this.widget.appSections?.length ?? 0,
        outer: true,
        itemBuilder: (BuildContext context, int index) {
          List<ServicesApp> list = this.widget.appSections[index];
          return _gridNavItem(context, false, list);
        },
        pagination: new SwiperPagination(
            margin: EdgeInsets.all(5.0),
            alignment: Alignment.bottomCenter,
            builder: DotSwiperPaginationBuilder(
              size: this.widget.appSections.length > 1 ? 6 : 0,
              activeSize: this.widget.appSections.length > 1 ? 6 : 0,
              color: ColorUtils.kColore7e4e5,
              activeColor: ColorUtils.kColorf75348,
            )),
        autoplay: false,
        autoplayDisableOnInteraction: _isAutoPlay(),
        physics: _getScrollPhysics(),
      ),
    );
  }

  bool _isAutoPlay() {
    return this.widget.appSections.length > 1 ? true : false;
  }

  ScrollPhysics _getScrollPhysics() {
    if (_isAutoPlay() == true) {
      return BouncingScrollPhysics();
    }
    return NeverScrollableScrollPhysics();
  }

  //private

  _gridNavItem(BuildContext context, bool first, List<ServicesApp> apps) {
    List<Widget> items = [];
    items.add(_mainItem(context, apps.first));
    items.add(_doubleItem(context, apps.sublist(1)));
    List<Widget> expandItems = [];
    items.forEach((item) {
      expandItems.add(Expanded(child: item, flex: 1));
    });
    Color startColor = Color(int.parse('0xFFFBFBFB'));
    Color endColor = Color(int.parse('0xFFFBFBFB'));
    return Container(
      height: ScreenUtil.getInstance().getRatio() * 169,
      decoration: BoxDecoration(
          //线性渐变
          gradient: LinearGradient(colors: [startColor, endColor])),
      child: Row(children: expandItems),
    );
  }

  /// 左侧视图
  _mainItem(BuildContext context, ServicesApp app) {
    return GestureDetector(
        onTap: () => _onClickedApp(app),
        child: Container(
          decoration: BoxDecoration(
            color: ColorUtils.kColorFBFBFB,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Stack(
            alignment: Alignment.center,
            fit: StackFit.expand,
            children: <Widget>[
              Positioned(
                right: 0.0,
                bottom: 0.0,
                width: ScreenUtil.getInstance().getRatio() * 169,
                height: ScreenUtil.getInstance().getRatio() * 112.0,
                child: ToonImage.networkImage(
                    url: app?.appPic,
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: double.infinity),
              ),
              Positioned(
                top: ScreenUtil.getInstance().getRatio() * 19.7,
                left: ScreenUtil.getInstance().getRatio() * 8,
                child: Container(
                  child: Text(
                    app.appTitle ?? '',
                    style: TextStyle(
                        fontSize: ScreenUtil.getInstance().getSp(17),
                        color: ColorUtils.kColor5B5B5B,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.none),
                  ),
                ),
              ),
              Positioned(
                top: ScreenUtil.getInstance().getRatio() * 45.9,
                left: ScreenUtil.getInstance().getRatio() * 8,
                child: Container(
                  child: Text(
                    app.appSubTitle ?? "",
                    style: TextStyle(
                        fontSize: ScreenUtil.getInstance().getSp(12),
                        color: ColorUtils.kColor9C9C9C,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  /// 右侧视图
  _doubleItem(BuildContext context, List<ServicesApp> apps) {
    return Column(
      children: <Widget>[
        Expanded(
          child: _item(context, true, apps[0]),
        ),
        Expanded(
          child: _item(context, false, apps[1]),
        )
      ],
    );
  }

  _item(BuildContext context, bool first, ServicesApp app) {
    BorderSide borderSide = BorderSide(
        width: ScreenUtil.getInstance().getRatio() * 5, color: Colors.white);
    return GestureDetector(
      onTap: () => _onClickedApp(app),
      child: FractionallySizedBox(
        //撑满父布局的宽度
        widthFactor: 1,
        child: Container(
            decoration: BoxDecoration(
                border: Border(
              left: borderSide,
              bottom: first ? borderSide : BorderSide.none,
            )
//                  , borderRadius: BorderRadius.circular(4),
                ),
            child: Container(
              decoration: BoxDecoration(
                color: ColorUtils.kColorFBFBFB,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Stack(
                alignment: Alignment.center,
                fit: StackFit.expand,
                children: <Widget>[
                  Positioned(
                    right: 0.0,
                    bottom: 0.0,
                    width: ScreenUtil.getInstance().getRatio() * 90,
                    height: ScreenUtil.getInstance().getRatio() * 60.0,
                    child: ToonImage.networkImage(
                        url: app.appPic,
                        fit: BoxFit.fill,
                        width: double.infinity,
                        height: double.infinity),
                  ),
//              Container(
//                child: ClipRRect(
//                  borderRadius: BorderRadius.circular(4),
//                  child:ToonImage.networkImage(url:app.appPic,fit: BoxFit.fill,width: double.infinity,height: double.infinity),
//                ),
//              ),
                  Positioned(
                    top: ScreenUtil.getInstance().getRatio() * 19.0,
                    left: ScreenUtil.getInstance().getRatio() * 8,
                    child: Container(
                      child: Text(
                        app.appTitle ?? '',
                        style: TextStyle(
                            fontSize: ScreenUtil.getInstance().getSp(17),
                            color: ColorUtils.kColor5B5B5B,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.none),
                      ),
                    ),
                  ),
                  Positioned(
                    top: ScreenUtil.getInstance().getRatio() * 46.0,
                    left: 8,
                    child: Container(
                      child: Text(
                        app.appSubTitle ?? '',
                        style: TextStyle(
                            fontSize: ScreenUtil.getInstance().getSp(12),
                            color: ColorUtils.kColor9C9C9C,
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  _onClickedApp(ServicesApp app) {
    VersionTransitionUtils.instance.appItemClick(app);
  }
}
