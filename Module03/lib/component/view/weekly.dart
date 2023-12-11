import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weatherapp/component/weather/currentWeather.dart';
import '../weather/weatherCodeParser.dart';


class ChartData {
  ChartData(this.x, this.y);

  final DateTime x;
  final double y;

  static List<ChartData> getData(Weather weather, bool minMax) {
    DateTime now;
    List<ChartData> data = [];

    for (var i = 0; i < 7; i++) {
      now = DateTime.parse(weather.weekWeather.hours[i]);
      if (minMax) {
        data.add(ChartData(now, weather.weekWeather.temperatureMax[i]));
      } else {
        data.add(ChartData(now, weather.weekWeather.temperatureMin[i]));
      }
    }

    return data;
  }
}

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
        height: MediaQuery.of(context).size.height / 2.5,
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
                text: 'Weekly temperature',
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
                dataSource: ChartData.getData(weather, true),
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                color: Colors.red,

                legendItemText: "Maximum temperature",
              ),
              LineSeries<ChartData, DateTime>(
                  dataSource: ChartData.getData(weather, false),
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  legendItemText: "Minimum temperature",
                  color: Colors.blue)
            ])));

    if (weather.dayWeather.hours.isNotEmpty) {
      for (var i = 0; i < 7; i++) {
        now = DateTime.parse(weather.dayWeather.hours[i]);
        formatted = formatter.format(now);
        rowChild.add(SizedBox(
            height: 145,
            width: 150,
            child: Column(children: [
              Expanded(
                  child: Text(
                      formatted,
                      style:
                      const TextStyle(color: Colors.white, fontSize: 25))),
              Expanded(
                  child: Icon(code.weatherCode[weather.dayWeather.weather[i].toString()]['icon'], size: 45, color: Colors.white,)),
              Expanded(
                  child: Text(
                      "${weather.weekWeather.temperatureMax[i].toString()}°C",
                      style:
                      const TextStyle(color: Colors.white, fontSize: 25))),
              Expanded(
                  child: Text(
                      "${weather.weekWeather.temperatureMin[i].toString()}°C",
                      style:
                      const TextStyle(color: Colors.white, fontSize: 25))),

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
