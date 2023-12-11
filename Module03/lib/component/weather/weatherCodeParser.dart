import 'package:flutter/material.dart';

class WeatherCode {
  late Map weatherCode;
   WeatherCode() {
     weatherCode = {
      '0':  {'text':"Clear sky", 'icon':Icons.sunny},
      '1': {'text':"Mainly clear", 'icon':Icons.sunny},
      '2': {'text':"partly cloudy", 'icon':Icons.cloud_outlined},
      '3': {'text':"overcast", 'icon':Icons.cloud},
      '45': {'text':"Fog", 'icon':Icons.foggy},
      '48': {'text':"depositing rime fog", 'icon':Icons.foggy},
      '51': {'text':"Drizzle: Light", 'icon':Icons.bubble_chart_outlined},
      '53': {'text':"Drizzle: moderate", 'icon':Icons.bubble_chart},
      '55': {'text':"Drizzle: dense intensity", 'icon':Icons.bubble_chart},
      '56': {'text':"Freezing Drizzle:Light ", 'icon':Icons.bubble_chart},
      '57': {'text':"Freezing Drizzle: dense intensity", 'icon':Icons.bubble_chart},
      '61': {'text':"Rain: Slight", 'icon':Icons.water_drop_outlined},
      '63': {'text':"Rain: moderate", 'icon':Icons.water_drop_outlined},
      '65': {'text':"Rain: heavy intensity", 'icon':Icons.water_drop_outlined},
      '66': {'text':"Freezing Rain: Light", 'icon':Icons.water_drop_outlined},
      '67': {'text':"Freezing Rain:  heavy intensity", 'icon':Icons.water_drop_outlined},
      '71': {'text':"Snow fall: Slight", 'icon':Icons.cloudy_snowing},
      '73': {'text':"Snow fall: moderate", 'icon':Icons.cloudy_snowing},
      '75': {'text':"Snow fall: heavy intensity", 'icon':Icons.cloudy_snowing},
      '77': {'text':"Snow grains", 'icon':Icons.cloudy_snowing},
      '80': {'text':"Rain showers: slight", 'icon':Icons.water_drop_outlined},
      '81': {'text':"{Rain showers: moderate", 'icon':Icons.water_drop_outlined},
      '82': {'text':"Rain showers: violent", 'icon':Icons.thunderstorm},
      '85': {'text':"Snow showers slight", 'icon':Icons.cloudy_snowing},
      '86': {'text':"Snow showers heavy", 'icon':Icons.cloudy_snowing},
      '95': {'text':"Thunderstorm: Slight or moderate", 'icon':Icons.thunderstorm},
      '96': {'text':"Thunderstorm with slight hail", 'icon':Icons.thunderstorm},
      '99': {'text':"Thunderstorm with heavy hail", 'icon':Icons.thunderstorm},
    };
  }
}


