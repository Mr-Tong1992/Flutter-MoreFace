import 'package:flutter/foundation.dart';
import 'package:flutter_common/flutter_common.dart';
import 'package:flutter_homepage/model/services_app.dart';
import 'package:flutter_homepage/utils/home_utils.dart';
import '../model/app_group.dart';
import '../model/home_juhe.dart';
import '../model/global_settings.dart';
import '../model/home_settings.dart';
import '../model/region.dart';
import '../model/role.dart';
import 'package:flutter_plugin/flutter_plugin.dart';
import '../net/home_api.dart';
import '../utils/home_utils.dart';

export 'home_api.dart';

class HomeServices {
  /// 首页列表
  static void requestHomeData<T>({
    dynamic params,
    Function(List<AppGroup> t, int version, String role, String distrinct) onSuccess,
    Function(int code, String msg) onError}) async {

    await HTTPServices.instance.startPostRequest(
        HomeAPI.kHomeDomain,
        HomeAPI.kHomePageInfo,
        queryParameters: params,
        onSuccess: (result) {
          int version = result.data['version'];
          String district = result.data['district'];
          String role = result.data['role'];

          // 缓存首页数据
          HomeUtils.instance.homepageCachedMap = result.data;


          List list = new List<Map<String, dynamic>>.from(
              result.data["appGroups"] ?? {});

          List<AppGroup> appGroups = new List<AppGroup>();

          for (var i = 0; i < list.length; i++) {
            Map<String, dynamic> groupJson = new Map<String, dynamic>.from(list[i]);
            AppGroup appGroup = new AppGroup.fromJson(groupJson);
            if(appGroup.isOrg == 1){
              _filterOrganizationApp(appGroup);
            }
            appGroups.add(appGroup);
          }
          if (onSuccess != null) {
            onSuccess(appGroups, version, role, district);
          }
        },
        onError: (code, msg) {
          if (onError != null) {
            onError(code, msg);
          }
        }
    );
  }

  /// 过滤当前组织下的服务
  static void _filterOrganizationApp(AppGroup group){
    List<ServicesApp> apps = HomeUtils.instance.getTaipOrgApps();
    if(apps?.length == 0){
      return;
    }
    String orgAppCategory = group.orgAppCategory.toString();

    List<ServicesApp> appInfoList = new List<ServicesApp>();
    if(orgAppCategory == "all"){
      appInfoList = apps;
    }else{
      apps.forEach((app){
        if(app?.appCategory == orgAppCategory){
          appInfoList.add(app);
        }
      });
    }

    // 排序
    appInfoList.sort((obj1, obj2){
      return obj1.sort.compareTo(obj2.sort);
    });

    group.appInfoList = appInfoList;
  }

  /// 天气、温度等聚合信息
  static void requestJuHeInfo<T>({@required String domain,
    String path,
    Map<String, dynamic> queryParameters,
    Function(HomeJuHe t) onSuccess,
    Function(int code, String msg) onError,
    CancelToken cancelToken}) async {
    await HTTPServices.instance.request(Method.get, domain, path,
        params: null,
        queryParameters: queryParameters,
        options: null,
        cancelToken: cancelToken,
        onSuccess: (result) {
          HomeJuHe juhe = new HomeJuHe.fromJson(result.data);
          if (onSuccess != null) {
            onSuccess(juhe);
          }
        },
        onError: (code, msg) {
          if (onError != null) {
            onError(code, msg);
          }
        });
  }

  /// 全局设置
  static void requestGlobalSettings<T>({@required String domain,
    String path,
    Function(GlobalSettings t) onSuccess,
    Function(int code, String msg) onError,
    CancelToken cancelToken}) async {
    await HTTPServices.instance.request(Method.post, domain, path,
        params: null,
        queryParameters: null,
        options: null,
        cancelToken: cancelToken,
        onSuccess: (result) {
          GlobalSettings settings = GlobalSettings.fromJson(result.data);
          if (onSuccess != null) {
            onSuccess(settings);
          }
        },
        onError: (code, msg) {
          if (onSuccess != null) {
            onSuccess(null);
          }
        });
  }

  /// 首页配置信息
  static void requestSettingInfo<T>({@required String domain,
    String path,
    Function(HomeSettings t) onSuccess,
    Function(int code, String msg) onError,
    CancelToken cancelToken}) async {
    await HTTPServices.instance.request(Method.post, domain, path,
        params: null,
        queryParameters: null,
        options: null,
        cancelToken: cancelToken,
        onSuccess: (result) {
          HomeUtils.instance.homeSettings = result.data;
          HomeSettings settings = HomeSettings.fromJson(result.data);
          if (onSuccess != null) {
            onSuccess(settings);
          }
        },
        onError: (code, msg) {
          if (onError != null) {
            onError(code, msg);
          }
        });
  }

  /// 用户角色列表
  static void requestRolesList<T>(
  {
    Map<String, dynamic> params,
    Function(List<Role> t) onSuccess,
    Function(int code, String msg) onError
  }) async {

    await HTTPServices.instance.startPostRequest(HomeAPI.kHomeDomain, HomeAPI.kRoleList, params: params,
        onSuccess: (result){
          if(result.code == 0){
            List list = result.data['roles'];
            List<Role> roles = new List<Role>();
            list?.forEach((info){
              Role role = Role.fromJson(new Map<String, dynamic>.from(info));
              roles.add(role);
            });

//            // Mock数据
//            Role r1 = new Role("1163", '朝阳区');
//            Role r2 = new Role("2", '通州区');
//            roles.add(r1);
//            roles.add(r2);

            if(roles.length > 0){
              Role defaultRole = new Role('', '公众版');
              roles.insert(0, defaultRole);
              HomeUtils.instance.roles = roles;

              //先从缓存里读取上次角色记录 没有的情况再取第0个
              Role currentRole = HomeUtils.instance.currentRole;
              if(currentRole == null){
                HomeUtils.instance.currentRole = roles.first;
              }else{
                Role flagRole;
                roles.forEach((role){
                  if(currentRole.role == role.role){
                    flagRole = role;
                  }
                });

                if(flagRole != null){
                  HomeUtils.instance.currentRole = flagRole;
                }else{
                  HomeUtils.instance.currentRole = null;
                }
              }
            }else{
              // 普通用户显示默认首页(无选择角色框)
              HomeUtils.instance.currentRole = null;
            }


            if (onSuccess != null) {
              onSuccess(roles);
            }
          }
        },
        onError: (int code, String msg) {
          if(onError != null){
            onError(code, msg);
          }
        }
    );
  }

  /// 获取区域列表
  static void requestRegionList<T>({@required String domain,
    String path,
    Function(List<Region> t) onSuccess,
    Function(int code, String msg) onError,
    CancelToken cancelToken}) async {
    await HTTPServices.instance.request(Method.post, domain, path,
        params: null,
        queryParameters: null,
        options: null,
        cancelToken: cancelToken,
        onSuccess: (result) {
          List<Map<String, dynamic>> list = result.data['regions'];

          List<Region> regions = [];
          for (Map<String, dynamic> itemMap in list) {
            Region region = Region.fromJson(itemMap);
            regions.add(region);
          }
          if (onSuccess != null) {
            onSuccess(regions);
          }
        },
        onError: (int code, String msg) {
          if (onError != null) {
            onError(code, msg);
          }
        });
  }

  /// 记录用户的访问服务
  static void requestAddVisitingRecord<T>({
    dynamic params,
    Function(String resData) onSuccess,
    Function(int code, String msg) onError
  }) async {
    await HTTPServices.instance.startPostRequest(HomeAPI.kAppraiseServiceAvgsDomain, HomeAPI.kaddVisitingRecord,params: params,
        onSuccess: (result){
          if(result.code == 0){
            if (onSuccess != null) {
              onSuccess(result.message);
            }
          }
        },
        onError: (int code, String msg) {
          if(onError != null){
            onError(code, msg);
          }
        });
  }
}
