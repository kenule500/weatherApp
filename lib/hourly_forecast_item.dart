import 'package:flutter/material.dart';

class HourlyForecastItem extends StatelessWidget {
  final String time;
  final IconData icon;
  final String temperature;

  const HourlyForecastItem(
      {super.key,
      required this.time,
      required this.icon,
      required this.temperature});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Card(
        elevation: 6,
        child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            spacing: 8,
            children: [
              Text(time,
                  maxLines: 1,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              Icon(icon, size: 32),
              Text(temperature, style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
