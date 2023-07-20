class WeatherRequest{

  double? lat,lon;
  String? lang,appid;

  WeatherRequest({this.lat, this.lon, this.lang, this.appid});

  factory WeatherRequest.fromJson(Map<String, dynamic> json) {
    return WeatherRequest(
      lat: double.parse(json["lat"]),
      lon: json["lon"],
      lang: json["lang"],
      appid: json["appid"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "lat": this.lat,
      "lon": this.lon,
      "lang": this.lang,
      "appid": this.appid,
    };
  }
//

}