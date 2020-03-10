import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_common/flutter_common.dart';


class HomeHeaderNoAuth extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _HomeHeaderNoAuthState();
  }

}

class _HomeHeaderNoAuthState extends State<HomeHeaderNoAuth> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.0, right: 15.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.3),
              offset: new Offset(0, 0),
              blurRadius: 5.0,
            ),
          ],
        ),
        child: Container(
          height: 138.0,
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left:24.0),
                    child: SizedBox(
                      width: 114,
                      height: 109,
                      child: Image.asset( 'images/home_header_noauth.png', package: 'flutter_homepage', ),
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 19.0, top: 21.0, bottom: 9.0),
                    child: SizedBox(
                      height: 50.0,
                      child: Text(
                        '开启实名认证\n安全享受便捷服务',
                        style: TextStyle(color: Color(0xff553859), fontSize: 18.0, decoration: TextDecoration.none),
                        maxLines: 2,
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: Padding(
                      padding: EdgeInsets.only(left: 19.0),
                      child: SizedBox(
                        width: 158.0,
                        height: 32.0,
                        child: Image.asset('images/home_header_doauth.png', package: 'flutter_homepage',),
                      ),
                    ),
                    onTap: () => _doAuth(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  /// 实名认证
  _doAuth() async {
    FlutterPlugin.doAuthoritation();
  }
}