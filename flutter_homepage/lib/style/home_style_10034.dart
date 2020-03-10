import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_common/flutter_common.dart';
import '../model/app_group.dart';
import '../model/services_app.dart';
import '../style/home_cell_style2.dart';
import '../style/home_cell_style5.dart';
import '../style/home_cell_section.dart';
import '../style/home_cell_footer.dart';

class HomeStyle10034 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeStyle10034State();
  }

  AppGroup appGroup;
  List<ServicesApp> appList;

  HomeStyle10034({this.appGroup, Key key}) : super(key: key) {
    this.appList = this.appGroup.appInfoList;
  }
}

class _HomeStyle10034State extends State<HomeStyle10034> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

    // 视图总高度 = title高度 + 内容高度 + footer高度
    double contentHeight = this.widget.appList.length > 0 ? 168.0 : 0;  //内容高度
    double footerHeight = 10.0; //footer高度
    double titleHeight = 47.0;  //title高度

    // 根据标题内容是否存在，决定是否显示标题
    String title = this.widget.appGroup.title;
    if (title == null || title.isEmpty) {
      titleHeight = 0.0;
    }

    return Container(
      color: Colors.black26,
      height: (titleHeight + contentHeight + footerHeight),
      child: Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            //标题
            HomeCellSection(title: this.widget.appGroup.title),
            //内容
            _widgetForContent(contentHeight),
            //Footer
            HomeCellFooter(),
          ],
        ),
      ),
    );
  }

  /// 内容
  Widget _widgetForContent(double height) {
    return Container(
      height: height,
      child: Padding(padding: EdgeInsets.only(left: 15.0, right: 15.0),
        child: GridView.builder(
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, //每行两列
            ),
            itemCount: 2,
            itemBuilder: (context, index) {
              if(index == 0){
                // 左侧视图
                ServicesApp app = this.widget.appList[index];
                return HomeCellStyle5(app: app);
              }else{
                // 右侧视图
                List<ServicesApp> apps = this.widget.appList.sublist(1);
                return _cellForRightWidget(apps);
              }
            }),
      ),
    );
  }

  // 内容：右侧视图
  Widget _cellForRightWidget(List<ServicesApp> apps) {

    Size size = MediaQuery
        .of(context)
        .size;
    double ratio = size.width / 2.0 / 84.0;

    return Container(
      child: GridView.builder(
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: ratio,
          ),
          itemCount: apps.length,
          itemBuilder: (context, index) {
            ServicesApp app = apps[index];
            TBorders borders = _getBordersWithIndex(index);
            return HomeCellStyle2(app: app, borders: borders);
          }),
    );
  }

  TBorders _getBordersWithIndex(int index){
    if(index == 0){
      return TBorders.only(left: true, bottom: true);
    }
    return TBorders.only(left: true, top: true);
  }
}
