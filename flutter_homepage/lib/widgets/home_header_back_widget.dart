
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:flutter_common/flutter_common.dart';
import 'package:flutter_common/utils/image_utils.dart';
import '../model/home_settings.dart';

class HomeHeaderBackWidget extends StatefulWidget {

  HomeSettings settings;


  HomeHeaderBackWidget({this.settings, Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeHeaderBackWidgetState();
}

class _HomeHeaderBackWidgetState extends State<HomeHeaderBackWidget> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 0,left: 0),
      child: _background(),
    );
  }

  /// 背景图片：区分：白天、夜晚
  String _headerBackgroundImage(){
    return 'images/home_headerback_night.png';
    //return _isNight() ? 'images/home_headerback_night.png' : 'images/home_headerback.png';
  }

  bool _isNight(){
    int hour = new DateTime.now().hour;
    if(hour >= 18 || hour <= 06){
      Log.d('夜晚');
      return true;
    }
    Log.d('白天');
    return false;
  }

  Widget _background(){
    if(this.widget.settings == null || this.widget.settings.imgUrl.isEmpty ){
      return Image.asset(
        _headerBackgroundImage(),
        package: 'flutter_homepage',
      );
    }
    return ToonImage.networkImage(url: this.widget?.settings?.imgUrl);
  }
}