import 'package:electrometer/bloc/sensor_data/sensor_data_bloc.dart';
import 'package:electrometer/models/sensor_data_models/sensor_data.dart';
import 'package:electrometer/repositories/peristent_settings.dart';
import 'package:electrometer/views/dashboard/elements/set_threshold_alert.dart';
import 'package:flutter/material.dart';

class DashboardLogs extends StatefulWidget {
  const DashboardLogs({Key? key}) : super(key: key);

  @override
  State<DashboardLogs> createState() => _DashboardLogsState();
}

class _DashboardLogsState extends State<DashboardLogs> {
  /// Repository to read and write storage across local storage.
  late final PersistentSettingsRepository persistentRepository;

  @override
  void initState() {
    super.initState();
    persistentRepository = PersistentSettingsRepository();
    persistentRepository.addListener(() => setState(() {}));
  }

  Color _logColor(SensorDataEntry entry) {
    final double currentThreshold =
        persistentRepository.currentThresholdSetting ?? 0.0;
    final double powerThreshold =
        persistentRepository.powerThresholdSetting ?? 0.0;
    final double voltageThreshold =
        persistentRepository.voltageThresholdSetting ?? 0.0;
    final bool noThresholdExceeded = currentThreshold > entry.current &&
        powerThreshold > entry.power &&
        voltageThreshold > entry.voltage;
    return noThresholdExceeded ? Colors.green : Colors.red;
  }

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
                  child: ListTile(
                    title: Text(
                      '${entry.power.toStringAsFixed(6)} KWH consumed at $timeString',
                      textScaleFactor: 0.9,
                    ),
                    subtitle: Text(
                      '${entry.current} A, ${entry.voltage} V',
                    ),
                    leading:
                        Icon(Icons.power, color: _logColor(entry), size: 30),
                    minLeadingWidth: 10,
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 5,
            child: ElevatedButton.icon(
              onPressed: () => showDialog(
                context: context,
                builder: (BuildContext context) => SetThresholdsAlert(
                  persistentRepository: persistentRepository,
                ),
              ),
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

  @override
  void dispose() {
    persistentRepository.dispose();
    super.dispose();
  }
}
