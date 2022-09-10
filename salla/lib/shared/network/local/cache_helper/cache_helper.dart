import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance() ;
  }

  static Future<bool> setDark({
    required String key,
    required bool isDark,
  }) async{
    return await sharedPreferences.setBool(key, isDark);
  }

  static bool? getDark({
    required String key,
  }){
    return sharedPreferences.getBool(key);
  }

  static Future<bool> saveData(
      {
        required String key,
        required dynamic data,
      }) async{
    if(data is String) {
      return await sharedPreferences.setString(key, data);
    }else if(data is bool){
      return await sharedPreferences.setBool(key, data);
    }else if(data is int){
      return await sharedPreferences.setInt(key, data);
    }else{
      return await sharedPreferences.setDouble(key, data);
    }
  }


  static dynamic getData(
      {
        required String key,
      }){
    return sharedPreferences.get(key);

  }

  static Future<bool> removeData({
    required String key,
  }) async {
    return await sharedPreferences.remove(key);
  }


}