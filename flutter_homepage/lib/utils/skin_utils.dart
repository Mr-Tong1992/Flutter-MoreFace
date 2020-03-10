import 'dart:convert';

import 'package:flutter_common/flutter_common.dart';

class SkinUtils {

  static Map<int, String> get1001AppIconFileName() {

//    OSPlatform platform = await DeviceUtils.osPlatform();
//    if(platform == OSPlatform.Android){
//
//    }

    String jsonData = SpUtil.getString("skinJsonData");
    String dirPath = SpUtil.getString("filePath1001");
    Map<int, String> resultMap = new Map();
    try {
      Map<String, Object> allmap = jsonDecode(jsonData);
      List list = List.from(allmap["style1001"]);
      for (int i = 0; i < 8; i++) {
        Map<String, Object> map1001 = Map.from(list[i]);
        resultMap[map1001['index']] = dirPath +"/"+ map1001['img'].toString();
      }
      return resultMap;
    }catch (e){
      return null;
    }

  }
}
