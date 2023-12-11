class CurrentWeather {
  String location;
  String temperature;
  String weather;
  String windSpeed;

  CurrentWeather()
      : location = "",
        temperature = "",
        weather = "",
        windSpeed = "";

  CurrentWeather.fromJson(List<dynamic>? weatherInfo)
      : temperature =
            "${weatherInfo?[1]["current"]["temperature_2m"]} ${weatherInfo?[1]["current_units"]["temperature_2m"]}",
        location =
            "${weatherInfo?[0][0].name}, ${weatherInfo?[0][0].locality} ${weatherInfo?[0][0].country}",
        weather = "${weatherInfo?[1]["current"]["weather_code"]}",
        windSpeed =
            "${weatherInfo?[1]["current"]["wind_speed_10m"]} ${weatherInfo?[1]["current_units"]["wind_speed_10m"]}";
}

class DailyWeather {
  String location;
  List<dynamic> hours;
  List<dynamic> temperature;
  List<dynamic> weather;
  List<dynamic> windSpeed;

  DailyWeather()
      : location = "",
        hours = [],
        temperature = [],
        weather = [],
        windSpeed = [];

  DailyWeather.fromJson(List<dynamic>? weatherInfo)
      : hours = weatherInfo?[1]["hourly"]["time"],
        temperature = weatherInfo?[1]["hourly"]["temperature_2m"],
        location =
            "${weatherInfo?[0][0].name}, ${weatherInfo?[0][0].locality} ${weatherInfo?[0][0].country}",
        weather = weatherInfo?[1]["hourly"]["weather_code"],
        windSpeed = weatherInfo?[1]["hourly"]["wind_speed_10m"];
}

class WeeklyWeather {
  String location;
  List<dynamic> hours;
  List<dynamic> temperatureMax;
  List<dynamic> temperatureMin;
  List<dynamic> weather;

  WeeklyWeather()
      : location = "",
        hours = [],
        temperatureMax = [],
        temperatureMin = [],
        weather = [];

  WeeklyWeather.fromJson(List<dynamic>? weatherInfo)
      : hours = weatherInfo?[1]["daily"]["time"],
        temperatureMax = weatherInfo?[1]["daily"]["temperature_2m_max"],
        temperatureMin = weatherInfo?[1]["daily"]["temperature_2m_min"],
        location =
            "${weatherInfo?[0][0].name}, ${weatherInfo?[0][0].locality} ${weatherInfo?[0][0].country}",
        weather = weatherInfo?[1]["daily"]["weather_code"];
}

class Weather {
  CurrentWeather curWeather;
  DailyWeather dayWeather;
  WeeklyWeather weekWeather;

  Weather()
      : curWeather = CurrentWeather(),
        dayWeather = DailyWeather(),
        weekWeather = WeeklyWeather();

  Weather.fromJson(List<dynamic>? weatherInfo)
      : curWeather = CurrentWeather.fromJson(weatherInfo),
        dayWeather = DailyWeather.fromJson(weatherInfo),
        weekWeather = WeeklyWeather.fromJson(weatherInfo);
  Weather fromJson(Weather weather) {
    curWeather = weather.curWeather;
    dayWeather = weather.dayWeather;
    weekWeather =weather.weekWeather;
    return this;
  }
}
