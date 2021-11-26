part of 'package:electrometer/bloc/sensor_data/sensor_data_bloc.dart';

/// Abstract [SensorDataEvent] for [SensorDataBloc] that all other events extend.
abstract class SensorDataEvent extends Equatable {
  const SensorDataEvent();

  @override
  List<Object> get props => <Object>[];
}

class SensorDataFetchEvent extends SensorDataEvent {
  const SensorDataFetchEvent({required this.sensorID});
  final String sensorID;

  @override
  List<Object> get props => <Object>[sensorID];
}
