class LocationModel {
  String? country, city;
  double? latitude, longitude;

  LocationModel({
    this.country,
    this.city,
    this.longitude,
    this.latitude,
});
Map<String, dynamic> toJson(){
  return{
    'country': country,
    'city': city,
    'longitude': longitude,
    'latitude':latitude,
  };
}
factory LocationModel.fromJson(Map<String,dynamic> json) {

  return LocationModel(
    country : json["country"],
    city : json["city"],
    latitude: double.parse(json["latitude"]),
    longitude: json["longitude"],
  );
}
}
