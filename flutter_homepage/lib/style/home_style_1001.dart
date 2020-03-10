import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:flutter_common/flutter_common.dart';
import 'package:flutter_common/utils/image_utils.dart';
import 'package:flutter_homepage/utils/VersionTransitionUtils.dart';
import 'package:flutter_homepage/utils/home_utils.dart';
import 'package:flutter_homepage/utils/skin_utils.dart';
import '../model/app_group.dart';
import '../model/services_app.dart';
import '../utils/home_utils.dart';

class HomeStyle1001 extends StatefulWidget {
  @override
  _HomeStyle1001State createState() => new _HomeStyle1001State();

  HomeStyle1001({AppGroup appGroup, Key key}) : super(key: key) {
    this.appGroup = appGroup;
    if ((SpUtil.getString("isUseLocal1001_" + HomeUtils.instance.userId) ==
            "1") &&
        (SpUtil.getString('1001appinfoLIst_' + HomeUtils.instance.userId)
            .isNotEmpty)) {
      List<Object> list = getLocalList();
      if (list.length > 4) {
        mHeight = 194;
        gridViewHeight = 160;
      } else {
        mHeight = 107;
        gridViewHeight = 72;
      }
      this.appList = list.map((value) => ServicesApp.fromJson(value)).toList();
    } else {
      this.appList = appGroup.appInfoList;
    }
  }

  static double height() {
    if ((SpUtil.getString("isUseLocal1001_" + HomeUtils.instance.userId) ==
            "1") &&
        (SpUtil.getString('1001appinfoLIst_' + HomeUtils.instance.userId)
            .isNotEmpty)) {
      List<Object> list  = getLocalList();
      if (list.length > 4) {
        return ScreenUtil.getInstance().getRatio() * 160;
      } else {
        return ScreenUtil.getInstance().getRatio() * 72;
      }
    }
    return ScreenUtil.getInstance().getRatio() * 160;
  }

  static List getLocalList() {
    String jsonData =
        SpUtil.getString('1001appinfoLIst_' + HomeUtils.instance.userId);
    List<Object> list;
    return json.decode(jsonData);
  }

  AppGroup appGroup;
  List<ServicesApp> appList;
  double mHeight = 194;
  double gridViewHeight = 160;
}

class _HomeStyle1001State extends State<HomeStyle1001> {
  bool isChangeSkin = false;
  Map<int, String> map;
  ScreenUtil screenUtil = ScreenUtil.getInstance();

  _isChangeSkin() async {
    isChangeSkin = await FlutterPlugin.isChangeSkin();
    if (isChangeSkin) {
      map = await FlutterPlugin.getSkinJsonData(
          "style1001", this.widget.appList.length);
      setState(() {});
    }
  }

  _getLocalAppList() async {
    await SpUtil.reload();
    String key = HomeUtils.instance.userId;
    String jsonData =
        SpUtil.getString('1001appinfoLIst_' + HomeUtils.instance.userId);
    List<Object> list;
    list = json.decode(jsonData);
    List<ServicesApp> editedApps =
        list.map((value) => ServicesApp.fromJson(value)).toList();
    this.widget.appList = editedApps;
    if (editedApps.length > 4) {
      this.widget.mHeight = 194;
      this.widget.gridViewHeight = 160;
    } else {
      this.widget.mHeight = 107;
      this.widget.gridViewHeight = 72;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _isChangeSkin();
    FlutterPlugin.addListener("isChange1001", (Map<String, dynamic> map) async {
      SpUtil.putString("isUseLocal1001_" + HomeUtils.instance.userId, "1");
      _getLocalAppList();
    });

    FlutterPlugin.addListener('changeSkin', (Map<String, dynamic> map) async {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    //应用数量
    int itemCount =
        this.widget.appList.length > 8 ? 8 : this.widget.appList.length;

    return Container(
      height: screenUtil.getRatio() * this.widget.mHeight,
      width: screenUtil.getRatio() * 375,
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 0,right: 0),
      child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          overflow: Overflow.clip,
          children: <Widget>[
            Container(
              height: screenUtil.getRatio() * this.widget.mHeight,
              width: screenUtil.getRatio() * 375,
              child: ToonImage.networkImage(
                  url: this.widget.appGroup.backGroupImg,
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: double.infinity),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.only(left: 17, right: 17),
                    child: Container(
                      child: SizedBox(
                        height: screenUtil.getRatio() * this.widget.gridViewHeight,
                        child: GridView.builder(
                            padding: EdgeInsets.all(0.0),
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4, //每行四列
                            ),
                            itemCount: itemCount,
                            itemBuilder: (context, index) {
                              ServicesApp app = this.widget.appList[index];
                              return appWidgetAtIndex(app, index);
                            }),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]),
    );
  }

  Widget appWidgetAtIndex(ServicesApp app, int index) {
    return Container(
      height: ScreenUtil.getInstance().getRatio() * 65,
      child: Padding(
        padding: EdgeInsets.all(0.0),
        child: GestureDetector(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                constraints: BoxConstraints(
                    minHeight: ScreenUtil.getInstance().getRatio() * 44,
                    maxHeight: ScreenUtil.getInstance().getRatio() * 44),
                decoration: getDecorationWithIndex(index),
                child: imageWidgetBySrc(app?.appIcon, index, map),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: ScreenUtil.getInstance().getRatio() * 4),
                child: Text(app.appTitle,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: screenUtil.getSp(12),
                        fontWeight: FontWeight.w400,
                        color: ColorUtils.kColor4A4A4A,
                        decoration: TextDecoration.none)),
              ),
            ],
          ),
          onTap: () => _onClickedServiceApp(app, index, this.widget.appGroup),
        ),
      ),
    );
  }

  Widget imageWidgetBySrc(String src, int index, Map map) {
    if (isChangeSkin && map != null && map.length > 0) {
      src = map[index];
      return new Image.file(new File(src),
          width: ScreenUtil.getInstance().getRatio() * 44);
    }
    if (src.startsWith('http') || src.startsWith('https')) {
      return ToonImage.networkImage(
          url: src, width: ScreenUtil.getInstance().getRatio() * 44);
    }
    return new Image.asset('images/home_app_default.png',
        package: 'flutter_homepage',
        width: ScreenUtil.getInstance().getRatio() * 44);
  }

  BoxDecoration getDecorationWithIndex(int index) {
    if (index == 7) {
      return BoxDecoration(color: Colors.white);
    }
    return BoxDecoration(color: Colors.white);
  }

  _onClickedServiceApp(ServicesApp app, int index, AppGroup group) async {
    if (app.appId == 1) {
      // 全部
      Map<String, dynamic> params = new Map<String, dynamic>();
      params['appId'] = group?.appGroupId ?? ''; // 原生此处用的是linkUrl
      params['isOrg'] = group?.isOrg ?? '';
      params['orgAppCategory'] = group?.orgAppCategory ?? '';
      params['SPKey'] = '1001appinfoLIst_' + HomeUtils.instance.userId;
      params['hadRole'] = HomeUtils.instance.currentRole == null ? 0 : 1;
      FlutterPlugin.allApps(params);

      Map<String, Object> map = new Map();
      map["service_id"] = app.appId.toString();
      map["service_name"] = app.appTitle;
      map["service_url"] = app.appUrl;
      FlutterPlugin.itemAppClickBuried(map);
    } else {
      VersionTransitionUtils.instance.appItemClick(app);
    }
  }
}
