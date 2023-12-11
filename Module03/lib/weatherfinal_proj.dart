import 'package:flutter/material.dart';
import 'package:weatherapp/component/weather/currentWeather.dart';
import './component/bottomBar.dart';
import './component/appBar.dart';
import './component/view/currently.dart';
import './component/view/today.dart';
import './component/view/weekly.dart';
import 'package:http/http.dart' as http;
import 'component/geolocation/position.dart';
import './component/futurBuilder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Future<Weather> weather = Future<Weather>.delayed(
    const Duration(seconds: 2),
    getWeather,
  );

  String localisation = "";
  Weather weatherState = Weather();

  void onWeatherChange(Weather weather) {
    setState(() {
      weatherState = weather;
    });
  }

  void onLocalisationChange(String value) {
    setState(() {
      localisation = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery
          .of(context)
          .size
          .height,
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: FutureBuilder<Weather>(
        future: weather, // a previously-obtained Future<Weather> or null
        builder: (BuildContext context, AsyncSnapshot<Weather> snapshot) {
          List<Widget> children;

          return SizedBox(
              child: Center(
              child: DefaultTabController(
              initialIndex: 0,
              length: 3,
              child: Container(
              height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
          image: DecorationImage(
          image: AssetImage("images/background.jpg"),
          fit: BoxFit.cover,
          ),
          ), child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,

          decoration: BoxDecoration(
          image: DecorationImage(
          image: const AssetImage("images/background.jpg"),
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.modulate,),
          fit: BoxFit.cover,
          ),
          ), child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBarComponent(
          onWeatherChange: onWeatherChange,
          onChanged: onLocalisationChange),
          body: (() {
          if (snapshot.connectionState ==
          ConnectionState.done &&
          snapshot.hasData) {
          if (weatherState.curWeather.location == "") {
          weatherState = snapshot.data!;
          }
          return
          TabBarView(
          children: <Widget>[
          Currently(weather: weatherState),
          Today(weather: weatherState),
          Weekly(weather: weatherState),
          ],
          );
          } else {
          return const Center(
          child: SizedBox(
          width: 60,
          height: 60,
          child: CircularProgressIndicator(),
          ));
          }
          }()),
          bottomNavigationBar: const BottomBar(),
          )
          )
          )
          )
          )
          );
        },
      ),
    );
  }
}
