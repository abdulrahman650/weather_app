import 'package:weatherappbgd/app/domain/request/weather_request.dart';
import 'package:weatherappbgd/app/domain/response/location_response.dart';

import '../../../domain/request/location_request.dart';
import '../../../domain/response/weather_response.dart';


abstract class WeatherRepository{
  Future<WeatherResponse?>  getWeather(final WeatherRequest weatherRequest);
  Future<LocationResponse?> getLocation(final LocationRequest locationRequest);

}