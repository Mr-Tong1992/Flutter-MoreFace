import 'package:flutter_common/flutter_common.dart';
import 'package:flutter_homepage/model/home_roll_news_detail.dart';
import 'dart:convert' as convert;

class HomepageRouter {
  static final String TAG = "HomepageRouter";
  static final String scheme = "toon";

  static void openAppDisplay({String url, bool customNav}) {
    if (url.isEmpty) {
      return;
    }
    Map<String, dynamic> params = new Map();
    params["appUrl"] = url;
    Map<String, dynamic> appInfo = new Map();
    appInfo["customNav"] = false;
    appInfo["unscalable"] = false;
    params["appInfo"] = convert.jsonEncode(appInfo);
    FlutterPlugin.openNotice(params);
  }

  static Future<bool> isAuthLevelValid(int isAuthentication) async {
    Map<String, dynamic> params = new Map();
    params["isAuthentication"] = isAuthentication;
    return await FlutterPlugin.isAuthLevelValid(params);
  }

  static Future<String> getToonNo(int isAuthentication) async {
    try {
      Map<String, dynamic> params = new Map();
      params["isAuthentication"] = isAuthentication;
      return await FlutterPlugin.getToonNo(params);
    } catch (e) {
      Log.d(e.toString());
    }
    return null;
  }

  static void openMwapAppDisplay({String url, int appId}) {
    if (url.isEmpty) {
      return;
    }
    Map<String, dynamic> params = new Map();
    params["appUrl"] = url;
    params["appId"] = appId;
    FlutterPlugin.routerOpen(params);
  }

  static void openTopLineTopic(HomeRollNewsDetail topline) {
    Map<String, dynamic> params = new Map();
    params["contentId"] = topline.contentId;
    params["title"] = topline.title;
    FlutterPlugin.openTopLineTopic(params);
  }

  static void openTopLineNormal(HomeRollNewsDetail topline) {
    Map<String, dynamic> params = new Map();
    params["contentId"] = topline.contentId;
    params["fileUrl"] = topline.fileUrl;
    FlutterPlugin.openTopLineNormal(params);
  }

  static void noticeList({int id}) {
    //todo 缺少flutter二级页面 目前为跳转到原生的二级界面
    Map<String, dynamic> params = new Map();
    params["id"] = id;
    FlutterPlugin.openNoticeList(params);
  }

  static void switchMainActivityForTopline() {
    FlutterPlugin.switchMainActivityForTopline();
  }

}
