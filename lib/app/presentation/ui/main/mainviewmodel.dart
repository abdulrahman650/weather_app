import 'dart:convert';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:weatherappbgd/app/data/data_sources/local/preference_manager.dart';
import 'package:weatherappbgd/app/domain/entities/location_model.dart';
import 'package:weatherappbgd/app/domain/response/weather_response.dart';
import 'package:weatherappbgd/app/presentation/router/app_routes.dart';
import 'package:weatherappbgd/app/shared/constant/app_values.dart';
import 'package:weatherappbgd/app/shared/constant/string_keys.dart';
import 'package:weatherappbgd/app/shared/core/base/base_viewmodel.dart';

import '../../../shared/style/widgets.dart';

class MainViewModel extends BaseViewModel {
  PreferenceManager preferenceManager;

  MainViewModel(this.preferenceManager);

  late List<PopUpModel> popupmodel;
  WeatherResponse? weather;
  LocationModel? location;
  bool _screenError = false;
  bool _screenLoader = false;
  int _viewIndex = 0;

  bool get screenError => _screenError;

  set screenError(bool value) {
    _screenError = value;
    notifyListeners();
  }

  bool get screenLoader => _screenLoader;

  set screenLoader(bool value) {
    screenLoader = value;
    notifyListeners();
  }

  int get viewIndex => _viewIndex;

  set viewIndex(int value) {
    _viewIndex = value;
    notifyListeners();
  }

  //+++++++++++++++++++++++++++++++++++++++++
  Future<void> refreshScreen(BuildContext context) async =>
      context.go(AppRoutes.splash);

//+++++++++++++++++++++++++++++++++++++++++
  void toAboutUs(BuildContext context) async => context.push(AppRoutes.aboutUs);

//+++++++++++++++++++++++++++++++++++++++++
  void hourlyWeather() => viewIndex = 0;

//+++++++++++++++++++++++++++++++++++++++++
  void dailyWeather() => viewIndex = 1;

//+++++++++++++++++++++++++++++++++++++++++

  Future<void> getLastWeather() async {
    String response = await preferenceManager.getLastWeather();
    if (response.isNotEmpty) {
      weather = WeatherResponse.fromJson(jsonDecode(response));
    } else {
      screenError = true;
    }
  }
//+++++++++++++++++++++++++++++++++++++++++++++++++++
  Future<void> getCurrentLocation() async {
    String response = await preferenceManager.getCurrentLocation();
    if (response.isNotEmpty) {
      location = LocationModel.fromJson(jsonDecode(response));
    } else {
location = AppValues.defoultLocation;
    }
  }

//  =++++++++++++++++++++++++++++++++++
void widgetInit() {
popupmodel=[
  PopUpModel(title: StringsKeys.hourlyWeather.tr(), func: hourlyWeather),
  PopUpModel(title: StringsKeys.weatherByDay.tr(), func:dailyWeather),
];
}
//+++++++++++++++++++++++++++++++++++++++++++++
Future<void > init()async{
    
    setBusy(true);
    widgetInit();
    try {
   await Future.wait([
     getCurrentLocation(),
     getLastWeather(),
  ]);

    }catch(e){log(e.toString());screenError=true;}
    setBusy(false);
}
}
