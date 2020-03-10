import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_homepage/model/home_juhe.dart';
import 'package:flutter_homepage/model/home_settings.dart';
import 'package:flutter_homepage/style/home_style_1012.dart';
import 'package:flutter_homepage/style/home_style_3001.dart';
import 'package:flutter_homepage/style/home_style_3002.dart';
import 'package:flutter_homepage/style/home_style_3004.dart';
import 'package:flutter_homepage/style/home_style_3005.dart';
import 'package:flutter_homepage/style/home_style_3006.dart';
import 'package:flutter_homepage/style/home_style_3007.dart';
import 'package:flutter_homepage/style/home_style_3008.dart';
import 'package:flutter_homepage/style/home_style_3009.dart';
import 'package:flutter_homepage/style/home_style_auth.dart';
import 'package:flutter_homepage/utils/home_utils.dart';
import '../style/home_style_1001.dart';
import '../style/home_style_1006.dart';
import '../style/home_style_1018.dart';
import '../style/home_style_1008.dart';
import '../style/home_style_1020.dart';
import '../style/home_style_1021.dart';
import '../style/home_style_1022.dart';
import '../style/home_style_1002.dart';
import '../style/home_style_10034.dart';
import '../style/home_style_3003.dart';
import '../model/app_group.dart';
import 'package:flutter_common/flutter_common.dart';
import '../widgets/home_header_back_widget.dart';
import '../widgets/home_header_navigationbar_norole_widget.dart';


/// 首页样式统一管理
class HomeStyleFactory {

  static Widget styleFactory({@required AppGroup group, HomeSettings homeSettings}){
    switch (group?.style) {
      case '1000':
        {
          return HomeStyleAuth();
        }
      case '1001':
        {
          return HomeStyle1001(appGroup: group); //九公格
        }
        break;
      case '1002':
        {
          return HomeStyle1002(appGroup: group);//生活缴费
        }
        break;
      case '1006':
        {
          return HomeStyle1006(appGroup: group);
        }
      case '1008':
        {
          return HomeStyle1008(appGroup: group); //公告
        }
        break;
      case '1012':
        {
          return HomeStyle1012(appGroup: group);//政务公开
        }
        break;
      case '1017':
        {
          return  _defaultStyleWidget(group: group);
        }
      case '1018':
        {
        return HomeStyle1018(appGroup: group);
//          return HomeStyle3007(appGroup: group,settings: homeSettings);
        }
        break;
      case '10034':
        {
          return HomeStyle10034(appGroup: group);
        }
        break;
      case '1011':
        {
          return  _defaultStyleWidget(group: group);
        }
        break;
      case '3001'://最新上线五公格banner
        {
          return HomeStyle3001(appGroup: group);
        }
        break;
      case '3002'://最新上线banner
        {
         return HomeStyle3002(appGroup: group);
        }
        break;
      case '3003'://快捷支付
        {
          return HomeStyle3003(appGroup: group);
        }
        break;
      case '3004'://专题服务
        {
          return HomeStyle3004(appGroup: group);
        }
        break;
      case '3005'://推荐服务
        {
          return HomeStyle3005(appGroup: group);
        }
        break;
      case '3006'://区县风景
        {
          return HomeStyle3006(appGroup: group);
        }
      case '3007'://头部banner 支持隐藏头部标题样式
        {
          return HomeStyle3007(appGroup: group,settings: homeSettings);
        }
        break;
      case '3008'://走进宁德
        {
          return HomeStyle3008(appGroup: group);
        }
        break;
      case '3009'://民俗活动
        {
          return HomeStyle3009(appGroup: group);
        }
        break;
      default:
        {
          return _defaultStyleWidget(group: group);
        }
    }
  }

  /// 导航栏

  static Widget navigationBar({String searchKey,List<HomeJuHe> headers,HomeSettings settings}){
    return HomeHeaderWithoutRolesNavigationBar(placeholder: searchKey,headers: headers, settings: settings);
  }

  /// 背景
  static Widget backGroundWidget({@required double margin, AppGroup group, HomeSettings homeSettings}) {
    if (margin > 0) {
      return HomeStyleFactory.styleFactory(group: group,homeSettings: homeSettings);
    }
    return HomeHeaderBackWidget(settings: homeSettings);
  }
  /// 总的高度
 static double totalHeight({@required List<AppGroup> appGroups, HomeSettings homeSettings}) {

   double totalHeight = ScreenUtil.getInstance().getRatio() * (homeSettings?.headerMargin ?? 0.0);

   for(int i= 0;i < appGroups.length ; i++){
     AppGroup group = appGroups[i];
     if (group?.style == '1000') {///认证
       totalHeight += HomeStyleAuth.hegiht();
     }
     if (group?.style == '1001') {///九公格
       totalHeight += HomeStyle1001.height();
     }
     if (group?.style == '1002') {///生活缴费
       totalHeight += 0;
     }
     if (group?.style == '1006') {
       totalHeight += 0;
     }
     if (group?.style == '1008') {///公告
       totalHeight +=  ScreenUtil.getInstance().getRatio() *  _getHeightByContentStyle(group.roll.contentStyle);
     }
     if (group?.style == '1012') {///政务公开
       totalHeight += HomeStyle1012.height(group);
     }
     if (group?.style == '10034') {
       totalHeight += 0;
     }
     if (group?.style == '1011') {
       totalHeight += 0;
     }
     if (group?.style == '3001') {///最新上线五公格banner
       totalHeight += HomeStyle3001.hegiht();
     }
     if (group?.style == '3002') {///最新上线banner
       totalHeight += HomeStyle3002.height();
     }
     if (group?.style == '3003') {///快捷支付
       totalHeight += HomeStyle3003.height();
     }
     if (group?.style == '3004') {///专题服务
       totalHeight += HomeStyle3004.height(group);
     }
     if (group?.style == '3005') {///推荐服务
       totalHeight += HomeStyle3005.height();
     }
     if (group?.style == '3006') {///区县风景
       totalHeight += HomeStyle3006.height(group);
     }
     if (group?.style == '3008') {///走进宁德
       totalHeight += HomeStyle3008.height(group);
     }
     if (group?.style == '3009') {///名族文化
       totalHeight += HomeStyle3009.height(group);
     }
   }
   return  totalHeight + Constant.statusBarHeight() + ScreenUtil.getInstance().getRatio() * 40;
  }

  static double _getHeightByContentStyle(int contentStyle) {
    if (contentStyle == 0) {
      return 75.0+10;
    } else if (contentStyle == 1) {
      return 64.0+10;
    } else {
      return 44.0+10;
    }
  }
  /// 透明
  static transparentWidget({@required double height}) {
        return Container(
          width: height,
          height: height,
          color: Colors.transparent,
          margin: EdgeInsets.only(top: 0),
        );

  }
  static Widget _defaultStyleWidget({@required AppGroup group}){
    return Container(
      height: 0,
      color: Colors.white,
    );
  }
}