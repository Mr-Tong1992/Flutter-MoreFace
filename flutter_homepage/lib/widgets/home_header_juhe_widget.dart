import 'package:flutter/material.dart';
import 'package:flutter_common/utils/image_utils.dart';
import '../model/home_juhe.dart';
import 'package:flutter_common/flutter_common.dart';

/// 天气等信息的聚合视图

class HomeHeaderJuHe extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeHeaderJuHeState();
  }

  HomeHeaderJuHe({this.juheModel, Key key}) : super(key: key) {

  }

  HomeJuHe juheModel;
}

class _HomeHeaderJuHeState extends State<HomeHeaderJuHe> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: _getHeight()),
      child: Container(
        height: 58.0,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(widget.juheModel.temperature, style: TextStyle(fontSize: 28.0, color: Colors.white, decoration: TextDecoration.none)),
                Padding(
                  padding: EdgeInsets.only(left: Constant.isiPhone5() ? 0.0 : 2.0),
                  child: SizedBox(
                    width: 14.0, height: 14.0,
                    child: ToonImage.networkImage(url: widget.juheModel?.weatherIcon),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 6.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(widget.juheModel.weather, style: TextStyle(fontSize: 13.0, color: Colors.white, decoration: TextDecoration.none),),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text(_getlimitCar(), style: TextStyle(fontSize: 12.0, color: Colors.white, decoration: TextDecoration.none)),
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(_getAirQuality(), style: TextStyle(fontSize: 12.0, color: Colors.white, decoration: TextDecoration.none)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  double _getHeight() {
    return Constant.isiPhoneX() ? (14.0 + 88.0) : (14.0 + 64.0);
  }

  String _getlimitCar(){

    if(widget.juheModel?.isCarLimit == 1){
      // 限行
      String carLimitNumber = widget.juheModel.carLimitNumbers;
      if(carLimitNumber == null){
        return '';
      }
      return carLimitNumber.isNotEmpty ? '限行 ${carLimitNumber}' : '';
    }else{
      return '不限行';
    }
  }

  String _getAirQuality(){
    String aqi = widget.juheModel.AQI;
    String quality = widget.juheModel.quality;
    if(aqi == null){
      aqi = '';
    }
    if(quality == null){
      quality = '';
    }
    return '空气质量 ${aqi}  ${quality}';
  }
}