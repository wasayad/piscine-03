import 'package:flutter/material.dart';
import '../weather/currentWeather.dart';
import '../weather/weatherCodeParser.dart';
class Currently extends StatefulWidget {
  final Weather weather;
  const Currently({
    super.key,
    required this.weather,
  });
  @override
  State<Currently> createState() => _CurrentlyState();
}

class _CurrentlyState extends State<Currently> {
  WeatherCode weatherCode = WeatherCode();
  @override
  Widget build(BuildContext context) {

    return  SingleChildScrollView( child:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          (() {
            if (widget.weather.curWeather.location.contains("Error")) {
              return Text(style: const TextStyle(color: Colors.red),widget.weather.curWeather.location);
            }
            return Text(style: const TextStyle(fontSize: 20, color: Colors.white), widget.weather.curWeather.location);} ()) ,
          Text(style: const TextStyle(fontSize: 35, color: Colors.white), widget.weather.curWeather.temperature),
            (() {
              if (double.parse(widget.weather.curWeather.temperature.split(" ")[0]) < 5)
                {
                  return const Icon(Icons.severe_cold, color: Colors.white, size: 150,);
                }
              else if (double.parse(widget.weather.curWeather.temperature.split(" ")[0]) < 25) {
                return const Icon(
                  Icons.favorite_outlined, color: Colors.green, size: 150,);
              }
              else {
                return const Icon(
                  Icons.sunny, color: Colors.red, size: 150,);
              }
              } ()),
          Text(style: const TextStyle(fontSize: 35, color: Colors.white), weatherCode.weatherCode[widget.weather.curWeather.weather]['text'].toString()),
          Icon(weatherCode.weatherCode[widget.weather.curWeather.weather]['icon'], size: 100, color: Colors.white),
          Text(style: const TextStyle(fontSize: 35, color: Colors.white), widget.weather.curWeather.windSpeed),
          (() {
            if (double.parse(widget.weather.curWeather.windSpeed.split(" ")[0]) < 20)
            {
              return const Icon(Icons.favorite_outlined, color: Colors.green, size: 150,);
            }
            else {
              return const Icon(
                Icons.wind_power, color: Colors.red, size: 150,);
            }
          } ()),


        ],
    ));
  }
}
