import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_common/flutter_common.dart';
import '../services/home_category_navigation.dart';

class HomeCategoryServicesWidget extends StatefulWidget {

  @override
  _HomeCategoryServicesWidgetState createState() => _HomeCategoryServicesWidgetState();
}

class _HomeCategoryServicesWidgetState extends State<HomeCategoryServicesWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.yellow,
      child: Column(
        children: <Widget>[
          // 导航栏
          HomeCategoryNavigationWidget(),

        ],
      ),
    );
  }
}