class ApiUrl {
  //weather api part
  static const String _weatherBaseUrl = "https://api.openweathermap.org/data/3.0/onecall";
  static const String _apiKey =
      "203b08bce6eba986aa77c5ff88783650"; //ADD_YOUR_OPEN_WEATHER_MAP_API_KEY
  static String weatherApi(lat, lon) =>
      "$_weatherBaseUrl?lat=$lat&lon=$lon&appid=$_apiKey&units=metric&exclude=minutely";

  //google cloud api part
  static const String _placeApiKey =
      "AIzaSyCgFBWG93liXqwHQyB5y7HcrS8UHfagu9c"; //ADD_YOUR_GOOGLE_PLACE_API_KEY

  static const String _googlePlaceAPiBaseURL =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json';

  static String placeApi(String sessionToken, String input) =>
      '$_googlePlaceAPiBaseURL?input=$input&key=$_placeApiKey&sessiontoken=$sessionToken';
}
