import 'package:electrometer/bloc/sensor_data/sensor_data_bloc.dart';
import 'package:electrometer/models/sensor_data_models/sensor_data.dart';
import 'package:electrometer/views/dashboard/elements/data_circle.dart';
import 'package:electrometer/views/dashboard/elements/data_rrect_card.dart';
import 'package:electrometer/views/dashboard/elements/line_chart.dart';
import 'package:flutter/material.dart';

class DashboardStatistics extends StatelessWidget {
  const DashboardStatistics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SensorDataBloc bloc = context.watch<SensorDataBloc>();
    if (bloc.state is SensorDataLoadedState) {
      final SensorDataLoadedState state = bloc.state as SensorDataLoadedState;
      final SensorDataModel sensorData = state.sensorData;
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          const DashboardPowerChart(),
          DataRRectCard(
            title: '${sensorData.aggregatePower} KWH',
            subtitle: 'Power',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              DataCircle(
                title: '${sensorData.latestCurrent} A',
                subtitle: 'Current',
              ),
              DataCircle(
                title: '${sensorData.latestVoltage} V',
                subtitle: 'Voltage',
              ),
            ],
          ),
        ],
      );
    } else if (bloc.state is SensorDataErrorState) {
      return const Center(child: Text('Error'));
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }
}
