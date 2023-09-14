import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference{
  static late SharedPreferences sharedPreference;
  static init()async{
    sharedPreference= await SharedPreferences.getInstance();
  }
  static Future<bool> setDate({
    required String key,
    required dynamic value,
  })async{
    if(value is bool)return await sharedPreference.setBool(key, value);
    if(value is int)return await sharedPreference.setInt(key, value);
    if(value is String)return await sharedPreference.setString(key, value);

    return await sharedPreference.setDouble(key, value);
  }
  static dynamic getDate({required String key}){
    return sharedPreference.get(key);
  }
  static Future<bool> removeDate({required String key})async{
    return await sharedPreference.remove(key);
  }

}
