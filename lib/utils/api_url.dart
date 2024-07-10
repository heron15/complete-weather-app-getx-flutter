class ApiUrl {
  static const String _baseUrl = "https://api.openweathermap.org/data/3.0/onecall";

  //ADD_YOUR_OPENWEATHERMAP_API_KEY
  static const String _apiKey = "ADD_YOUR_OPENWEATHERMAP_API_KEY";

  static String weatherApi(lat, lon) =>
      "$_baseUrl?lat=$lat&lon=$lon&appid=$_apiKey&units=metric&exclude=minutely";
}
