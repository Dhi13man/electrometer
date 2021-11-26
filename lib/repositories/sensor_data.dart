import 'package:electrometer/models/sensor_data_models/sensor_data.dart';
import 'package:electrometer/repositories/base_firestore.dart';

/// Repository for easily accessing the Sensor data from Firestore.
class SensorDataRepository extends BaseFirestoreDataRepositoy {
  SensorDataRepository() : super('sensor_data');

  /// Get the entire sensor data model for a [deviceID] from Firestore.
  ///
  /// Returns a [Future] that resolves to the latest sensor data.
  Future<SensorDataModel> getSensorData({required String deviceID}) async {
    final Map<String, dynamic> data = await readDocument(deviceID);
    return SensorDataModel.fromJson(data);
  }

  /// Watch for changes to the sensor data for a [deviceID] from Firestore.
  ///
  /// Returns a [Stream] that emits the latest sensor data.
  Stream<SensorDataModel> watchSensorData({required String deviceID}) {
    return watchDocument(deviceID)
        .map((Map<String, dynamic> data) => SensorDataModel.fromJson(data));
  }
}
