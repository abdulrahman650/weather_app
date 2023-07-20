class LocationRequest{


  double? lat,lon;
  int? limit;
  String? lang,appid;

  LocationRequest({this.lat, this.lon, this.limit, this.lang, this.appid});

  Map<String, dynamic> toJson() {
    return {
      "lat": this.lat,
      "lon": this.lon,
      "limit": this.limit,
      "lang": this.lang,
      "appid": this.appid,
    };
  }

  factory LocationRequest.fromJson(Map<String, dynamic> json) {
    return LocationRequest(
      lat: double.parse(json["lat"]),
      lon: json["lon"],
      limit: int.parse(json["limit"]),
      lang: json["lang"],
      appid: json["appid"],
    );
  }
//
}