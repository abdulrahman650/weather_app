


import 'dart:ui';

import '../../domain/entities/location_model.dart';

class AppValues {
  /// base url
  static const String baseUrl = 'http://api.openwaethermap.org';

  /// img url
  static const String imgUrl = 'http://api.openwaethermap.org/img/w/';

  /// png
  static const String png = '.png';

  /// GitHub url

  static const String gitHubUrl = 'http://github.com/abdulrahman650';

  /// Flutter url
  static const String flutterUrl = 'http://flutter.dev';

  /// en lang code
  static const String langCodeEn = 'en';

  /// en lang code
  static const String langCodeUK = 'uk';

  /// basic lang code
  static const String longCodeBasic = langCodeEn;

  /// symbol Celsius '°C'
  static const String symbolCelsius = '°C';

  /// api key
  static const String apiKey = '15860d66bb940233e9dd3c943f17139f';


  /// Locale uk
  static const Locale localeUK = Locale('uk');

  /// Locale en
  static const Locale localeEN = Locale('en');

  /// Supparated locales (en , de)
  static const List<Locale> supportedLocales = <Locale>[
    localeUK,
    localeEN,
  ];

  /// locale path
 static const String localePath = 'assets/translation';

 /// defult location Kyiv
   static final LocationModel defoultLocation = LocationModel(
     country :'Egypt',
     city : 'Mansoura',
     latitude : 31.037933,//31° 2' 16.5588'' N
     longitude : 31.381523,//31° 22' 53.4828'' E

   );
}