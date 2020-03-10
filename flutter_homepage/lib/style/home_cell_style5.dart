import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_common/utils/image_utils.dart';
import 'package:flutter_homepage/utils/VersionTransitionUtils.dart';
import '../model/services_app.dart';
import 'package:flutter_common/flutter_common.dart';

class HomeCellStyle5 extends StatefulWidget {
  ServicesApp app;
  HomeCellStyle5({this.app, Key key}) : super(key: key);

  @override
  _HomeCellStyle5State createState() => _HomeCellStyle5State();
}

class _HomeCellStyle5State extends State<HomeCellStyle5> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () => _onClickApp(this.widget.app),
        child: Stack(
          alignment: AlignmentDirectional.topStart,
          overflow: Overflow.clip,
          fit: StackFit.expand,
          children: <Widget>[
            Positioned( left: 0.0, right: 0.0, top: 25.0,
              height: 50.0,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      this.widget.app.appTitle,
                      style: TextStyle(fontSize: FontUtils.font15(), color: ColorUtils.kColor222222, decoration: TextDecoration.none),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 6.0),
                      child: Text(
                        this.widget.app.appSubTitle,
                        style: TextStyle(fontSize: FontUtils.font12(), color: ColorUtils.kColor8E8E93, decoration: TextDecoration.none),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned( right: 10.0, bottom: 10.0,
              height: 96.0,
              child: ToonImage.networkImage(url: this.widget.app?.appPic),
            ),
          ],
        ),
      ),
    );
  }

  void _onClickApp(ServicesApp app) async {
    VersionTransitionUtils.instance.appItemClick(app);
  }
}