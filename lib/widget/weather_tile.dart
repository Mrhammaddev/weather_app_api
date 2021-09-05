import 'package:flutter/material.dart';

class WeatherTile extends StatelessWidget {
  final IconData icn;
  final String title;
  final String subtitle;

  const WeatherTile(
      {Key key,
      @required this.icn,
      @required this.subtitle,
      @required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icn,
            color: Colors.purple,
          )
        ],
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xff9e9e9e)),
      ),
    );
  }
}
