import 'package:electrometer/bloc/sensor_data/sensor_data_bloc.dart';
import 'package:electrometer/models/sensor_data_models/sensor_data.dart';
import 'package:electrometer/views/dashboard/elements/dashboard_chart/line_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// Shows a chart for the real time power usage readings as a line chart.
class DashboardDataChart extends StatelessWidget {
  /// Creates a new instance of the [DashboardDataChart] class.
  const DashboardDataChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SensorDataState sensorDataState =
        context.watch<SensorDataBloc>().state;
    // Build the chart if the data is available.
    if (sensorDataState is SensorDataErrorState) {
      return const Center(child: Text('Error loading data'));
    } else if (sensorDataState is SensorDataLoadedState) {
      final List<String> timestamps = sensorDataState.sensorData.history
          .map<String>((SensorDataEntry e) => e.dateTimeString)
          .toList();
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: LineChartImplementation(
          chartData: _makeChartDataMap(sensorDataState.sensorData.history),
          xLabels: timestamps,
        ),
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  /// Return a map with the keys as the type of values to show in Line chart
  /// and values as the [List] of [FlSpot]s that the chart needs to show.
  Map<String, List<FlSpot>> _makeChartDataMap(List<SensorDataEntry> history) {
    // Prepare Data for chart
    final Map<String, List<FlSpot>> data = <String, List<FlSpot>>{
      'current': <FlSpot>[],
      'power': <FlSpot>[],
      'voltage': <FlSpot>[],
    };

    double x = 0;
    for (final SensorDataEntry dataEntry in history) {
      data['current']!.add(FlSpot(x, dataEntry.current));
      data['power']!.add(FlSpot(x, dataEntry.power));
      data['voltage']!.add(FlSpot(x, dataEntry.voltage));
      x += 1;
    }
    return data;
  }
}
