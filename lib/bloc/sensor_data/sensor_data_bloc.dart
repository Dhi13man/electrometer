import 'package:electrometer/models/sensor_data_models/sensor_data.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

part 'package:electrometer/bloc/sensor_data/sensor_data_events.dart';
part 'package:electrometer/bloc/sensor_data/sensor_data_states.dart';

/// [Bloc] handling the state of the dashboard page and its various UI elements.
class SensorDataBloc extends Bloc<SensorDataEvent, SensorDataState> {
  SensorDataBloc() : super(const SensorDataUninitializedState());
}
