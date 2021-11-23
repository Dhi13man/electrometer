import 'package:electrometer/views/dashboard/elements/data_circle.dart';
import 'package:electrometer/views/dashboard/elements/data_rrect_card.dart';
import 'package:electrometer/views/dashboard/elements/power_chart.dart';
import 'package:flutter/material.dart';

class DashboardLogs extends StatelessWidget {
  const DashboardLogs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        const DashboardPowerChart(),
        const DataRRectCard(title: '7.5673 KWH', subtitle: 'Power'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const <Widget>[
            DataCircle(title: '0.002A', subtitle: 'Current'),
            DataCircle(title: '248.3V', subtitle: 'Voltage'),
          ],
        ),
      ],
    );
  }
}
