import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_common/flutter_common.dart';
import 'package:flutter_homepage/model/app_group.dart';
import 'package:flutter_homepage/model/home_template.dart';
import 'package:flutter_homepage/utils/HomepageRouter.dart';

class HomeStyleAuth extends StatefulWidget {
  @override
  _HomeStyleAuth createState() => _HomeStyleAuth();
  AppGroup appGroup;

//  HomeTemplate templateJson;

  HomeStyleAuth({this.appGroup, Key key}) : super(key: key) {
//  this.templateJson = this.appGroup.templateJson;
  }
  static double hegiht(){
    return ScreenUtil.getInstance().getRatio() * 60.0;
  }
}

class _HomeStyleAuth extends State<HomeStyleAuth> {
  bool isAuth = false;

  Map<String, dynamic> infoMap;

  @override
  void initState() {
    super.initState();
    _getLocalAuthInfo();
    FlutterPlugin.addListener("getAuthInfo", (Map<String, dynamic> map) async {
      setState(() {
        infoMap = map;
        if (infoMap['anthLevel'] != null && infoMap['anthLevel'] == "L1") {
          isAuth = false;
          SpUtil.putString("isCert", "0");
        } else {
          isAuth = true;
          SpUtil.putString("isCert", "1");
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _authSwitch();
  }

  Widget _authSwitch() {
    if (!isAuth) {
      return _noAuth();
    } else {
      return _transparentWidget();
      //return _isAuth(infoMap);
    }
  }

  Widget _isAuth(Map<String, dynamic> infoMap) {
    String certName = "";
    String sex = "男";
    String title = "";

    if (infoMap == null) {
      throw new UnsupportedError("infoMap Is Null");
    } else {
      certName = infoMap["certName"];
      sex = infoMap["sex"];
    }

    if (sex == "男") {
      title = certName + "先生，您好！";
    } else if (sex == "女") {
      title = certName + "女士，您好！";
    } else {
      throw new UnsupportedError("Error Sex: $sex");
    }

    //todo 认证后样式
    return Container(
      width: ScreenUtil.getInstance().screenWidth,
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20, left: 24.0),
            child: Text(title),
          )
        ],
      ),
    );
  }

  Widget _noAuth() {
    return Container(
      width: ScreenUtil.getInstance().screenWidth,
      height: ScreenUtil.getInstance().getRatio() * 60,
      color: ColorUtils.kColorFFFFFF,
      padding: EdgeInsets.only(left: 0, top: 0, right: 0),
      child: GestureDetector(
          onTap: () => _doAuth(),
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                child: ToonImage.networkImage(
                    url:
                        "http://fast.scloud.systoon.com/f/rp4f8oy28hSxTMpFgA0y+svON5s9zeXdh8sgctoAbpEfF.jpg",
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: double.infinity),
              )
            ],
          )),
    );
  }

  _getLocalAuthInfo() {
    //从本地获取认证信息
    if (SpUtil.getString("isCert") != "0") {
      isAuth = true;
    }
  }
}

Widget _transparentWidget({double height}) {
  return GestureDetector(
    child: Padding(
      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
      child: Container(
        color: ColorUtils.kColorFFFFFF,
        height: height ?? 0,
        width: ScreenUtil.getInstance().screenWidth,
      ),
    ),
  );
}

_doAuth() async {
  FlutterPlugin.doAuthoritation();
}
