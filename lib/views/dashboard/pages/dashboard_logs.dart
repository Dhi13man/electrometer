import 'package:electrometer/bloc/sensor_data/sensor_data_bloc.dart';
import 'package:electrometer/models/sensor_data_models/sensor_data.dart';
import 'package:flutter/material.dart';

class DashboardLogs extends StatelessWidget {
  const DashboardLogs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SensorDataState state = context.watch<SensorDataBloc>().state;
    if (state is SensorDataLoadedState) {
      return Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListView.builder(
              itemCount: state.sensorData.history.length,
              itemBuilder: (BuildContext context, int index) {
                final SensorDataEntry entry = state.sensorData.history[index];
                final DateTime time =
                    DateTime.tryParse(entry.timestamp) ?? DateTime.now();
                final String timeString = time.toString().split('.').first;
                return Card(
                  color: Theme.of(context).colorScheme.primary,
                  child: ListTile(
                    title: Text(
                      '${entry.power.toStringAsFixed(6)} KWH consumed at $timeString',
                      textScaleFactor: 0.9,
                    ),
                    subtitle: Text('${entry.current} A, ${entry.voltage} V'),
                    leading:
                        const Icon(Icons.power, color: Colors.red, size: 30),
                    minLeadingWidth: 10,
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 5,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon:
                  const Icon(Icons.settings_applications, color: Colors.white),
              label: const Text(
                'Set Threshold',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }
}
