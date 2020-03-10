import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:flutter_common/flutter_common.dart';
import 'package:flutter_homepage/model/home_juhe.dart';
import 'package:flutter_homepage/model/home_setting_function.dart';
import 'package:flutter_homepage/model/home_settings.dart';

import 'home_style_factory.dart';

class HomeHeaderWithoutRolesNavigationBar extends StatefulWidget {
  HomeJuHe firstHeader;
  List<HomeJuHe> headers;
  HomeSettings settings;
  String placeholder = '查找服务';

  @override
  State<StatefulWidget> createState() =>
      HomeHeaderWithoutRolesNavigationBarState();

  HomeHeaderWithoutRolesNavigationBar(
      {this.settings, this.headers, String placeholder, Key key})
      : super(key: key) {
    if (placeholder != null) {
      this.placeholder = placeholder;
    }
    if (headers.length > 0) {
      this.firstHeader = this.headers[0];
    }
  }
}

class HomeHeaderWithoutRolesNavigationBarState
    extends State<HomeHeaderWithoutRolesNavigationBar> {
  double scrollOffset;
  int step;

  @override
  void initState() {
    FlutterPlugin.addListener("stepChange", (Map<String, dynamic> map) async {
      setState(() {
        step = map["step"];

      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topStart,
      overflow: Overflow.clip,
      fit: StackFit.expand,
      children: <Widget>[
        Container(
            color: _backgroundColor(),
            width: ScreenUtil
                .getInstance()
                .screenWidth,
            child: Padding(
              padding: EdgeInsets.only(bottom: 1.0),
              child: Row(
                children: <Widget>[
                  _temperatureWigget(),
                  _weatherWidget(),
                  Flexible(
                    flex: 1,
                    child: _searchWidget(),
                  ),
                  //_scanWidget(),
                  _functionListView(),
                ],
              ),
            )),
        Positioned(
          left: 0.0,
          right: 0.0,
          bottom: 0.2,
          height: 1.0,
          child: _speratorLine(),
        ),
      ],
    );
  }

  ///温度
  Widget _temperatureWigget() {
    return Padding(
      padding: EdgeInsets.only(
          left: ScreenUtil.getInstance().getRatio() * 10,
          top: ScreenUtil.getInstance().getRatio() * (18 + _marginByOffset())),
      child: Container(
          height: ScreenUtil.getInstance().getRatio() * 35,
          constraints: BoxConstraints(
              minWidth: ScreenUtil.getInstance().getRatio() * 95),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text(this.widget.firstHeader?.temperature ?? "",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: _titleColor(),
                        fontSize: ScreenUtil.getInstance().getSp(25.0),
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none)),
              ),
            ],
          )),
    );
  }

  ///天气
  Widget _weatherWidget() {
    return Padding(
      padding: EdgeInsets.only(
          left: ScreenUtil.getInstance().getRatio() * 1.0,
          top: ScreenUtil.getInstance().getRatio() * (18 + _marginByOffset())),
      child: Container(
          height: ScreenUtil.getInstance().getRatio() * 35,
          constraints: BoxConstraints(maxWidth: 150.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(
                  this.widget.firstHeader?.weather ?? "",
                  textAlign: TextAlign.left,
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: ScreenUtil.getInstance().getSp(9.0),
                      color: _titleColor(),
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 0),
                child: Text(
                  _weatherExtra(),
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: ScreenUtil.getInstance().getSp(9.0),
                      color: _titleColor(),
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal),
                ),
              )
            ],
          )),
    );
  }

  /// 搜索视图
  Widget _searchWidget() {
    return Padding(
      padding: EdgeInsets.only(
          left: ScreenUtil.getInstance().getRatio() * 0.0,
          top: ScreenUtil.getInstance().getRatio() * (18 + _marginByOffset())),
      child: GestureDetector(
        onTap: () => _search(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: ScreenUtil.getInstance().getRatio() * 35,
              margin: EdgeInsets.only(
                  left: ScreenUtil.getInstance().getRatio() * 8.0),
              decoration: new BoxDecoration(
                color: _searchBackgroundColor(),
                borderRadius: BorderRadius.all(Radius.circular(14.0)),
              ),
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () => _search(),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              left: ScreenUtil.getInstance().getRatio() * 13.0),
                          child: Image.asset(
                            'images/home_navigationbar_search.png',
                            package: 'flutter_homepage',
                            color: _titleColor(),
                            width: ScreenUtil.getInstance().getRatio() * 12.0,
                            height: ScreenUtil.getInstance().getRatio() * 12.0,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: ScreenUtil.getInstance().getRatio() * 5.9,
                              top: 0.0,
                              bottom: 0.0),
                          child: Text(
                            this.widget.placeholder,
                            style: TextStyle(
                                color: _titleColor(),
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                                fontSize: ScreenUtil.getInstance().getSp(12.0)),
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///搜索右侧功能列表
  Widget _functionListView() {
    return Padding(
        padding: EdgeInsets.only(
            left: ScreenUtil.getInstance().getRatio() * 12.0,
            right: ScreenUtil.getInstance().getRatio() * 2.0,
            top:
            ScreenUtil.getInstance().getRatio() * (18.0 + _marginByOffset())),
        child: Container(
            width: ScreenUtil.getInstance().getRatio() * 38.0 *(
                this.widget.settings?.functionList?.length ?? 1),
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: this.widget.settings?.functionList?.length ?? 0,
                itemBuilder: (BuildContext context, int position) {
                  return _getFunction(this.widget.settings?.functionList ?? null,position);
                })));
  }

  Widget _getFunction(List<HomeSettingFunction> functionList, int position) {
    if(functionList != null) {
      switch (functionList[position]?.code) {
        case 1:
        //扫一扫
          return _scanWidget();
        case 2:
        //二维码
          return HomeStyleFactory.transparentWidget(height: 0);
        case 3:
        //小铃铛
          return HomeStyleFactory.transparentWidget(height: 0);
        case 4:
        //福码
          return HomeStyleFactory.transparentWidget(height: 0);
        case 5:
        //公交乘车
          return _scanAndRideWidget();
        default:
          return HomeStyleFactory.transparentWidget(height: 0);
      }
    }else{
      return HomeStyleFactory.transparentWidget(height: 0);
    }
  }

  /// 扫描视图
  Widget _scanWidget() {
    return Padding(
      padding: EdgeInsets.only(
        right: ScreenUtil.getInstance().getRatio() * 10.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: SizedBox(
              width: ScreenUtil.getInstance().getRatio() * 28.0,
              height: ScreenUtil.getInstance().getRatio() * 28.0,
              child: GestureDetector(
                onTap: () => _scanQRCode(),
                child: Image.asset(
                  'images/home_navigationbar_scan.png',
                  package: 'flutter_homepage',
                  color: _titleColor(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///扫码乘车
  Widget _scanAndRideWidget() {
    return Padding(
      padding: EdgeInsets.only(
        right: ScreenUtil.getInstance().getRatio() * 10.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: SizedBox(
              width: ScreenUtil.getInstance().getRatio() * 28.0,
              height: ScreenUtil.getInstance().getRatio() * 28.0,
              child: GestureDetector(
                onTap: () => _scanQRCode(),
                child: Image.asset(
                  'images/home_navigationbar_scan.png',
                  package: 'flutter_homepage',
                  color: _titleColor(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 通知视图
  Widget _notificationWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: 8.0, right: 15.0),
          child: GestureDetector(
            onTap: () => _smallBell(),
            child: Container(
              width: 28.0,
              height: 28.0,
              child: Image.asset('images/home_navigationbar_notification.png',
                  package: 'flutter_homepage', color: _titleColor()),
            ),
          ),
        )
      ],
    );
  }

  /// 扫一扫
  _scanQRCode() {
    Map<String, dynamic> params = {"handleResult": "1"};
    FlutterPlugin.scanQRCode(params);
  }

  /// 角色切换
  _switchRole() {
    FlutterBoost.singleton.open('homepage://switch_role',
        urlParams: {'present': true}, exts: {'alert': true});
  }

  /// 小铃铛
  _smallBell() {
    FlutterPlugin.smallBellNotice();
  }

  // 搜索
  _search() {
    FlutterPlugin.jumpSearch();
//    FlutterBoost.singleton.open('homepage://search', urlParams: {'push':true});
  }

  Widget _speratorLine() {
    double alpha = _alphaByOffset();
    double height = 0.5;
    if (alpha <= 0.8) {
      height = 0.0;
    }

    return Container(
      color: Color.fromRGBO(0xdd, 0xde, 0xe3, alpha),
      height: height,
    );
  }

  void updateNavigationBarByOffset(double offset) {
    setState(() {
      scrollOffset = offset;
    });
  }

  void updateSearchPlaceHolder(String holder) {
    setState(() {
      this.widget.placeholder = holder;
    });
  }

  double _alphaByOffset() {
    if (scrollOffset == null) {
      return 0.0;
    }
    double offset = scrollOffset;
    double alpha = 0.0;
    if (offset <= 30.0) {
      alpha = 0.0;
    } else if (offset > 30.0 && offset <= 60.0) {
      alpha = (offset - 30.0) / 30.0;
    } else {
      alpha = 1.0;
    }
    return alpha;
  }

  double _marginByOffset() {
    if (scrollOffset == null) {
      return 27.0;
    }
    double offset = scrollOffset;
    double margin = 27.0;
    if (offset <= 27.0) {
      margin = 27.0;
    } else if (offset > 27.0 && offset <= 57.0) {
      margin = 27.0 - ((offset - 27) / 2 >= 14.0 ? 14.0 : (offset - 27) / 2);
    } else {
      margin = 14.0;
    }
    return margin;
  }

  Color _backgroundColor() {
    double alpha = _alphaByOffset();
    return Color.fromRGBO(0xff, 0xff, 0xff, alpha);
  }

  Color _titleColor() {
    double alpha = _alphaByOffset();
    return (alpha > 0.8) ? Colors.black : Colors.white;
  }

  Color _searchBackgroundColor() {
    double alpha = _alphaByOffset();
    return (alpha > 0.8)
        ? Color.fromRGBO(0xf3, 0xf5, 0xf9, 1.0)
        : Color.fromRGBO(0xf3, 0xf5, 0xf9, 0.2);
  }

  String _weatherExtra() {
    if (this.widget.settings?.weatherExtra == 1) {
      ///1.限行
      return _getlimitCar();
    } else if (this.widget.settings?.weatherExtra == 2) {
      ///2.步数
      return _getStepQuality();
    } else if (this.widget.settings?.weatherExtra == 3) {
      ///3.空气质量
      return _getAirsQuality();
    } else {
      return '';
    }
  }

  ///天气
  String _getAirsQuality() {
    String aqi = this.widget.firstHeader.AQI;
    String quality = this.widget.firstHeader.quality;
    if (aqi == null) {
      aqi = '';
    }
    if (quality == null) {
      quality = '';
    }
    return '空气质量 ${aqi}  ${quality}';
  }

  ///步数
  String _getStepQuality() {
    return '步数 ${this.step == null ? "0" : this.step.toString()}';
  }

  ///限行
  String _getlimitCar() {
    if (this.widget.firstHeader?.isCarLimit == 1) {
      // 限行
      String carLimitNumber = this.widget.firstHeader.carLimitNumbers;
      if (carLimitNumber == null) {
        return '';
      }
      return carLimitNumber.isNotEmpty ? '限行 ${carLimitNumber}' : '';
    } else {
      return '不限行';
    }
  }
}
