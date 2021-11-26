part of 'package:electrometer/bloc/sensor_data/sensor_data_bloc.dart';

/// Abstract [SensorDataState] for [SensorDataBloc] that all other states extend.
abstract class SensorDataState extends Equatable {
  const SensorDataState();

  @override
  List<Object> get props => <Object>[];
}

class SensorDataUninitializedState extends SensorDataState {
  const SensorDataUninitializedState();
}

class SensorDataLoadingState extends SensorDataState {
  const SensorDataLoadingState({this.isLoading=true});
  final bool isLoading;

  @override
  List<Object> get props => <Object>[isLoading];
}

class SensorDataLoadedState extends SensorDataState {
  const SensorDataLoadedState({required this.sensorData});
  final SensorDataModel sensorData;

  @override
  List<Object> get props => <Object>[sensorData];
}
