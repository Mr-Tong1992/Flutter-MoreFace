import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_common/flutter_common.dart';
import 'package:flutter_common/utils/notification_center.dart';
import 'package:flutter_homepage/model/services_app.dart';
import '../net/home_services.dart';
import '../model/app_group.dart';
import '../model/home_juhe.dart';
import '../model/region.dart';
import '../widgets/home_header_navigationbar_norole_widget.dart';
import '../widgets/home_header_navigationbar_switchrole_widget.dart';
import '../model/global_settings.dart';
import '../model/home_settings.dart';
import '../utils/home_utils.dart';
import '../utils/home_constant.dart';
import '../model/role.dart';
import '../widgets/home_style_factory.dart';

class THomeWidget extends StatefulWidget {
  @override
  _THomeWidgetState createState() => _THomeWidgetState();
}

class _THomeWidgetState extends State<THomeWidget> {
  GlobalKey<HomeHeaderWithoutRolesNavigationBarState> navigationKey =
      GlobalKey();
  GlobalKey<HomeHeaderSiwtchRoleNavigationBarState> switchRoleNavigationKey =
      GlobalKey();

  ScrollController _scrollController = new ScrollController();
  List<HomeJuHe> _headers = [];
  List<AppGroup> _appGroups = [];
  HomeSettings homeSettings;
  double offset = 0.0001;
  double navBarHeight = 64;
  double marginBottom = 0;
  double iPhoneXTop = 0;

  /// ====================================================
  /// Life Cycle
  /// ====================================================

  @override
  void initState() {
    super.initState();

    _differentiatedPlatform();

    setDesignWHD(375, 666.7);

    _getUserInformation(onCompletion: (userInfo) {
      //初始化计步器
      FlutterPlugin.initStepCounter();

      // 首先加载缓存数据
      _loadCachedHomeData();

      // 加载首页数据
      _handleRefresh();
    });
    _scrollController.addListener(_updateScrollPosition);

    // 角色切换通知
    NotificationCenter.instance
        .addObserver(HomeConstant.kHomeSwichRoleNotification, (object) {
      if (object != null && object is Role) {
        HomeUtils.instance.currentRole = object;
        _handleRefresh();
      }
    });
  }

  Future _handleRefresh() async {
    // 组织信息
    _localOrgnanization();

    // 获取天气等聚合信息
    _requestJuheInfo();

    // 获取全局设置
    _requestGlobalSettings();

//    ///记录用户的访问服务
//     Map<String, dynamic> params = new Map<String, dynamic>();
//        params['serviceCode'] = 1200;
//        params['toonTye'] =207;
//    HomeServices.requestAddVisitingRecord(
//        params:params,
//        onSuccess: (message) {
//        },
//        onError: (code, msg) {
//
//        });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(_updateScrollPosition);
  }

  @override
  void didUpdateWidget(THomeWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  //区分平台方法
  void _differentiatedPlatform() {
    if (Platform.isIOS) {
      //ios相关代码
      marginBottom = 0.0;
      // 下载换肤资源
      _downloadSkin();
    } else if (Platform.isAndroid) {
      //android相关代码
      marginBottom = ScreenUtil.getInstance().getRatio() * 50.0;
    }
  }

  @override
  Widget build(BuildContext context) {
//    if(Constant.isiPhoneX()){
//      iPhoneXTop = 40;
//    }
    double headerMargin = homeSettings?.headerMargin ?? 0.0;
    double listMargin = headerMargin;
    double topMargin = homeSettings == null
        ? Constant.navigationBarHeight()
        : homeSettings.headerMargin ?? Constant.navigationBarHeight();
    AppGroup backgroundGroup = _appGroups.length > 0 ? _appGroups.first : null;

    double totalHeight = HomeStyleFactory.totalHeight(
        appGroups: _appGroups, homeSettings: homeSettings);

    return RefreshIndicator(
      onRefresh: _handleRefresh,
      child: new Container(
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              controller: _scrollController,
              physics: BouncingScrollPhysics(),
              child: new Container(
                margin: EdgeInsets.only(
                    bottom: ScreenUtil.getInstance().getRatio() * marginBottom),
                child: Stack(
                  alignment: AlignmentDirectional.topStart,
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Container(
                      height: totalHeight,
                    ),
                    Container(
                      child: HomeStyleFactory.backGroundWidget(
                          margin: ScreenUtil.getInstance().getRatio() *  headerMargin,
                          group: backgroundGroup,
                          homeSettings: homeSettings),
                    ),
                    Positioned(
                      left: 0.0,
                      right: 0.0,
                      top: 0.0,
                      height: totalHeight,
                      child: Container(
                        margin: EdgeInsets.only(top: ScreenUtil.getInstance().getRatio() *  headerMargin),
                        child: _listView(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0.0,
              right: 0.0,
              top: 0.0,
              height: ScreenUtil.getInstance().getRatio() *
                  (Constant.navigationBarHeight() + _marginByOffset()),
              child: _getNavigationBarAccrodingToRoles(),
            ),
          ],
        ),
      ),
    );
  }

  // 根据是否有角色返回不同的导航栏
  Widget _getNavigationBarAccrodingToRoles() {
    if(HomeUtils.instance.roles != null && HomeUtils.instance.roles.length > 0){
      // 带角色的导航栏
      return HomeHeaderSiwtchRoleNavigationBar(
          placeholder: homeSettings?.searchContent,
          key: switchRoleNavigationKey,
          headers: _headers,
          settings: homeSettings,
      );
    }
    return HomeHeaderWithoutRolesNavigationBar(placeholder: homeSettings?.searchContent,key: navigationKey,headers: _headers,settings: homeSettings);
  }

  Widget _listView() {
    return Container(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: _getListCount(),
        itemBuilder: (BuildContext context, int position) {
          //保存1001样式appInfoList
          // _save1001AppInfoList(_appGroups[position]);

          if (position + 1 < _appGroups.length) {
            AppGroup group = _appGroups[position + 1];
            return HomeStyleFactory.styleFactory(
                group: group, homeSettings: homeSettings);
          }
          return Container(color: Colors.transparent, height: 0.0);

//          if (homeSettings == null) {
//            return HomeStyleFactory.transparentWidget();
//          } else if ((homeSettings?.headerMargin ?? 0) != 0) {
//            if (position == 0) {
//              //从第一个开始绘制
//              return HomeStyleFactory.transparentWidget(
//                  height: homeSettings?.headerMargin);
//            } else {
//              AppGroup group = _appGroups[position];
//              return HomeStyleFactory.styleFactory(
//                  group: group, homeSettings: homeSettings);
//            }
//          } else {
//            //homeSettings.headerMargin =0 直接绘制listview
//            AppGroup group = _appGroups[position];
//            return HomeStyleFactory.styleFactory(
//                group: group, homeSettings: homeSettings);
//          }
        },
      ),
    );
  }

  int _getListCount() {
    if (homeSettings != null) {
      if (homeSettings.headerMargin != null) {
        return _appGroups.length;
      } else {
        return _appGroups.length;
      }
    } else {
      return 0;
    }
  }

  /// 获取首页列表
  _requestHomeList() async {
    Map<String, dynamic> params = new Map<String, dynamic>();
    params['role'] = HomeUtils.instance.currentRole?.role ?? "";
    params['uphone'] = HomeUtils.instance?.mobile ?? "";
    params['region'] = '';

    HomeServices.requestHomeData(
      params: params,
      onSuccess: (appGroups, version, role, district) {
        for (int i = 0; i < appGroups.length; i++) {
          AppGroup group = appGroups[i];
          if (group.style == "1001") {
            //保存1001样式的应用数据 标示为判断
            if (SpUtil.getString("isUseLocal1001_" + HomeUtils.instance.userId)
                    .isEmpty ||
                SpUtil.getString(
                        "isUseLocal1001_" + HomeUtils.instance.userId) ==
                    "0") {
              HomeUtils.instance.appInfoLIst = group.appInfoList;
            }
            break;
          }
        }
        setState(() {
          _appGroups = appGroups;
        });
      },
      onError: (int code, String msg) {},
    );
  }

  /// 获取天气、是否限行等信息
  _requestJuheInfo() {
    /// 读取缓存,用于网络数据返回前的展示
    HomeJuHe model = SpUtil.getObj('kHomeWeather', (v) => HomeJuHe.fromJson(v));
    if (_headers.length > 0) {
      _headers.removeLast();
    }
    _headers.add(model);

    HomeServices.requestJuHeInfo(
        domain: HomeAPI.kHomeDomain,
        path: HomeAPI.kJuHeInfo,
        onSuccess: (juhe) {
          setState(() {
            SpUtil.putObject('kHomeWeather', juhe);
            if (_headers.length > 0) {
              _headers.removeLast();
            }
            _headers.add(juhe);
          });
        },
        onError: (code, msg) {});
  }

  /// 全局配置
  _requestGlobalSettings() {
    _getLocalAuthInfo();
    HomeServices.requestGlobalSettings(
        domain: HomeAPI.kHomeDomain,
        path: HomeAPI.kGlobalSettings,
        onSuccess: (settings) {
          _updateGlobalSettings(settings);
        },
        onError: (code, msg) {});
  }

  Future _getLocalAuthInfo() async {
    //从原生本地获取认证信息
    Map<String, dynamic> authInfo =
        new Map<String, dynamic>.from(await FlutterPlugin.getAuthUserInfo());
    SpUtil.putString("isCert", authInfo["isCert"].toString());
  }

  /// 首页配置
  _requestHomeSettings() {
    HomeServices.requestSettingInfo(
        domain: HomeAPI.kHomeDomain,
        path: HomeAPI.kSettingsInfo,
        onSuccess: (settings) {
          _updateHomeSettings(settings);
        },
        onError: (code, msg) {});
  }

  /// =====================================================
  /// 组织、角色
  /// =====================================================

  /// 当前账号组织信息
  _localOrgnanization() async {
    Map<dynamic, dynamic> infos = await FlutterPlugin.localOrganization();

    List<String> orgIds = new List();

    if (infos != null && infos.length > 0) {
      Map<String, dynamic> orgsInformation =
          new Map<String, dynamic>.from(infos);
      // 缓存用户组织信息
      HomeUtils.instance.taipOrgInfomation = orgsInformation;

      if (orgsInformation == null) {
        HomeUtils.instance.currentRole = null;
        return;
      }

      List<dynamic> orgs = orgsInformation[HomeConstant.kTAIPTypeOrg];
      orgs.forEach((info) {
        String oid = info["orgId"].toString();
        if (oid != null) {
          orgIds.add(oid);
        }
      });
    }

    if (orgIds.length == 0) {
      return;
    }

    // 获取角色
    Map<String, dynamic> params = {'orgIds': orgIds};
    _requestRoleList(params);
  }

  /// 角色列表
  _requestRoleList(Map<String, dynamic> orgIdsMap) {
    HomeServices.requestRolesList(
        params: orgIdsMap,
        onSuccess: (roles) {
          _rolesHandler(roles);
        },
        onError: (code, msg) {});
  }

  _rolesHandler(List<Role> roles) {
    /// 根据角色，重新加载数据
    _requestJuheInfo();
    _requestCards();
    _requestGlobalSettings();

    if (roles.length > 0) {
      // TODO 引导
    }
  }

  /// 区域列表
  _requestRegions() {
    HomeServices.requestRegionList(
        domain: HomeAPI.kHomeDomain,
        path: HomeAPI.kRegionList,
        onSuccess: (regions) {
          SpUtil.putObjectList('kHomeRegions', regions);

          String currentDistruct = SpUtil.getString('kHomeCurrentDistruct');
          bool isHave = false;
          for (Region item in regions) {
            if (item.district == currentDistruct) {
              isHave = true;
              break;
            }
          }

          if (!isHave && currentDistruct.length > 0) {
            SpUtil.putString('kHomeCurrentRegion', null);
            _requestHomeList();
          }
        },
        onError: (code, msg) {});
  }

  _updateGlobalSettings(GlobalSettings settings) {
    if (settings != null) {
      int dimension = settings.dimension;

      // 如果是配置的地区，就更新地区信息
      if (dimension == 0) {
        SpUtil.putString('kHomeCurrentRole', '');
        SpUtil.putObject('kHomeCurrentRegion', null);
      } else if (dimension == 1) {
        SpUtil.putString('kHomeCurrentRole', '');
        _requestRegions();
      } else if (dimension == 2) {
        SpUtil.putObject('kHomeCurrentRegion', null);
      }
      SpUtil.putInt('kHomeDimension', settings.dimension);
    }

    _requestHomeSettings();
  }

  _updateHomeSettings(HomeSettings settings) {
    // 保存配置信息以供断网情况使用
    SpUtil.putObject('kHomeSettings', settings);

    // 天气、背景
    _configWeatherAnimation(settings);

    // 卡证入口
    _configCards(settings.cardUrl.length > 0);

    setState(() {});

    // 首页数据
    _requestHomeList();
  }

  /// 获取用户信息
  _getUserInformation<T>(
      {Function(Map<String, dynamic> userInfo) onCompletion}) async {
    Map<String, dynamic> userInfo =
        new Map<String, dynamic>.from(await FlutterPlugin.userInformation());
    HomeUtils.instance.userInfo = userInfo;
    if (onCompletion != null) {
      onCompletion(userInfo);
    }
  }

  /// 天气和背景
  _configWeatherAnimation(HomeSettings settings) {
    // 如果和上次配置一样则不刷新视图
    bool isEqual = homeSettings?.isSettingsEqual(settings) ?? false;
    homeSettings = settings;

    if (!isEqual) {}
  }

  /// 下载换肤资源
  _downloadSkin() async {
    FlutterPlugin.downloadSkin();

    // 原生事件监听
    _nativeEventListenerHander();
  }

  /// 原生调用Flutter事件监听
  _nativeEventListenerHander() {
    FlutterPlugin.setHomePageListener(
        // 换肤
        changeSkinHandler: (Map<String, dynamic> map) async {});
  }

  /// =====================================================
  /// 卡证
  /// =====================================================

  /// 卡证入口
  _configCards(bool isHide) {}

  /// 所有卡证信息
  _requestCards() {}

  /// 加载缓存数据
  _loadCachedHomeData() {
    Map<String, dynamic> cachedHomeMap = HomeUtils.instance.homepageCachedMap;
    Map<String, dynamic> homeSetting = HomeUtils.instance.homeSettings;
    if (cachedHomeMap == null || homeSetting == null) {
      return null;
    }
    int version = cachedHomeMap['version'];
    String district = cachedHomeMap['district'];
    String role = cachedHomeMap['role'];

    List list = new List<Map<String, dynamic>>.from(cachedHomeMap["appGroups"]);

    List<AppGroup> appGroups = new List<AppGroup>();

    for (var i = 0; i < list.length; i++) {
      Map<String, dynamic> groupJson = new Map<String, dynamic>.from(list[i]);
      AppGroup appGroup = new AppGroup.fromJson(groupJson);
      appGroups.add(appGroup);
    }
    this.homeSettings = HomeSettings.fromJson(homeSetting);
    this._appGroups = appGroups;
    setState(() {});
  }

  _updateScrollPosition() {
    offset = _scrollController.position.pixels;
    FlutterPlugin.scrollOffset(offset);
    var state;
    if(HomeUtils.instance.roles != null && HomeUtils.instance.roles.length > 0){
      state = switchRoleNavigationKey.currentState;

    }else{
      state = navigationKey.currentState;
    }
    state.updateNavigationBarByOffset(offset);
    setState(() {});
  }

  double _marginByOffset() {
    double margin = 27;
    if (offset <= 27.0) {
      margin = 27;
    } else if (offset > 27.0 && offset <= 57.0) {
      margin = 27 - (offset - 27) / 2;
    } else {
      margin = 27 / 2;
    }
    return margin;
  }
}
