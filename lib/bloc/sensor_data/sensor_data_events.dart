part of 'package:electrometer/bloc/sensor_data/sensor_data_bloc.dart';

/// Abstract [SensorDataEvent] for [SensorDataBloc] that all other events extend.
abstract class SensorDataEvent extends Equatable {
  @override
  List<Object> get props => <Object>[];
}
