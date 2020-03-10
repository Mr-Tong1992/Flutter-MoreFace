import 'package:flutter/material.dart';
import 'package:flutter_common/flutter_common.dart';
import 'package:flutter_common/utils/color_utils.dart';
import 'package:flutter_homepage/model/app_group.dart';
import 'package:flutter_homepage/model/services_app.dart';
import 'package:flutter_homepage/utils/home_utils.dart';
import '../utils/VersionTransitionUtils.dart';

class HomeSectionStyle extends StatelessWidget{

  AppGroup group;
  HomeSectionStyle(this.group);

  static double height(){
    return ScreenUtil.getInstance().getRatio() * 48.0;
  }

  @override
  Widget build(BuildContext context) {

    if(this.group.title != null && this.group.title != ''){
      return _sectionHeaderWidget();
    }
    return Container();
  }

  Widget _sectionHeaderWidget(){

    String moreTitle = (this.group?.remark != null) && (this.group?.remark != "") ? this.group.remark : '';

    return Container(
      color: Colors.white,
      height: ScreenUtil.getInstance().getRatio() * 48,
      padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                this.group?.title ?? "",
                style: TextStyle(
                    fontSize: ScreenUtil.getInstance().getSp(18.0),
                    fontWeight: FontWeight.w600,
                    color:ColorUtils.kColor222222,
                    decoration: TextDecoration.none),
              ),
            ],
          ),
          Offstage(
            child: GestureDetector(
              onTap: () => _onClickedMoreButton(this.group),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    moreTitle,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: ScreenUtil.getInstance().getSp(12.0),
                        color: ColorUtils.kColor9C9C9C
                        ,decoration: TextDecoration.none
                    ),
                  ),
                ],
              ),
            ),
            offstage: false,
          ),
        ],
      ),
    );
  }
  _onClickedMoreButton(AppGroup group){
    String moreTitle = (this.group?.remark != null) && (this.group?.remark != "") ? this.group.remark : '';
    if(moreTitle == null || moreTitle == ''){ return; }
    // 组织应用
    if(group.isOrg == 1) { return; }

    Map<String, dynamic> params = new Map<String, dynamic>();
    params['appId'] = group?.appGroupId ?? '';  // 原生此处用的是linkUrl
    params['isOrg'] = group?.isOrg ?? '';
    params['orgAppCategory'] = group?.orgAppCategory ?? '';
    params['SPKey'] = '1001appinfoLIst_'+HomeUtils.instance.userId;
    params['hadRole'] = HomeUtils.instance.currentRole == null ? 0 : 1;
    FlutterPlugin.allApps(params);
  }
}


