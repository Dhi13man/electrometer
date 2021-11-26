import 'package:electrometer/models/sensor_data_models/sensor_data.dart';
import 'package:electrometer/repositories/sensor_data.dart';
import 'package:electrometer/views/dashboard/elements/data_circle.dart';
import 'package:electrometer/views/dashboard/elements/data_rrect_card.dart';
import 'package:electrometer/views/dashboard/elements/power_chart.dart';
import 'package:flutter/material.dart';

class DashboardStatistics extends StatelessWidget {
  const DashboardStatistics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        const DashboardPowerChart(),
        const DataRRectCard(title: '7.5673 KWH', subtitle: 'Power'),
        StreamBuilder<SensorDataModel>(
            stream: SensorDataRepository()
                .watchSensorData(deviceID: 'QB5ckYt0CS7Yc7swMKPu'),
            builder: (BuildContext context,
                AsyncSnapshot<SensorDataModel> snapshot) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  DataCircle(
                    title: '${snapshot.data?.latestCurrent}A',
                    subtitle: 'Current',
                  ),
                  DataCircle(
                    title: '${snapshot.data?.latestVoltage}V',
                    subtitle: 'Voltage',
                  ),
                ],
              );
            }),
      ],
    );
  }
}
