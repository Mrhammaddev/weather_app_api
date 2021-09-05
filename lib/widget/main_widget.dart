import 'package:flutter/material.dart';
import 'package:weather_app_api/widget/weather_tile.dart';

class MainWidget extends StatelessWidget {
  final String location;
  final double temp;
  final double tempMin;
  final double tempMax;
  final String weather;
  final int humidity;
  final double windSpeed;
  const MainWidget({
    Key? key,
    this.humidity = 0,
    this.location = "",
    this.temp = 0.0,
    this.tempMax = 0.0,
    this.tempMin = 0.0,
    this.weather = "",
    this.windSpeed = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.width,
          color: Color(0xfff1f1f1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${location.toString()}",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  "${temp.toInt().toString()}°",
                  style: TextStyle(
                      color: Colors.purple,
                      fontSize: 40,
                      fontWeight: FontWeight.w900),
                ),
              ),
              Text(
                "High of ${tempMax.toInt().toString()}°, Low of ${tempMin.toInt().toString()}°",
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff9e9e9e)),
              )
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: ListView(
              children: [
                WeatherTile(
                    icn: Icons.thermostat_outlined,
                    subtitle: "${temp.toInt().toString()}°",
                    title: "Temperature"),
                WeatherTile(
                    icn: Icons.filter_drama_outlined,
                    subtitle: "${weather.toString()}",
                    title: "Weather"),
                WeatherTile(
                    icn: Icons.wb_sunny,
                    subtitle: "${humidity.toString()}%",
                    title: "Humidity"),
                WeatherTile(
                    icn: Icons.waves_outlined,
                    subtitle: "${windSpeed.toInt().toString()} MPH",
                    title: "Wind Speed"),
              ],
            ),
          ),
        )
      ],
    );
  }
}
