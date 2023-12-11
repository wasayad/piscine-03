import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/component/weather/currentWeather.dart';

class Weekly extends StatefulWidget {
  const Weekly({
    required this.weather,
    super.key,
  });

  final Weather weather;

  @override
  State<Weekly> createState() => _WeeklyState();
}

class _WeeklyState extends State<Weekly> {
  List<Widget> getList(Weather weather) {
    DateTime now;
    var formatter = DateFormat('yy-MM-dd');
    var formatted;
    List<Widget> childs = [];
    if (weather.curWeather.location.contains("Error")) {
      childs.add(Text(style: const TextStyle(color: Colors.red),weather.curWeather.location));
    }
    else {
      childs.add(Text(weather.curWeather.location));
    }
    for (var i = 0; i < 7; i++) {
      now = DateTime.parse(weather.dayWeather.hours[i]);
      formatted = formatter.format(now);
      childs.add(Text(
          "$formatted ${weather.weekWeather.temperatureMin[i].toString()}°C ${weather.weekWeather.temperatureMax[i]}°C ${weather.weekWeather.weather[i]}"));
    }
    return childs;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: getList(widget.weather),
          ),
        ));
  }
}
