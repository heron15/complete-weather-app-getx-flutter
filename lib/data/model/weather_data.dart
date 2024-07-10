class WeatherData {
  int? id;
  String? main;
  String? description;
  String? icon;

  WeatherData({this.id, this.main, this.description, this.icon});

  factory WeatherData.fromJson(Map<String, dynamic> json) => WeatherData(
    id: json['id'] as int?,
    main: json['main'] as String?,
    description: json['description'] as String?,
    icon: json['icon'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'main': main,
    'description': description,
    'icon': icon,
  };
}