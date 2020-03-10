import 'package:flutter/material.dart';
import 'package:flutter_common/utils/color_utils.dart';
import 'package:flutter_homepage/model/app_group.dart';
import 'package:flutter_homepage/model/services_app.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_common/flutter_common.dart';
import 'Home_section_style.dart';
import '../utils/VersionTransitionUtils.dart';

class HomeStyle3001 extends StatefulWidget {
  @override
  _HomeStyle1017State createState() => _HomeStyle1017State();

  AppGroup appGroup;
  int bannerCount;

  List<ServicesApp> appList;
  List<List<ServicesApp>> appSections = []; //每五个应用一组
  HomeStyle3001({this.appGroup, Key key}) : super(key: key) {
    this.appList = this.appGroup.appInfoList;
    List<ServicesApp> list = [];
    for (int i = 0; i < this.appList.length; i++) {
      if (i % 5 == 0) {
        list = new List();
        this.appSections.add(list);
      }
      list.add(this.appList[i]);
    }
  }

  static double hegiht() {
    return HomeSectionStyle.height() +
        ScreenUtil.getInstance().getRatio() * 100.0;
  }
}

class _HomeStyle1017State extends State<HomeStyle3001> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          HomeSectionStyle(this.widget.appGroup),
          _cellItem(context)
        ],
      ),
    );
  }

  _cellItem(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: ScreenUtil.getInstance().getRatio() * 100,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: new Swiper(
        outer: false,
        itemBuilder: (c, i) {
          List<ServicesApp> apps = this.widget.appSections[i];
          return GridView.builder(
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5, //每行四列
                  childAspectRatio: 1.0),
              itemCount: apps.length,
              itemBuilder: (context, index) {
                ServicesApp app = apps[index];
                return getItemContainer(app);
              });
        },
        pagination: SwiperPagination(
            margin: EdgeInsets.all(5.0),
            builder: DotSwiperPaginationBuilder(
              size: this.widget.appSections.length > 1 ? 6 : 0,
              activeSize: this.widget.appSections.length > 1 ? 6 : 0,
              color: ColorUtils.kColore7e4e5,
              activeColor: ColorUtils.kColorf75348,
            )),
        autoplay: false,
        autoplayDisableOnInteraction: _isAutoPlay(),
        physics: _getScrollPhysics(),
        itemCount: this.widget.appSections?.length,
      ),
    );
  }

  Widget getItemContainer(ServicesApp model) {

    double width = ScreenUtil.getScreenW(context);
    double top = ScreenUtil.getInstance().getRatio() * 10;
    if(width >= 414){
      // plus 机型
      top -= 8;
    }

    return GestureDetector(
      onTap: () => _onClickedApp(model),
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            new Container(
              margin:
                  EdgeInsets.only(top: ScreenUtil.getInstance().getRatio() * 4),
              height: ScreenUtil.getInstance().getRatio() * 44,
              width: ScreenUtil.getInstance().getRatio() * 44,
              decoration: BoxDecoration(
                color: ColorUtils.kColorFBFBFB,
                borderRadius: BorderRadius.circular(19),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(19),
                child: Image.network(model?.appIcon ?? "",
                    height: ScreenUtil.getInstance().getRatio() * 44,
                    width: ScreenUtil.getInstance().getRatio() * 44),
              ),
            ),
            new Padding(
              padding: new EdgeInsets.only(
                  top: top),
              child: new Text(
                model?.appTitle ?? "",
                overflow: TextOverflow.clip,
                maxLines: 1,
                style: TextStyle(
                    color: ColorUtils.kColor5c5c5c,
                    fontSize: ScreenUtil.getInstance().getSp(12),
                    fontWeight: FontWeight.normal,
                    decoration: TextDecoration.none),
              ),
            )
          ],
        ),
        color: Colors.white,
      ),
    );
  }

  int _paginationCount() {
    return this.widget.appSections.length > 1 ? 6 : 0;
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

  _onClickedApp(ServicesApp app) {
    VersionTransitionUtils.instance.appItemClick(app);
  }
}
