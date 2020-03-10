import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_common/utils/image_utils.dart';
import 'package:flutter_homepage/model/app_group.dart';
import 'package:flutter_homepage/model/services_app.dart';
import 'package:flutter_common/flutter_common.dart';
import 'Home_section_style.dart';
import '../utils/VersionTransitionUtils.dart';

class HomeStyle3004 extends StatelessWidget{

  AppGroup appGroup;
  List<ServicesApp> appList;

  HomeStyle3004({this.appGroup, Key key}) : super(key: key) {
    this.appList = this.appGroup.appInfoList;
  }

  static double height(AppGroup group){
    return  HomeSectionStyle.height() + group?.appInfoList?.length * ScreenUtil.getInstance().getRatio() * 100 + 15.0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: <Widget>[
            HomeSectionStyle(this.appGroup),
            _cellItemContainer(context),
            Container(height: 15.0, color: Colors.transparent,),
          ],
        )
    );
  }
  _cellItemContainer(BuildContext context){
    return  Container(
      color: Colors.white,
      child: Column(
        children: _itemCell(context),
      ),
    );
  }
  //专题服务
  _itemCell(BuildContext context){
    List<Widget> items = [];
    appList.forEach((model) {
      items.add(_gridNavItemlsit(context,model));
    });
    return items;
  }
  _gridNavItemlsit(BuildContext context,ServicesApp model) {
    Color startColor = Color(int.parse('0xFFFBFBFB'));
    Color endColor = Color(int.parse('0xFFFBFBFB'));
    return Container(
      child: GestureDetector(
        onTap: () => _onClickedApp(model),
        child: Container(
          height: ScreenUtil.getInstance().getRatio() * 90,
          padding: (EdgeInsets.only(left: 0)),
          margin: EdgeInsets.only(top: ScreenUtil.getInstance().getRatio() * 10,right: ScreenUtil.getInstance().getRatio() *16,left: ScreenUtil.getInstance().getRatio() *16),
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [startColor, endColor]),
              borderRadius: BorderRadius.circular(4),
          ),
          child: Stack(
           alignment:Alignment.center,
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: ToonImage.networkImage(url:model.appPic,fit: BoxFit.fill,width: double.infinity,height: double.infinity),
                ),
              ),
              Positioned(
                  left: ScreenUtil.getInstance().getRatio() * 20,top: ScreenUtil.getInstance().getRatio() * 20,
                  child: ToonImage.networkImage(url: model.appIcon, width: ScreenUtil.getInstance().getRatio() *50.0, height: ScreenUtil.getInstance().getRatio() *50.0),
              ),
              Positioned(
                  left: ScreenUtil.getInstance().getRatio() * 86,top: ScreenUtil.getInstance().getRatio() *21,
                  child: Text(
                    model?.appTitle ?? "",
                    style: TextStyle(
                        fontSize: ScreenUtil.getInstance().getSp(18.0),
                        fontWeight: FontWeight.w500,
                        color:Colors.white,
                        decoration: TextDecoration.none),
                  )
              ),
              Positioned(
                left: ScreenUtil.getInstance().getRatio() * 86,top: ScreenUtil.getInstance().getRatio() * 50,
                child: Text(
                  model?.appSubTitle ?? "",
                  style: TextStyle(
                      fontSize: ScreenUtil.getInstance().getSp(12.0),
                      fontWeight: FontWeight.normal,
                      color:Colors.white,
                      decoration: TextDecoration.none),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
  _onClickedApp(ServicesApp app){
    VersionTransitionUtils.instance.appItemClick(app);
  }
}
