import 'package:flutter_common/flutter_common.dart';
import 'package:flutter_homepage/model/home_roll_news.dart';
import 'package:flutter_homepage/model/home_roll_news_detail.dart';
import 'package:flutter_homepage/model/home_roll_notice_detail.dart';
import 'package:flutter_homepage/model/services_app.dart';
import 'package:flutter_homepage/net/home_services.dart';

import 'AppDisplayHelper.dart';
import 'HomepageRouter.dart';

class VersionTransitionUtils {
  static VersionTransitionUtils _transitionUtils = new VersionTransitionUtils();

  static VersionTransitionUtils get instance => _transitionUtils;

  void _jumpHtml(ServicesApp app) => AppDisplayHelper.openAppDisplay(app);

  void _jumpTopLine(HomeRollNewsDetail topline) => AppDisplayHelper.openTopLineDisplay(topline);

  void _jumpNotice(HomeRollNoticeDetail notice) =>AppDisplayHelper.openNoticeDisplay(notice);

  //对外暴露方法 单击应用
  void appItemClick(ServicesApp app) {
    ///记录用户的访问服务
     Map<String, dynamic> params = new Map<String, dynamic>();
            params['serviceCode'] = app.id;
            params['toonTye'] =207;
    HomeServices.requestAddVisitingRecord(
        params: params,
        onSuccess: (message) {},
        onError: (code, msg) {
        });
    if (app == null) { return; }
    Map<String,Object> map = new Map();
    map["service_id"] = app.appId.toString();
    map["service_name"] = app.appTitle;
    map["service_url"] = app.appUrl;
    //埋点
    FlutterPlugin.itemAppClickBuried(map);
    int appType = app?.appType;
    if (appType == 1) {
      /// 打开第三方应用
      _openAppOrDownload(app);
    } else {
      //todo 西客站蓝牙信标定位服务host。
      _jumpHtml(app);
    }
  }

  //对外暴露方法 单击新闻
  void newDetailClick(HomeRollNews news) {
    int dataType = news.dataType;
    //资讯 topline
    if (dataType == 0) {
      HomeRollNewsDetail topline = news.topline;
      _jumpTopLine(topline);
    }
    //公告 notice
    else {
      HomeRollNoticeDetail notcie = news.notice;
      _jumpNotice(notcie);
    }
  }

  //对外暴露方法 单击新闻图标
  void newIconClick(Map<String, dynamic> params) {
    //todo 埋点
    int linkType = params['linkType'];
    String linkUrl = params['linkUrl'];
    //linkType;//跳转类型 0：链接，1：应用 2:头条 3:公告列表
    switch (linkType){
      case 0:
        if (linkUrl.isNotEmpty){
          HomepageRouter.openAppDisplay(url:linkUrl,customNav:false);
        }
        break;
      case 1:
        //todo 打开外部应用
          //appItemClick();
        break;
      case 2:
        HomepageRouter.switchMainActivityForTopline();
        break;
      case 3:
        HomepageRouter.noticeList();
        break;
      default:

        break;
    }
  }


  void _openAppOrDownload(ServicesApp app) {
    String appTitle = app.appTitle;
    if (appTitle.isNotEmpty) {
      //todo 通过包名打开app

      return;
    } else {
      _jumpHtml(app);
    }
  }
}
