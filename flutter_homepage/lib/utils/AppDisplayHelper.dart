import 'package:flutter_homepage/model/home_roll_news_detail.dart';
import 'package:flutter_homepage/model/home_roll_notice_detail.dart';
import 'package:flutter_homepage/model/services_app.dart';

import 'HomepageRouter.dart';

import 'VersionTransitionUtils.dart';
import 'home_utils.dart';

class AppDisplayHelper {
  static final String TAG = "AppDisplayHelper";

  static openAppDisplay(ServicesApp app) async {
    ServicesApp appi = new ServicesApp();
    appi.appUrl = app.appUrl;
    appi.appId = app.appId;
    //不弹窗 不验证等级
    bool isAuth = await HomepageRouter.isAuthLevelValid(app.isAuthentication);
    if(!isAuth){
      return;
    }
//   String toonNo = await HomepageRouter.getToonNo(app.isAuthentication);

    if ((app.appId != null) && (app.appId != 0)) {
      _appendPersonToken(appi);
    }
    _openToonAppDisplay(appi);
  }

  static openTopLineDisplay(HomeRollNewsDetail topline) async {
    if (topline.tagType == 1) {
      //打开专题
      HomepageRouter.openTopLineTopic(topline);
    } else {
      //资讯正文
      HomepageRouter.openTopLineNormal(topline);
    }
  }

  static openNoticeDisplay(HomeRollNoticeDetail notice) {
    if (notice == null) {
      return;
    }
    //0：公告详情-跳转列表，1：外链，2： 应用
    switch (notice.linkType) {
      case 0:
        HomepageRouter.noticeList(id: notice.nid);
        break;
      case 1:
        if (notice.link.isNotEmpty) {
          HomepageRouter.openAppDisplay(url: notice.link, customNav: false);
        }
        break;
      case 2:
      //todo 跳转外部应用 该方法并未实现
      //VersionTransitionUtils.instance.appItemClick(notice.linkApp);
        break;
      default:
        break;
    }
  }

  static void _appendPersonToken(ServicesApp app) {
    if (app.appUrl.contains("?")) {
      app.appUrl +="&personToken=";
    } else {
      app.appUrl +="?personToken=";
    }
    String personToken = HomeUtils.instance.personToken;
    app.appUrl += personToken;
  }

  static void _openToonAppDisplay(ServicesApp app) {
    if (app.appUrl.isEmpty) {
      return;
    }
    if (app.appUrl.startsWith("MWAP:")) {
      // 未改造的应用跳转, 截掉前缀获取真正URL
      String url = app.appUrl.substring("MWAP:".length, app.appUrl.length);
      HomepageRouter.openMwapAppDisplay(url: url);
    } else {
      HomepageRouter.openMwapAppDisplay(url: app.appUrl, appId: app.appId);
    }
  }
}
