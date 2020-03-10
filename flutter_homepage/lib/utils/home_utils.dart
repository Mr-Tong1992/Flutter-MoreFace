import 'dart:convert';
import 'package:flutter_common/flutter_common.dart';
import 'package:flutter_homepage/model/home_settings.dart';
import 'package:flutter_homepage/model/services_app.dart';
import '../model/home_juhe.dart';
import '../model/region.dart';
import '../model/role.dart';

class HomeUtils {
  /// 用户信息
  Map<String, dynamic> _userInfo;

  /// 用户ID
  String _userId;

  /// 手机号
  String _mobile;

  /// userToken
  String _userToken;

  /// personToken
  String _personToken;

  /// 城市编码
  String _countryCode;

  /// 天气等信息
  HomeJuHe _juhe;

  ///首页配置缓存
  Map<String, dynamic> _homeSettings;

  /// 服务切换纬度
  int _dimension;

  /// 当前地区编码
  Region _currentRegion;

  /// 当前角色
  Role _currentRole;

  /// 角色列表
  List<Role> roles;

  /// 首页接口数据缓存
  Map<String, dynamic> _homepageCachedMap;

  Map<String, dynamic> get userInfo => _userInfo;

  //1001样式 appInfoLIst
  List<dynamic> _appInfoLIst;

  /// 用户组织信息
  Map<String, dynamic> _taipOrgInfomation;

  set appInfoLIst(List<ServicesApp> _appinfoLIst) {
    String jsonStr = json.encode(_appinfoLIst);
    SpUtil.putString(_keyWithUserId('1001appinfoLIst'), jsonStr);
    SpUtil.reload();
    _appInfoLIst = _appinfoLIst;
  }

  set userInfo(Map<String, dynamic> info) => _userInfo = info;

  String get userId {
    if (_userInfo != null) {
      _userId = _userInfo['userId'];
    }
    return _userId;
  }

  String get mobile {
    if (_userInfo != null) {
      _mobile = _userInfo['phoneNum'];
    }
    return _mobile;
  }

  String get userToken {
    if (_userInfo != null) {
      _userToken = _userInfo['userToken'];
    }
    return _userToken;
  }

  String get countryCode {
    if (_userInfo != null) {
      _countryCode = _userInfo['countryCode'];
    }
    return _countryCode;
  }

  String get personToken {
    if (_userInfo != null) {
      _personToken = _userInfo['personToken'];
    }
    return _personToken;
  }

  int get dimension {
    if (_dimension == null) {
      _loadSharedDimension();
    }
    return _dimension;
  }

  set dimension(int dms) {
    SpUtil.putInt(_keyWithUserId('home_dimension'), dms);
    _dimension = dms;
  }

  void _loadSharedDimension() {
    int dms = SpUtil.getInt(_keyWithUserId('home_dimension'));
    _dimension = dms;
  }

  HomeJuHe get weather {
    if (_juhe == null) {
      loadSharedWeather();
    }
    return _juhe;
  }

  set weather(HomeJuHe model) {
    Map<String, dynamic> juheMap = model.toJson();
    String jsonStr = json.encode(juheMap);
    SpUtil.putString(_keyWithUserId('home_weather'), jsonStr);

    _juhe = model;
  }

  void loadSharedWeather() {
    String jsonStr = SpUtil.getString(_keyWithUserId('home_weather'));
    Map<String, dynamic> juheMap = json.decode(jsonStr);
    _juhe = HomeJuHe.fromJson(juheMap);
  }

  /// ===============================================
  /// 当前角色
  /// ===============================================
  Role get currentRole {
    if (_currentRole == null) {
      _loadCurrentRole();
    }
    return _currentRole;
  }

  set currentRole(Role role) {
    SpUtil.putObject(_keyWithUserId('currentRole'), role);
    _currentRole = role;
    SpUtil.reload();
  }

  void _loadCurrentRole() {
    Role role = SpUtil.getObj(
        _keyWithUserId('currentRole'), (srcJson) => Role.fromJson(srcJson));
    _currentRole = role;
  }

  /// ===============================================
  /// 当前用户组织信息
  /// ===============================================

  set taipOrgInfomation(Map<String, dynamic> jsonMap) {
    String jsonStr = json.encode(jsonMap);
    SpUtil.putString(_keyWithUserId('taipOrgInfomation'), jsonStr);
    SpUtil.reload();
    _taipOrgInfomation = jsonMap;
  }

  Map<String, dynamic> get taipOrgInfomation {
    if(_taipOrgInfomation == null){
      String jsonStr = SpUtil.getString(_keyWithUserId('taipOrgInfomation'));
      if(jsonStr.isEmpty){ return null; }
      Map<String, dynamic> jsonMap = json.decode(jsonStr);
      _taipOrgInfomation = new Map<String, dynamic>.from(jsonMap);
    }
    return _taipOrgInfomation;
  }

  /// 组织
  List<Map<String, dynamic>> getTaipOrganizations() {
    List orgs = HomeUtils.instance.taipOrgInfomation['torg'];
    List<Map<String, dynamic>> organizations = new List();
    orgs.forEach((orgMap){
      Map<String, dynamic> map = new Map<String, dynamic>.from(orgMap);
      organizations.add(map);
    });
    return organizations;

  }

  /// 组织应用
  List<ServicesApp> getTaipOrgApps() {
    List appsMap = HomeUtils.instance.taipOrgInfomation['tapp'];
    List<ServicesApp> apps = new List();
    appsMap.forEach((map){
      String orgId = map["orgId"].toString();
      String currentOrgId = HomeUtils.instance.currentRole?.role;

      if(orgId == currentOrgId){
        List preLoadApps = map["preLoadApps"];
        Map<String, dynamic> app = new Map();
        preLoadApps.forEach((preLoadAppMap){
          String appTitle = preLoadAppMap["name"];
          String appIcon = preLoadAppMap["icon"];
          String appSubTitle = preLoadAppMap["desc"];
          String appId = preLoadAppMap["appId"].toString();
          String sort = preLoadAppMap["sort"].toString();
          String appCategory = preLoadAppMap["appCategory"];
          String appUrl = preLoadAppMap["appUrl"];

          ServicesApp app = new ServicesApp();
          app.appTitle = appTitle;
          app.appSubTitle = appSubTitle;
          app.appIcon = appIcon;
          app.appPic = appIcon;
          app.appId = int.parse(appId);
          app.id = int.parse(appId);
          app.isOrg = 1;
          app.sort = sort;
          app.appCategory = appCategory;
          app.appUrl = appUrl;
          app.isAuthentication = 1;

          apps.add(app);
        });
      }
    });
    return apps;
  }

  /// ===============================================
  /// 首页缓存数据
  /// ===============================================

  Map<String, dynamic> get homepageCachedMap  {
    if (_homepageCachedMap == null) {
      String jsonStr = SpUtil.getString(_keyWithUserId('homepageMap'));
      if (jsonStr.isEmpty) {
        return null;
      }
      Map<String, dynamic> jsonMap = json.decode(jsonStr);
      _homepageCachedMap = new Map<String, dynamic>.from(jsonMap);
    }
    return _homepageCachedMap;
  }

  set homepageCachedMap(Map<String, dynamic> jsonMap) {
    String jsonStr = json.encode(jsonMap);
    SpUtil.putString(_keyWithUserId('homepageMap'), jsonStr);
    _homepageCachedMap = jsonMap;
  }

  Map<String, dynamic> get homeSettings  {
    if (_homeSettings == null) {
      String jsonStr = SpUtil.getString(_keyWithUserId('homeSettings'));
      if (jsonStr.isEmpty) {
        return null;
      }
      Map<String, dynamic> jsonMap = json.decode(jsonStr);
      _homeSettings = new Map<String, dynamic>.from(jsonMap);
    }
    return _homeSettings;
  }

  set homeSettings (Map<String, dynamic> jsonMap) {
    String jsonStr = json.encode(jsonMap);
    SpUtil.putString(_keyWithUserId('homeSettings'), jsonStr);
    _homeSettings = jsonMap;
  }


  String _keyWithUserId(String key) {
    String newKey = key + '_' + HomeUtils.instance.userId;
    return newKey;
  }

  factory HomeUtils() => _getInstance();

  static HomeUtils get instance => _getInstance();
  static HomeUtils _instance;

  HomeUtils._internal();

  static HomeUtils _getInstance() {
    if (_instance == null) {
      _instance = new HomeUtils._internal();
    }
    return _instance;
  }
}
