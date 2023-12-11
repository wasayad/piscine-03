import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import '../component/geolocation/geolocation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_typeahead/flutter_typeahead.dart';
import './geolocation/position.dart';
import 'package:geocoding/geocoding.dart';
import './weather/currentWeather.dart';

class AppBarComponent extends StatefulWidget implements PreferredSizeWidget {
  const AppBarComponent(
      {required this.onWeatherChange, required this.onChanged, super.key});

  final ValueChanged<String> onChanged;
  final ValueChanged<Weather> onWeatherChange;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<AppBarComponent> createState() => _AppBarComponentState();
}

Future<http.Response> getCity(String country) {
  return http.get(Uri.parse(
      'https://geocoding-api.open-meteo.com/v1/search?name=$country&count=15'));
}

class _AppBarComponentState extends State<AppBarComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 5,
              child: TypeAheadField<Pos>(
                builder: (context, controller, focusNode) {
                  return Row(
                    children: [
                      const Expanded(
                          child: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 30.0,
                      )),
                      Expanded(
                          flex: 4,
                          child: TextField(
                              controller: controller,
                              focusNode: focusNode,

                              autofocus: false,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  filled: false,
                                  labelStyle:  TextStyle(color: Colors.white),
                                  labelText: 'search location',)))
                    ],
                  );
                },
                itemBuilder: (BuildContext context, Pos value) {
                  return ListTile(
                    title: Text(value.name),
                    subtitle: Text('${value.country}, ${value.locality}'),
                  );
                },
                onSelected: (Pos value) async {
                  List<dynamic> ret = [];
                  List<Pos> city = [];
                  city.add(value);
                  List<Placemark>? locations;
                  http.Response res;
                  Weather weather = Weather();
                  try {
                    res = await http.get(Uri.parse(
                        'https://api.open-meteo.com/v1/forecast?latitude=${value.latitude}&longitude=${value.longitude}&current=temperature_2m,weather_code,wind_speed_10m&hourly=temperature_2m,weather_code,wind_speed_10m&daily=weather_code,temperature_2m_max,temperature_2m_min,wind_speed_10m_max'));
                    dynamic body = jsonDecode(res.body);
                    ret.add(city);
                    ret.add(body);
                    weather = Weather.fromJson(ret);
                  } on Exception catch (_) {
                    weather.curWeather.location =
                        "The connection service is lost, please check your internet connection or try again later";
                    weather.dayWeather.location =
                        "The connection service is lost, please check your internet connection or try again later";
                    weather.weekWeather.location =
                        "The connection service is lost, please check your internet connection or try again later";
                  }
                  widget.onWeatherChange(weather);
                },
                suggestionsCallback: (String search) async {
                  Response res = await getCity(search);
                  List<Pos> locations = [];
                  Pos location;
                  dynamic body = json.decode(res.body);
                  if (body.containsKey("results")) {
                    for (var index = 0; index < 5; index++) {
                      if (body["results"].length > index) {
                        var city = body["results"][index];
                        location = Pos.fromJson(city);
                        locations.add(location);
                      }
                    }
                  }
                  return locations;
                },
                errorBuilder: (context, error) => const ListTile(
                  title: Text(
                      style: TextStyle(color: Colors.red),
                      "The connection service is lost, please check your internet connection or try again later"),
                ),
              )),
          const Text(style: TextStyle(fontSize: 40, color: Colors.white),"|"),
          Expanded(
              child: IconButton(
            icon: const Icon(color: Colors.white,Icons.fmd_good),
            onPressed: () async {
              List<dynamic> ret = [];
              List<Placemark>? locations;
              http.Response res;
              Position coordinate = await determinePosition();
              Weather weather;
              try {
                locations = await placemarkFromCoordinates(
                    coordinate.latitude, coordinate.longitude);
                res = await http.get(Uri.parse(
                    'https://api.open-meteo.com/v1/forecast?latitude=${coordinate.latitude}&longitude=${coordinate.longitude}&current=temperature_2m,weather_code,wind_speed_10m&hourly=temperature_2m,weather_code,wind_speed_10m&daily=weather_code,temperature_2m_max,temperature_2m_min,wind_speed_10m_max'));
                dynamic body = jsonDecode(res.body);
                ret.add(locations);
                ret.add(body);
                weather = Weather.fromJson(ret);
              } on Exception catch (_) {
                weather = Weather();
                weather.curWeather.location =
                    "The connection service is lost, please check your internet connection or try again later";
                weather.dayWeather.location =
                    "The connection service is lost, please check your internet connection or try again later";
                weather.weekWeather.location =
                    "The connection service is lost, please check your internet connection or try again later";
              }
              setState(() {
                widget.onWeatherChange(weather);
              });
            },
            iconSize: 50,
          )),
        ],
      ),
    );
  }
}
