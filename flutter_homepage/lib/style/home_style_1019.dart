//
//import 'package:flutter/material.dart';
//import 'package:flutter_common/utils/color_utils.dart';
//import 'package:flutter_common/utils/font_utils.dart';
//import 'package:flutter_homepage/model/app_group.dart';
//import 'package:flutter_homepage/model/services_app.dart';
//import 'package:flutter_swiper/flutter_swiper.dart';
//
//import 'Home_section_style.dart';
//
//class HomeStyle1019 extends StatefulWidget{
//  @override
//
//  _HomeStyle1019State createState() => _HomeStyle1019State();
//  AppGroup appGroup;
//  List<ServicesApp> appList;
//  HomeStyle1019({this.appGroup, Key key}) : super(key: key) {
//    this.appList = this.appGroup.appInfoList;
//  }
//}
//
//class _HomeStyle1019State extends State <HomeStyle1019>{
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      color: Colors.white,
//      child: Column(
//        children: <Widget>[
//          HomeSectionStyle("快捷支付","更多"),
//          _cellItemContainer(context)
//        ],
//      )
//    );
//  }
//   _cellItemContainer(BuildContext context) {
//    return Container(
//      height: 200,
//      margin: EdgeInsets.only(left: 16,right: 16),
//      decoration: BoxDecoration(
//        color: Colors.white,
////        borderRadius: BorderRadius.all(
////            Radius.circular(6)
////        ),
//      ),
////      child: Padding(
//        child:_cellItem(context),
////      ),
//    );
//  }
//  _cellItem(BuildContext context){
//    return new SizedBox(
//      child: new Swiper(
//        itemCount: 6,
//        outer: true,
//        itemBuilder: (BuildContext context, int index) {
//          return _gridNavItem(context,false);
//        },
//        pagination:
//        new SwiperPagination(
//            margin:  EdgeInsets.all(5.0),
//            alignment: Alignment.bottomCenter,
//            builder: DotSwiperPaginationBuilder(
//              size: 6,
//              activeSize: 6,
//              color:ColorUtils.kColore7e4e5,
//              activeColor: ColorUtils.kColorf75348,
//            )),
//      ),
//    );
//  }
//  //private
//
//  _gridNavItem(BuildContext context, bool first) {
//    List<Widget> items = [];
//    items.add(_mainItem(context));
//    items.add(_doubleItem(context));
//    List<Widget> expandItems = [];
//    items.forEach((item) {
//      expandItems.add(Expanded(child: item, flex: 1));
//    });
//    Color startColor = Color(int.parse('0xFFFBFBFB'));
//    Color endColor = Color(int.parse('0xFFFBFBFB'));
//    return Container(
//      height: 200,
//      decoration: BoxDecoration(
//        //线性渐变
//          gradient: LinearGradient(colors: [startColor, endColor])),
//      child: Row(children: expandItems),
//    );
//  }
//  _mainItem(BuildContext context) {
//    return GestureDetector(
//            child: Stack(
//              children: <Widget>[
//
//                Positioned(
//                    right: 0.0,
//                    bottom: 0.0,
//                    height: 122.0,
//               child:Image.asset(
//                'images/home_cityPose.png',
//                package: 'flutter_homepage',
//                )),
//                Positioned(
//                  top: 16.0,
//                  left: 8,
//                  child: Container(
//                    child:
//                    Text('停车缴费', style: TextStyle(fontSize: 12, color: ColorUtils.kColor9C9C9C,fontWeight: FontWeight.normal, decoration: TextDecoration.none),
//                    ),
//                  ),
//                ),
//                Positioned(
//                  top: 38.0,
//                  left: 8,
//                  child: Container(
//                    child: Text(
//                      '教育缴费',
//                      style: TextStyle(fontSize: 14, color: ColorUtils.kColor5B5B5B,fontFamily: FontUtils.fontFamily(), decoration: TextDecoration.none),
//                    ),
//                  ),
//                ),
//              ],
//            ),
//    );
//  }
//  _doubleItem(BuildContext context) {
//    return Column(
//      children: <Widget>[
//        Expanded(
//          child: _item(context, true),
//        ),
//        Expanded(
//          child: _item(context, false),
//        )
//      ],
//    );
//  }
//  _item(BuildContext context, bool first ) {
//    BorderSide borderSide = BorderSide(width: 4, color: Colors.white);
//    return FractionallySizedBox(
//      //撑满父布局的宽度
//      widthFactor: 1,
//      child: Container(
//        decoration: BoxDecoration(
//            border: Border(
//              left: borderSide,
//              bottom: first ? borderSide : BorderSide.none,
//            )
//        ),
//        child: Stack(
//          children: <Widget>[
//        Positioned(
//          right: 0.0,
//          bottom: 0.0,
//          height: 60.0,
//          child:  Image.asset(
//             'images/home_cityPose.png',
//             package: 'flutter_homepage',
//             fit: BoxFit.scaleDown,
//           ),
//         ),
//            Positioned(
//              top: 16.0,
//              left: 8,
//              child: Container(
//                child: Text(
//                  '教育缴费',
//                  style: TextStyle(fontSize: 14, color: ColorUtils.kColor5B5B5B,fontFamily: FontUtils.fontFamily(), decoration: TextDecoration.none),
//                ),
//              ),
//            ),
//            Positioned(
//              top: 38.0,
//              left: 8,
//              child: Container(
//                child: Text(
//                  '学费支付',
//                  style: TextStyle(fontSize: 12, color: ColorUtils.kColor9C9C9C,fontWeight: FontWeight.normal, decoration: TextDecoration.none),
//                ),
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}