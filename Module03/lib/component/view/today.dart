import 'package:flutter/material.dart';
import 'package:weatherapp/component/weather/currentWeather.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../weather/weatherCodeParser.dart';

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
    String formatted;
    WeatherCode code = WeatherCode();
    List<Widget> rowChild = [];
    List<Widget> children = [];
    if (weather.curWeather.location.contains("Error")) {
      children.add(Text(
          style: const TextStyle(color: Colors.red),
          weather.curWeather.location));
    } else {
      children.add(Text(
        weather.curWeather.location,
        style: const TextStyle(color: Colors.white, fontSize: 25),
      ));
    }
    children.add(Container(
        color: const Color.fromRGBO(0, 0, 0, 0.4),
        height: MediaQuery.of(context).size.height / 3,
        width: MediaQuery.of(context).size.width,
        child: SfCartesianChart(

            plotAreaBorderColor: Colors.white,
            borderColor: Colors.white,
            legend: Legend(
              position: LegendPosition.bottom,
              textStyle: const TextStyle(color: Colors.white),
              isVisible: true,
            ),
            // Initialize category axis
            title: ChartTitle(
                text: 'Daily temperature',
                textStyle: const TextStyle(color: Colors.white)),
            primaryXAxis: DateTimeAxis(
              labelStyle: const TextStyle(color: Colors.white),
            ),
            primaryYAxis: NumericAxis(
              labelStyle: const TextStyle(color: Colors.white),
            ),
            series: <ChartSeries>[
              // Initialize line series
              LineSeries<ChartData, DateTime>(
                dataSource: ChartData.getData(weather),
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                color: Colors.red,

                legendItemText: "Temperature",
              ),
            ])));
    if (weather.dayWeather.hours.isNotEmpty) {
      for (var i = 0; i < 24; i++) {
        now = DateTime.parse(weather.dayWeather.hours[i]);
        formatted = formatter.format(now);
        rowChild.add(SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            child: Column(children: [
              Expanded(
                  child: Text(
                      formatted,
                      style:
                      const TextStyle(color: Colors.white, fontSize: 25))),
              Expanded(
                  child: Text(
                      "${weather.dayWeather.temperature[i].toString()}°C",
                      style:
                          const TextStyle(color: Colors.white, fontSize: 25))),
              Expanded(
                  child: Icon(code.weatherCode[weather.dayWeather.weather[i].toString()]['icon'], size: 45, color: Colors.white,)),
              Expanded(
                  child: Text("${weather.dayWeather.windSpeed[i]}km/h",
                      style:
                          const TextStyle(color: Colors.white, fontSize: 25)))
            ])));
      }
      children.add(SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: rowChild,
          )));
    }
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: getList(widget.weather),
        ));
  }
}
