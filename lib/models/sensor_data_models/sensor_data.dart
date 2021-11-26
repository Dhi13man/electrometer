import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sensor_data.g.dart';

@JsonSerializable()
class SensorDataModel extends Equatable {
  const SensorDataModel({
    required this.aggregatePower,
    required this.deviceID,
    required this.history,
  });

  /// Connect the generated [_$SensorDataModelFromJson] function to the `fromJson`
  /// factory.
  factory SensorDataModel.fromJson(Map<String, dynamic> json) =>
      _$SensorDataModelFromJson(json);

  final String deviceID;

  final double aggregatePower;

  final Map<String, SensorDataEntry> history;

  @override
  List<Object> get props => <Object>[deviceID, aggregatePower, history];

  /// Connect the generated [_$SensorDataModelToJson] function to the `toJson`
  ///  method.
  Map<String, dynamic> toJson() => _$SensorDataModelToJson(this);
}

@JsonSerializable()
class SensorDataEntry extends Equatable {
  const SensorDataEntry({
    required this.current,
    required this.power,
    required this.voltage,
  });

  /// Connect the generated [_$SensorDataEntryFromJson] function to the `fromJson`
  /// factory.
  factory SensorDataEntry.fromJson(Map<String, dynamic> json) =>
      _$SensorDataEntryFromJson(json);

  final double current;

  final double power;

  final double voltage;

  @override
  List<Object> get props => <Object>[current, power, voltage];

  /// Connect the generated [_$SensorDataEntryToJson] function to the `toJson`
  ///  method.
  Map<String, dynamic> toJson() => _$SensorDataEntryToJson(this);
}
