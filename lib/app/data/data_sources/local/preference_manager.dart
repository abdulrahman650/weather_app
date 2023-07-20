import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  static const String _currentLocation = '_currentLocation';
  static const String _lastWeather = '_lastWeather';



  Future<bool> setCurrentLocation (String? e)async {
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    return await sharedPreferences.setString(_currentLocation, e??"");
  }

  Future<bool> setLastWeather (String? e)async {
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    return await sharedPreferences.setString(_lastWeather, e??"");
  }


  Future<String> getCurrentLocation ()async{
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    return  sharedPreferences.getString(_currentLocation)??"";

  }

  Future<String> getLastWeather ()async{
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    return  sharedPreferences.getString(_lastWeather)??"";
  }


  Future<void> clear ()async{
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }
}
