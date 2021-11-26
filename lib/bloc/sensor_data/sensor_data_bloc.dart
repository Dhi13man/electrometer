import 'package:electrometer/models/sensor_data_models/sensor_data.dart';
import 'package:electrometer/repositories/sensor_data.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

part 'package:electrometer/bloc/sensor_data/sensor_data_events.dart';
part 'package:electrometer/bloc/sensor_data/sensor_data_states.dart';

/// [Bloc] handling the state of the dashboard page and its various UI elements.
class SensorDataBloc extends Bloc<SensorDataEvent, SensorDataState> {
  SensorDataBloc({SensorDataRepository? repository})
      : _repository = repository ?? SensorDataRepository(),
        super(const SensorDataUninitializedState()) {
    on<SensorDataFetchEvent>(
      (SensorDataFetchEvent event, Emitter<SensorDataState> emit) async {
        emit(const SensorDataLoadingState());
        await emit.onEach<SensorDataModel>(
          _repository.watchSensorData(deviceID: event.sensorID),
          onData: (SensorDataModel data) =>
              emit(SensorDataLoadedState(sensorData: data)),
          onError: (dynamic error, StackTrace stackTrace) => emit(
            SensorDataErrorState(error: error, stackTrace: stackTrace),
          ),
        );
      },
    );
  }

  final SensorDataRepository _repository;
}
