import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:flutter_common/flutter_common.dart';

class HomeCategoryNavigationWidget extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      height: Constant.navigationBarHeight(),
      color: ColorUtils.kColorF9F9F9,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // 返回
          _leftButton(context),
        ],
      ),
    );
  }

  Widget _leftButton(BuildContext context) {
    return Container(
        height: Constant.navigationBarHeight(),
        width: 80.0,
        child: GestureDetector(
            onTap: (){
              BoostContainerSettings settings =
                  BoostContainer.of(context).settings;
              FlutterBoost.singleton.close(settings.uniqueId);
            },
            child: Padding(
                padding: EdgeInsets.only(left: 10.0, top: 20.0),
                child: SizedBox(
                  width: 16.5,
                  height: 30.0,
                  child: Image.asset('images/home_navigationbar_back.png', package: 'flutter_homepage'),
                )
            )
        ),
    );
  }

  Widget _rightButton() {
    return Container(
      child: FlatButton(
        onPressed: _rightButtonOnClick,
        child: Text('管理', style: TextStyle(fontSize: FontUtils.font17(), fontWeight: FontWeight.normal),),


      ),
    );
  }

  _rightButtonOnClick() {

  }
}