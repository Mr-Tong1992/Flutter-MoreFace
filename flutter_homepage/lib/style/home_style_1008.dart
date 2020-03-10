import 'dart:core';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_common/flutter_common.dart';
import 'package:flutter_homepage/utils/VersionTransitionUtils.dart';
import '../model/app_group.dart';
import '../model/home_roll_news.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../model/home_roll.dart';

///公告
class HomeStyle1008 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeStyle1008State();
  }

  AppGroup appGroup;
  List<HomeRollNews> newsList;

  HomeStyle1008({this.appGroup, Key key}) : super(key: key) {
    this.newsList = this.appGroup.roll.rollDatas;
  }
}

class _HomeStyle1008State extends State<HomeStyle1008> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double contentHeight = _getHeightByContentStyle(
        widget.appGroup.roll.contentStyle);
    double footerHeight = 10.0;
    return Container(
      color: Colors.white,
      height: ScreenUtil.getInstance().getRatio() * (contentHeight + footerHeight),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _getWidgetByContentStyle(widget.appGroup.roll.contentStyle),
          Container(
            color: Colors.white,
            height: ScreenUtil.getInstance().getRatio() * footerHeight,
          ),
        ],
      ),
    );
  }

  Widget _getWidgetByContentStyle(int contentStyle) {
    if (contentStyle == 0) {
      return _homeGroupScrollTwoLineWidget();
    } else if (contentStyle == 1) {
      return _scrollOneItemTwoLineWidget();
    } else {
      return _scrollOneItemOneLineWidget();
    }
  }

  double _getHeightByContentStyle(int contentStyle) {
    if (contentStyle == 0) {
      return 75.0;
    } else if (contentStyle == 1) {
      return 64.0;
    } else {
      return 44.0;
    }
  }

  Widget _homeGroupScrollTwoLineWidget() {
    Size size = MediaQuery
        .of(context)
        .size;
    double height = _getHeightByContentStyle(widget.appGroup.roll.contentStyle);
    double swiperWidth = (size.width - ScreenUtil.getInstance().getRatio() *30.0 -ScreenUtil.getInstance().getRatio() * 44.0 - 10.0);
    double swiperHeight = 45.0;
    double ratio = swiperWidth / swiperHeight;
    int count = widget.newsList.length;

    return Container(
      color: Colors.white,
      height: ScreenUtil.getInstance().getRatio() * height,
      child: Padding(
        padding: EdgeInsets.only(left: ScreenUtil.getInstance().getRatio() * 15.0, right: ScreenUtil.getInstance().getRatio() * 15.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    child: Image.asset(
                      'images/home_topline.png',
                      package: 'flutter_homepage',
                      width: ScreenUtil.getInstance().getRatio() * 44.0 ,
                      height: ScreenUtil.getInstance().getRatio() * 44.0,
                    ),
                    onTap: ()=>_onClickLeftIcon(),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Container(
                color: Colors.white,
                height: ScreenUtil.getInstance().getRatio() * _getHeightByContentStyle(
                    widget.appGroup.roll.contentStyle),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: ScreenUtil.getInstance().getRatio() * 10.0),
                      child: SizedBox(
                        height: ScreenUtil.getInstance().getRatio() * swiperHeight,
                        width:  swiperWidth,
                        child: Swiper(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: count,
                          itemBuilder: (BuildContext context, int index) {
                            return _getTwoLineWidgetAtIndex(index, ratio);
                          },
                          autoplay: true,
                          scrollDirection: Axis.vertical,
                          autoplayDisableOnInteraction: true,
                        ),
                      ),
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

  Widget _scrollOneItemTwoLineWidget() {
    return null;
  }

  /// 两行
  Widget _getTwoLineWidgetAtIndex(int index, double ratio) {
    List<HomeRollNews> list = _getDisplayNewsListAtIndex(index);
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      width: ScreenUtil.getInstance().getRatio() * (size.width - 30.0 - 44.0 - 10.0),
      height: ScreenUtil.getInstance().getRatio() * 45,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          HomeRollNews item = list[index];
          return _getNewsRowAtIndex(item, index);
        },
      ),
    );
  }
  Widget _getNewsRowAtIndex(HomeRollNews news, int index) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            child: SizedBox(
              height: ScreenUtil.getInstance().getRatio() * 22.5,
              child: Row(
                children: <Widget>[
                  _getTagWidget(news),
                  _getContentWidget(news),
                ],
              ),
            ),
            onTap: () => _onClickScrollNews(news),
          ),
        ],
      ),
    );
  }

  /// 点击某条滚动新闻事件处理
  _onClickScrollNews(HomeRollNews news) async {
    VersionTransitionUtils.instance.newDetailClick(news);
//    FlutterPlugin.pushNewsDetail(news.toJson());
  }

  /// 点击左侧Icon事件处理
  _onClickLeftIcon() async {
    HomeRoll roll = widget.appGroup.roll;
    Map<String, dynamic> params = Map();
    params['linkType'] = roll.linkType;
    params['linkUrl'] = roll.linkUrl;

    VersionTransitionUtils.instance.newIconClick(params);

    //FlutterPlugin.pushNewsList(params);
  }
  
  Widget _getContentWidget(HomeRollNews news) {
    String title;
    if (news.dataType == 0) {
      title = news.topline.title;
    } else {
      title = news.notice.title;
    }

    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: ScreenUtil.getInstance().getRatio() * 10, right: ScreenUtil.getInstance().getRatio() * 15.0),
        child: Text(
          title,
          style: TextStyle(fontSize: ScreenUtil.getInstance().getSp(14.0),fontWeight:FontWeight.normal, color: Color(0xff333333), decoration: TextDecoration.none,),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _getTagWidget(HomeRollNews news) {
//    if(news.topline.tagState == 1) {
//      return null;
//    }

    Color textColor;
    String tagTitle;
    if (news.dataType == 0) {
      if (news.topline.tagType == 1) {
        tagTitle = ' 专题 ';
        textColor = Color(0xff3395ff);
      } else if (news.topline.tagType == 2) {
        tagTitle = ' 热点 ';
        textColor = Color(0xffff9e00);
      } else {
        tagTitle = ' 最新 ';
        textColor = Color(0xffdf3031);
      }
    } else {
//      newsTitle = news.

      tagTitle = ' 最新 ';
      textColor = Color(0xffdf3031);
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(
          color: textColor,
          width: 0.5,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(2.0),
        ),
      ),
      child: Container(
        height: ScreenUtil.getInstance().getRatio() * 15.0,
        child: Text(tagTitle, style: TextStyle(
            fontSize: ScreenUtil.getInstance().getSp(10.0), color: textColor, decoration: TextDecoration.none,fontWeight: FontWeight.normal),),
      ),
    );
  }

  List<HomeRollNews> _getDisplayNewsListAtIndex(int index) {
    List<HomeRollNews> list = List.from(widget.newsList);
    list.addAll(widget.newsList);

    List<HomeRollNews> currentList = [];
    currentList.add(list[2 * index]);
    currentList.add(list[2 * index + 1]);

    return currentList;
  }

  ///
  /// 轮播：一行
  ///
  Widget _scrollOneItemOneLineWidget() {

    Size size = MediaQuery
        .of(context)
        .size;
    double height = _getHeightByContentStyle(widget.appGroup.roll.contentStyle);
    double swiperWidth = (size.width - ScreenUtil.getInstance().getRatio() *30.0 - ScreenUtil.getInstance().getRatio() *41.0 - 8.0);
    double swiperHeight = 44.0;
    double ratio = swiperWidth / swiperHeight;
    int count = widget.newsList.length;

    return Container(
      color: Colors.white,
      height: ScreenUtil.getInstance().getRatio() *  height,
      child: Padding(
        padding: EdgeInsets.only(left: ScreenUtil.getInstance().getRatio() *  15.0, right: ScreenUtil.getInstance().getRatio() *  15.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    child: Image.asset(
                      'images/home_announce.png',
                      package: 'flutter_homepage',
                      width: ScreenUtil.getInstance().getRatio() *  41.0,
                      height: ScreenUtil.getInstance().getRatio() *  21.0,
                    ),
                    onTap: ()=>_onClickLeftIcon(),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Container(
                color: Colors.white,
                height: ScreenUtil.getInstance().getRatio() *  _getHeightByContentStyle(
                    widget.appGroup.roll.contentStyle),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: SizedBox(
                        height: ScreenUtil.getInstance().getRatio() *  swiperHeight,
                        width: swiperWidth,
                        child: Swiper(
                          loop: false,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: count,
                          itemBuilder: (BuildContext context, int index) {
                            return _getOneLineWidgetAtIndex(index, ratio);
                          },
                          autoplay: true,
                          scrollDirection: Axis.vertical,
                          autoplayDisableOnInteraction: true,
                        ),
                      ),
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

  Widget _getOneLineWidgetAtIndex(int index, double ratio) {
    List<HomeRollNews> list = _getOneDisplayNewsListAtIndex(index);
    Size size = MediaQuery
        .of(context)
        .size;
    return Container(
      color: Colors.white,
      width: ScreenUtil.getInstance().getRatio() *  (size.width - 30.0 - 41.0 - 8.0),
      height: ScreenUtil.getInstance().getRatio() *  44,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          HomeRollNews item = list[index];
          return _getOneNewsRowAtIndex(item, index);
        },
      ),
    );
  }

  Widget _getOneNewsRowAtIndex(HomeRollNews news, int index) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            child: SizedBox(
              height: ScreenUtil.getInstance().getRatio() *  44.0,
              child: Row(
                children: <Widget>[
                  _getTagWidget(news),
                  _getContentWidget(news),
                ],
              ),
            ),
            onTap: () => _onClickScrollNews(news),
          ),
        ],
      ),
    );
  }

  List<HomeRollNews> _getOneDisplayNewsListAtIndex(int index) {
    List<HomeRollNews> list = List.from(widget.newsList);
    list.addAll(widget.newsList);

    List<HomeRollNews> currentList = [];
    currentList.add(list[index]);

    return currentList;
  }
}
