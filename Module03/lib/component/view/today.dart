import 'package:flutter/material.dart';
import 'package:weatherapp/component/weather/currentWeather.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class ChartData {
  ChartData(this.x, this.y);

  final DateTime x;
  final double y;

  static List<ChartData> getData(Weather weather) {
    DateTime now;
    var formatter = DateFormat('hh:mm');
    var formatted;
    List<ChartData> data = [];

    for (var i = 0; i < 24; i++) {
      now = DateTime.parse(weather.dayWeather.hours[i]);
      formatted = formatter.format(now);
      data.add(ChartData(now, weather.dayWeather.temperature[i]));
    }

    return data;
  }
}

class Today extends StatefulWidget {
  Weather weather;

  Today({
    required this.weather,
    super.key,
  });

  @override
  State<Today> createState() => _TodayState();
}

class _TodayState extends State<Today> {
  List<Widget> getList(Weather weather) {
    DateTime now;
    var formatter = DateFormat('hh:mm');
    var formatted;
    List<Widget> childs = [];
    if (weather.curWeather.location.contains("Error")) {
      childs.add(Text(
          style: const TextStyle(color: Colors.red),
          weather.curWeather.location));
    } else {
      childs.add(Text(weather.curWeather.location, style: const TextStyle(color: Colors.white, fontSize: 25),));
    }
    childs.add(Container(
        color: const Color.fromRGBO(0, 0, 0, 0.4),
        height: 200,
        width: 400,
        child: SfCartesianChart(
            // Initialize category axis
            title: ChartTitle(text: 'Daily temperature', textStyle: const TextStyle(color: Colors.white)),
            primaryXAxis: DateTimeAxis(

            ),
            series: <ChartSeries>[
              // Initialize line series
              LineSeries<ChartData, DateTime>(
                  dataSource: ChartData.getData(weather),
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,)
            ])));

    if (weather.dayWeather.hours.isNotEmpty) {
      for (var i = 0; i < 24; i++) {
        now = DateTime.parse(weather.dayWeather.hours[i]);
        formatted = formatter.format(now);
        childs.add(Text(
            "$formatted ${weather.dayWeather.temperature[i].toString()}°C ${weather.dayWeather.windSpeed[i]}km/h"));
      }
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
