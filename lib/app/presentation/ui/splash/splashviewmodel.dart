import 'dart:convert';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherappbgd/app/data/data_sources/local/preference_manager.dart';
import 'package:weatherappbgd/app/data/data_sources/remote/weather_repository.dart';
import 'package:weatherappbgd/app/domain/entities/location_model.dart';
import 'package:weatherappbgd/app/domain/request/weather_request.dart';
import 'package:weatherappbgd/app/shared/constant/app_values.dart';
import 'package:weatherappbgd/app/shared/core/base/base_viewmodel.dart';
import 'package:weatherappbgd/app/shared/utils/utils.dart';

import '../../../domain/request/location_request.dart';
import '../../../domain/response/location_response.dart';
import '../../../domain/response/weather_response.dart';

class SplashViewModel extends BaseViewModel {
  PreferenceManager preferenceManager;
  WeatherRepository weatherRepository;

  SplashViewModel(this.preferenceManager, this.weatherRepository);
  void init(void Function()getRouterFun)async{
    final ConnectivityResult connectivityResult=await (Connectivity().checkConnectivity());
    if (connectivityResult== ConnectivityResult.mobile|| connectivityResult ==ConnectivityResult.wifi){
     await getCurrentLocation();
     await getWeather();
    }
    else{
      Future.delayed(const Duration(milliseconds: 300));

    }
    getRouterFun();
  }


  Future<void> getWeather() async {
    //================================================
    ///TODO GET CURRENT LOCATION FROM SHARED PREFS
    final String locationPrefs = await preferenceManager.getCurrentLocation();
    final LocationModel location;
    if (locationPrefs.isEmpty) {
      location = AppValues.defoultLocation;
    } else {
      location = LocationModel.fromJson(jsonDecode(locationPrefs));
    }
    //================================================
    ///TODO GET WEATHER FROM WEATHER REPO
    final WeatherRequest data = WeatherRequest(
      lat: location.latitude,
      lon: location.longitude,
      lang: getLanguageCode(),
      appid: AppValues.apiKey,
    );
    final WeatherResponse? weather = await weatherRepository.getWeather(data);
    //================================================
    ///TODO GET WEATHER TO SHARED PREFS
    if (weather != null) {
      await preferenceManager.setLastWeather(jsonEncode(weather.toJson()));
    }
  }

  Future<void> getCurrentLocation() async {
    LocationModel? location;
    try {
      bool enabled;
      if (kIsWeb) {
        LocationPermission permission = await Geolocator.checkPermission();
        if (permission != LocationPermission.always ||
            permission != LocationPermission.whileInUse) {
          permission = await Geolocator.requestPermission();
        }

        enabled = permission != LocationPermission.denied &&
            permission != LocationPermission.deniedForever;
      } else {
        enabled = await Permission.location.request().isGranted;
      }
      if (enabled) {
        final Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        final double latitude = position.latitude;
        final double longitude = position.longitude;
        if (kIsWeb) {
          List<Placemark> placemarks = await placemarkFromCoordinates(
              latitude, longitude,
              localeIdentifier: getLanguageCode());
          if (placemarks.isNotEmpty) {
            location = LocationModel(
                country: placemarks[0].country ?? "",
                city: placemarks[0].locality ?? "",
                latitude: latitude,
                longitude: longitude);
          } else {
            location = LocationModel(
                country: "",
                city: "",
                latitude: latitude,
                longitude: longitude);
          }
        } else {
          final LocationResponse? locationResponse =
              await weatherRepository.getLocation(LocationRequest(
            lon: longitude,
            lat: latitude,
            lang: getLanguageCode(),
            limit: 1,
            appid: AppValues.apiKey,
          ));
          if (locationResponse?.localNames != null) {
            location = LocationModel(
              country: '',
              latitude: longitude,
              longitude: longitude,
              city: _getCityByLang(locationResponse!.localNames!),
            );
          } else {
            location = LocationModel(
              country: '',
              latitude: longitude,
              longitude: longitude,
              city: '',
            );
          }
        }
      }
      if (location != null) {
        await preferenceManager
            .setCurrentLocation(jsonEncode(location.toJson()));
      }
    } catch (e) {
      log(e.toString());
    }
  }

  _getCityByLang(LocalNames localNames) {
    switch (getLanguageCode()) {
      case AppValues.langCodeUK:
        return localNames.uk;
      default:
        return localNames.en;
    }
  }
}
