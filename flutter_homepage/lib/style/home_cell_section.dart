import 'package:flutter/material.dart';
import 'package:flutter_common/flutter_common.dart';

class HomeCellSection extends StatelessWidget {

  String title;
  HomeCellSection({this.title, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.0, right: 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 5.0, top: 3.0),
                child: Container(
                  color: Color(0xffdf3031),
                  width: 3.0,
                  height: 15.0,
                ),
              ),
            ],
          ),

          Text(
            title,
            style: TextStyle(fontSize: 15.0,
                decoration: TextDecoration.none,
                color: ColorUtils.kColor222222),
          ),
        ],
      ),
    );
  }
}