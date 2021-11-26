// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sensor_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SensorDataModel _$SensorDataModelFromJson(Map<String, dynamic> json) =>
    SensorDataModel(
      aggregatePower: (json['aggregatePower'] as num).toDouble(),
      deviceID: json['deviceID'] as String,
      history: (json['history'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, SensorDataEntry.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$SensorDataModelToJson(SensorDataModel instance) =>
    <String, dynamic>{
      'deviceID': instance.deviceID,
      'aggregatePower': instance.aggregatePower,
      'history': instance.history,
    };

SensorDataEntry _$SensorDataEntryFromJson(Map<String, dynamic> json) =>
    SensorDataEntry(
      current: (json['current'] as num).toDouble(),
      power: (json['power'] as num).toDouble(),
      voltage: (json['voltage'] as num).toDouble(),
    );

Map<String, dynamic> _$SensorDataEntryToJson(SensorDataEntry instance) =>
    <String, dynamic>{
      'current': instance.current,
      'power': instance.power,
      'voltage': instance.voltage,
    };