import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_common/utils/image_utils.dart';
import 'package:flutter_homepage/utils/VersionTransitionUtils.dart';
import '../model/services_app.dart';
import 'package:flutter_common/flutter_common.dart';


class HomeCellStyle2 extends StatefulWidget {

  ServicesApp app;
  TBorders borders;

  HomeCellStyle2({this.app, this.borders, Key key}) : super(key: key);

  @override
  _HomeCellStyle2State createState() => _HomeCellStyle2State();
}

class _HomeCellStyle2State extends State<HomeCellStyle2> {

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: _displayBorders(),
      ),
      child: GestureDetector(
        onTap: () => _onClickApp(this.widget.app),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      this.widget.app.appTitle,
                      style: TextStyle(fontSize: 15.0,
                          color: ColorUtils.kColor222222,
                          decoration: TextDecoration.none),
                      maxLines: 1,
                    ),
                    Text(
                      this.widget.app.appSubTitle,
                      style: TextStyle(fontSize: 12.0,
                          color: ColorUtils.kColor8E8E93,
                          decoration: TextDecoration.none),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(),
              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DecoratedBox(
                    decoration: BoxDecoration(color: Colors.white),
                    child: ToonImage.networkImage(url: this.widget.app?.appPic, width: 90.0, height: 60.0),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Border _displayBorders() {
    TBorders borders = this.widget.borders;
    if(borders == null){
      return Border();
    }
    return Border(
      left: _getBorderSide(borders.left),
      right: _getBorderSide(borders.right),
      top: _getBorderSide(borders.top),
      bottom: _getBorderSide(borders.bottom),
    );
  }

  BorderSide _getBorderSide(bool isDisplay) {
    if(isDisplay == true) {
      return BorderSide(width: 0.5,
          style: BorderStyle.solid,
          color: ColorUtils.kColorf8f8fb);
    }
    return BorderSide.none;
  }

  void _onClickApp(ServicesApp app) async {
    VersionTransitionUtils.instance.appItemClick(app);
  }
}