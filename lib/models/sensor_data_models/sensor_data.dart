import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sensor_data.g.dart';

/// Data Model for the Sensor Data and history recorded by the IoT Devices,
/// fetched from the cloud backend.
@JsonSerializable()
class SensorDataModel extends Equatable {
  /// Creates a new instance of the [SensorDataModel] class.
  ///
  /// - [aggregatePower]: The aggregate power recorded so far.
  /// - [deviceID]: The ID associated with the IoT device.
  /// - [history]: History of the sensor data recorded over time.
  /// - [latestCurrent]: The last recorded current by this particular sensor.
  /// - [latestVoltage]: The last recorded voltage by this particular sensor.
  const SensorDataModel({
    required this.aggregatePower,
    required this.deviceID,
    required this.history,
    required this.latestCurrent,
    required this.latestVoltage,
  });

  /// Connect the generated [_$SensorDataModelFromJson] function to the `fromJson`
  /// factory.
  factory SensorDataModel.fromJson(Map<String, dynamic> json) =>
      _$SensorDataModelFromJson(json);

  /// The [String] ID associated with the IoT device.
  final String deviceID;

  /// The [double] aggregate power recorded so far.
  final double aggregatePower;

  /// A [Map] of [SensorDataEntry] objects which represents the history of the
  /// sensor data recorded over time.
  ///
  /// The keys of the [Map] are the [String] ISO8601 Timestamps of the recording
  /// and the values are the [SensorDataEntry] objects having the recorded values.
  final Map<String, SensorDataEntry> history;

  /// The [double] last recorded current by this particular sensor.
  final double latestCurrent;

  /// The [double] last recorded voltage by this particular sensor.
  final double latestVoltage;

  @override
  List<Object> get props => <Object>[
        deviceID,
        aggregatePower,
        history,
        latestCurrent,
        latestVoltage,
      ];

  /// Connect the generated [_$SensorDataModelToJson] function to the `toJson`
  ///  method.
  Map<String, dynamic> toJson() => _$SensorDataModelToJson(this);
}

/// Data Model representing an entry of Sensor Data history.
@JsonSerializable()
class SensorDataEntry extends Equatable {
  /// Creates a new instance of the [SensorDataEntry] class.
  ///
  /// - [power]: The power recorded at the time of the entry.
  /// - [voltage]: The voltage recorded at the time of the entry.
  /// - [current]: The current recorded at the time of the entry.
  const SensorDataEntry({
    required this.current,
    required this.power,
    required this.voltage,
  });

  /// Connect the generated [_$SensorDataEntryFromJson] function to the `fromJson`
  /// factory.
  factory SensorDataEntry.fromJson(Map<String, dynamic> json) =>
      _$SensorDataEntryFromJson(json);

  /// The [double] current recorded by the sensor.
  final double current;

  /// The [double] power recorded by the sensor.
  final double power;

  /// The [double] voltage recorded by the sensor.
  final double voltage;

  @override
  List<Object> get props => <Object>[current, power, voltage];

  /// Connect the generated [_$SensorDataEntryToJson] function to the `toJson`
  ///  method.
  Map<String, dynamic> toJson() => _$SensorDataEntryToJson(this);
}
