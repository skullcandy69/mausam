class WeatherData {
  final DateTime date;
  final String name;
  final String country;
  final double temp;
  final String main;
  final String icon;
  final double tempMin;
  final double feelsLike;
  final int pressure;
  final int humidity;
  final double wind;


  final double tempMax;


  WeatherData( {this.wind,this.pressure,this.humidity,this.feelsLike,this.country,this.tempMin, this.tempMax, this.date, this.name, this.temp, this.main, this.icon});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    var temp=json['main']['temp'].toDouble()-273.15;
    var temp_min=json['main']['temp_min'].toDouble()-273.15;
    var temp_max=json['main']['temp_max'].toDouble()-273.15;
    var feels_like=json['main']['feels_like'].toDouble()-273.15;

    return WeatherData(
      date: new DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000, isUtc: false),
      name: json['name'],
      country: json['sys']['country'],
      temp: temp,
      tempMin: temp_min,
      tempMax: temp_max,
      wind: json['wind']['speed'],
      pressure:json['main']['pressure'] ,
      humidity: json['main']['humidity'],
      feelsLike: feels_like,
      main: json['weather'][0]['main'],
      icon: json['weather'][0]['icon'],
    );
  }
}