class ApiUrl {
  static const String _baseUrl = "https://api.openweathermap.org/data/3.0/onecall";

  //ADD_YOUR_OPENWEATHERMAP_API_KEY
  static const String _apiKey = "203b08bce6eba986aa77c5ff88783650";

  static String weatherApi(lat, lon) =>
      "$_baseUrl?lat=$lat&lon=$lon&appid=$_apiKey&units=metric&exclude=minutely";
}
