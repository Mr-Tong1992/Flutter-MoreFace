import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_common/utils/color_utils.dart';
import 'package:flutter_common/utils/image_utils.dart';
import 'package:flutter_homepage/model/app_group.dart';
import 'package:flutter_homepage/model/services_app.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_common/flutter_common.dart';
import '../utils/VersionTransitionUtils.dart';

///最新上线
class HomeStyle3002 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomeStyle3002State();
  }

  AppGroup appGroup;
  List<ServicesApp> appList;

  HomeStyle3002({this.appGroup, Key key}) : super(key: key) {
    this.appList = this.appGroup.appInfoList;
  }

  static double height() {
    return ScreenUtil.getInstance().getRatio() * 90;
  }
}

class _HomeStyle3002State extends State<HomeStyle3002>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.white, child: _itemCell);
  }

  Widget get _itemCell {
    return Container(
      height: ScreenUtil.getInstance().getRatio() *  90,
      padding: EdgeInsets.only(bottom: 10),
      child: new Swiper(
          fade: 0.94,
          viewportFraction: 0.90,
          scale: 0.94,
          autoplayDelay: 6000,
          itemBuilder: (c, i) {
            ServicesApp app = this.widget.appList[i];
            return Container(
              child: GestureDetector(
                onTap: () => _onClickedApp(app),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: ToonImage.networkImage(
                      url: app?.appPic,
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: double.infinity),
                ),
              ),
            );
          },
          pagination: new SwiperPagination(
              margin: EdgeInsets.all(5.0),
              alignment: Alignment.bottomCenter,
              builder: DotSwiperPaginationBuilder(
                size: this.widget.appList.length > 1 ? 6 : 0,
                activeSize: this.widget.appList.length > 1 ? 6 : 0,
                color: Color.fromRGBO(255, 255, 255, 0.5),
                activeColor: ColorUtils.kColorFFFFFF,
              )),
          autoplay: _isAutoPlay(),
          autoplayDisableOnInteraction: _isAutoPlay(),
          physics: _getScrollPhysics(),
          itemCount: this.widget.appList?.length),
    );
  }

  bool _isAutoPlay() {
    return this.widget.appList.length > 1 ? true : false;
  }

  ScrollPhysics _getScrollPhysics() {
    if (_isAutoPlay() == true) {
      return BouncingScrollPhysics();
    }
    return NeverScrollableScrollPhysics();
  }

  _onClickedApp(ServicesApp app) {
    VersionTransitionUtils.instance.appItemClick(app);
  }
}
