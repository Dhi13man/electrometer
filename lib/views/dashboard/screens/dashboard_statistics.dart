import 'package:electrometer/bloc/sensor_data/sensor_data_bloc.dart';
import 'package:electrometer/models/sensor_data_models/sensor_data.dart';
import 'package:electrometer/views/dashboard/elements/dashboard_chart/dashboard_chart.dart';
import 'package:electrometer/views/dashboard/elements/data_rectangle.dart';
import 'package:electrometer/views/dashboard/elements/data_rrect_card.dart';
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
          const DashboardDataChart(),
          Column(
            children: <Widget>[
              DataRRectCard(
                title: '${sensorData.aggregatePower.toStringAsFixed(6)} KWH',
                subtitle: 'Power',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DataRectangle(
                    title: '${sensorData.latestCurrent.toStringAsFixed(3)} A',
                    subtitle: 'Current',
                  ),
                  DataRectangle(
                    title: '${sensorData.latestVoltage.toStringAsFixed(1)} V',
                    subtitle: 'Voltage',
                  ),
                ],
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
