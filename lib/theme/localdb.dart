import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSaver {
  static String nameKey = 'NAMEKEY';
  static String emailKey = 'EMAILKEY';
  static String imagekey = 'IMAGEKEY';
  static String logkey = 'LOGKEY';

  static Future<bool> saveName(String userName) async {
    SharedPreferences namePreferences = await SharedPreferences.getInstance();
    return await namePreferences.setString(nameKey, userName);
  }

  static Future<bool> saveEmail(String userEmail) async {
    SharedPreferences EmailPreferences = await SharedPreferences.getInstance();
    return await EmailPreferences.setString(emailKey, userEmail);
  }

  static Future<bool> saveImg(String userImage) async {
    SharedPreferences ImagePreferences = await SharedPreferences.getInstance();
    return await ImagePreferences.setString(imagekey, userImage);
  }

  static Future<String?> getName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(nameKey);
  }

  static Future<String?> getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(emailKey);
  }

  static Future<String?> getImage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(imagekey);
  }

  static Future<bool?> saveLoginData(bool isUserLoggedIn) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(logkey, isUserLoggedIn);
  }

  static Future<bool?> getLogData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getBool(logkey);
  }
}
