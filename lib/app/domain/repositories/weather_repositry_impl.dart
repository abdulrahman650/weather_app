import 'dart:developer';

import '../../data/data_sources/remote/weather_repository.dart';
import '../../shared/core/network/dio_helper.dart';
import '../request/location_request.dart';
import '../request/weather_request.dart';
import '../response/location_response.dart';
import '../response/weather_response.dart';



class WeatherRepositoryImpl extends WeatherRepository {
  final DioHelper _dio;
  WeatherRepositoryImpl(this._dio);

  @override
  Future<WeatherResponse?> getWeather(final WeatherRequest data) async {
    WeatherResponse? res;
    try {
      await _dio.get(
        '/data/2.5/onecall',
        json: data.toJson(),
      ).then((response) {
        if (response.data != null) {
          res = WeatherResponse.fromJson(response.data);
        } else {
          log('response.data == null');
        }
      });
    } catch (e) {
      log(e.toString());
    }
    return res;
  }

  @override
  Future<LocationResponse?> getLocation(final LocationRequest data) async {
    LocationResponse? res;
    try {
      await _dio.get(
        '/geo/1.0/reverse',
        json: data.toJson(),
      ).then((response) {
        if (response.data != null) {
          res = (response.data as List).map((e) => LocationResponse.fromJson(e)).toList()[0];
        } else {
          log('response.data == null');
        }
      });
    } catch (e) {
      log(e.toString());
    }
    return res;
  }
}