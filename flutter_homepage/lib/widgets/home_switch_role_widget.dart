import 'package:flutter/material.dart';
import 'package:flutter_boost/container/boost_container.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:flutter_common/flutter_common.dart';
import 'package:flutter_common/utils/notification_center.dart';
import 'package:flutter_homepage/utils/home_constant.dart';
import '../model/role.dart';
import '../utils/home_utils.dart';

/// =========================================
/// 角色切换视图
/// =========================================

class HomeSwitchRoleWidget extends StatelessWidget {

  HomeSwitchRoleWidget({Key key}) : super(key: key);

  Function(Role role) didSelectRoleCallBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: SizedBox(width: 300.0, height: 348.0,
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _dialogHeaderView(context),
                _dialogItemsWidget(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 头部视图：标题 + 关闭按钮
  Widget _dialogHeaderView(BuildContext context) {
    return SizedBox(
      height: 76.0,
      child: Stack(
        alignment: AlignmentDirectional.topStart,
        overflow: Overflow.clip,
        fit: StackFit.expand,
        children: <Widget>[
          Positioned(height: 76.0,
            child: Image.asset('images/home_switchrole_header_bg.png', package: 'flutter_homepage'),
          ),
          Positioned(height: 76.0, left: 15.0, right: 40.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('切换', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0, color: Colors.white, decoration: TextDecoration.none),maxLines: 2,textAlign: TextAlign.left,),
              ],
            ),
          ),
          Positioned(height: 76.0, right: 15.0, width: 40.0,
            child: GestureDetector(
              child: Padding(padding: EdgeInsets.only(left: 20.0),
                child: Image.asset('images/home_switchrole_close.png', package: 'flutter_homepage', width: 20.0, height: 20.0, alignment: Alignment.center,),
              ),
              onTap: () => _dismissDialog(context),
            ),
          ),
        ],
      ),
    );
  }

  /// 选择视图
  Widget _dialogItemsWidget(BuildContext buildContext) {
    return SizedBox(
      height: 272.0,
        child: Padding(
          padding: EdgeInsets.only(top: 42.0, bottom: 51.0),
          child: ListView.builder(
            itemCount: HomeUtils.instance.roles.length,
            itemBuilder: (BuildContext context, int position) {
              if(position < HomeUtils.instance.roles.length){
                Role role = HomeUtils.instance.roles[position];
                return _itemForRowAtPosition(buildContext ,role, position);
              }
              return Text('');
            },
            padding: EdgeInsets.only(top: 0.0),
          ),
        ),
    );
  }


  Widget _itemForRowAtPosition(BuildContext context ,Role role, int position){

    Color textColor = ColorUtils.kColorFF5E4B;
    Color backgrounColor = Colors.white;

    Role currentRole = HomeUtils.instance.currentRole;
    if(role?.role == currentRole?.role){
      textColor = Colors.white;
      backgrounColor = ColorUtils.kColorFF5E4B;
    }

    return SizedBox(
      height: 60.0,
      width: 170.0,
      child: Center(
        child: FlatButton(
          onPressed: (){
            NotificationCenter.instance.postNotification(HomeConstant.kHomeSwichRoleNotification, role);
            NotificationCenter.instance.postNotification(HomeConstant.kHeaderSwichRoleNotification, role);
            _dismissDialog(context);
          },
          color: backgrounColor,
          child: Container(
            width: 170.0,
            child: Text(role.title, style: TextStyle(fontSize: ScreenUtil.getInstance().getSp(14.0), color: textColor,), textAlign: TextAlign.center),
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(22.0)), side: BorderSide(color: ColorUtils.kColorFF5E4B, width: 1.0)),
        ),
      ),
    );
  }

  _dismissDialog(BuildContext context) {
   // FlutterPlugin.removeFlutterViewFromWindow();
    BoostContainerSettings settings = BoostContainer.of(context).settings;
    FlutterBoost.singleton.close(settings.uniqueId, result: {}, exts: {'alert':true});
  }
}