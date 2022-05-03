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

  /// A [List] of [SensorDataEntry] objects which represents the history of the
  /// sensor data recorded over time.
  final List<SensorDataEntry> history;

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
  /// - [timestamp]: The ISO8601 String timestamp of when entry taken by device.
  /// - [current]: The current recorded at the time of the entry.
  const SensorDataEntry({
    required this.current,
    required this.power,
    required this.timestamp,
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

  /// The ISO8601 [String] timestamp when the reading was taken.
  final String timestamp;

  /// The [double] voltage recorded by the sensor.
  final double voltage;

  /// Extract date time string from the timestamp of the sensor data
  ///
  /// Converts it to a string as DD-MM-YY hh:mm.
  String get dateTimeString {
    final DateTime dt = (DateTime.tryParse(timestamp) ?? DateTime.now());
    final String day = dt.day < 10 ? '0${dt.day}' : dt.day.toString();
    final String month = dt.month < 10 ? '0${dt.month}' : dt.month.toString();
    final String year = dt.year.toString().substring(2);
    final String hour = dt.hour < 10 ? '0${dt.hour}' : dt.hour.toString();
    final String minute =
        dt.minute < 10 ? '0${dt.minute}' : dt.minute.toString();
    return '$day-$month-$year $hour:$minute';
  }

  @override
  List<Object> get props => <Object>[current, power, timestamp, voltage];

  /// Connect the generated [_$SensorDataEntryToJson] function to the `toJson`
  ///  method.
  Map<String, dynamic> toJson() => _$SensorDataEntryToJson(this);
}
