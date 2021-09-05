// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_php/models/weather.dart';
// import 'package:http/http.dart' as http;

// class CurrentWeatherPage extends StatefulWidget {
//   const CurrentWeatherPage({Key key}) : super(key: key);

//   @override
//   _CurrentWeatherPageState createState() => _CurrentWeatherPageState();
// }

// class _CurrentWeatherPageState extends State<CurrentWeatherPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[300],
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         title: Text(
//           "Weather API",
//           style: TextStyle(color: Colors.black),
//         ),
//       ),
//       body: Center(
//         child: FutureBuilder(
//           builder: (context, snapshot) {
//             if (snapshot != null) {
//               Weather _weather = snapshot.data;
//               if (_weather == null) {
//                 return Text("Error");
//               } else {
//                 return weatherBox(_weather);
//               }
//             } else {
//               return CircularProgressIndicator();
//             }
//           },
//           future: getCurrentWeather(),
//         ),
//       ),
//     );
//   }

//   Widget weatherBox(Weather _weather) {
//     return Column(children: <Widget>[
//       Text("${_weather.temp}°C"),
//       Text("${_weather.description}"),
//       Text("Feels:${_weather.feelsLike}°C"),
//       Text("H:${_weather.high}°C L:${_weather.low}°C"),
//     ]);
//   }

//   Future getCurrentWeather() async {
//     Weather weather;
//     String zipCode = "53400";
//     String city = "lahore";
//     String apiKey = "0bbdf66ee202eaf5e2e05fba6b5e5e59";
//     var url =
//         "https://api.openweathermap.org/data/2.5/weather?q=${city},${zipCode}&appid=${apiKey}";

//     final response = await http.get(Uri.parse(url));

//     if (response.statusCode == 200) {
//       weather = Weather.fromJson(jsonDecode(response.body));
//     } else {
//
//     }
//     print(response.body);
//     return weather;
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app_api/widget/main_widget.dart';
// import 'dart:convert';

Future<WeatherInfo> fetchWeather() async {
  final zipCode = "53400";
  final city = "lahore";
  final apiKey = "0bbdf66ee202eaf5e2e05fba6b5e5e59";
  final requestUrl =
      "https://api.openweathermap.org/data/2.5/weather?q=$city,$zipCode&appid=$apiKey";

  final response = await http.get(Uri.parse(requestUrl));
  if (response.statusCode == 200) {
    return WeatherInfo.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Error loading ");
  }
}

class WeatherInfo {
  final String location;
  final double temp;
  final double tempMin;
  final double tempMax;
  final String weather;
  final int humidity;
  final double windSpeed;

  WeatherInfo({
    this.humidity = 0,
    this.location = "",
    this.temp = 0.0,
    this.tempMax = 0.0,
    this.tempMin = 0.0,
    this.weather = "",
    this.windSpeed = 0.0,
  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
        location: json['name'],
        temp: json['main']['temp'],
        tempMin: json['main']['temp_min'],
        tempMax: json['main']['temp_max'],
        weather: json['weather'][0]['description'],
        humidity: json['main']['humidity'],
        windSpeed: json['wind']['speed']);
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<WeatherInfo> futureWeather;

  @override
  void initState() {
    super.initState();
    futureWeather = fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Weather API",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: FutureBuilder<WeatherInfo>(
          future: futureWeather,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return MainWidget(
                location: snapshot.data!.location,
                temp: snapshot.data!.temp,
                tempMax: snapshot.data!.tempMax,
                tempMin: snapshot.data!.tempMin,
                weather: snapshot.data!.weather,
                humidity: snapshot.data!.humidity,
                windSpeed: snapshot.data!.windSpeed,
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.error}"),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
