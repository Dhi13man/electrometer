import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersistentSettingsRepository extends ChangeNotifier {
  PersistentSettingsRepository() {
    _initStorage();
  }

  /// The key identifying the location of memory where the current threshold is saved.
  static const String currentThresholdKey = 'current_threshold';

  /// The key identifying the location of memory where the power threshold is saved.
  static const String powerThresholdKey = 'power_threshold';

  /// The key identifying the location of memory where the voltage threshold is saved.
  static const String voltageThresholdKey = 'voltage_threshold';

  /// Instance of Shared preferences used by the repository.
  late final SharedPreferences _prefs;

  /// Whether the storage is ready or not
  bool isStorageReady = false;

  /// Read a [double] item from Shared Preferences.
  ///
  /// Returns the value of the item if it exists, otherwise returns null.
  double? readDouble(String key) =>
      isStorageReady ? _prefs.getDouble(key) : null;

  /// Read current threshold from Shared Preferences.
  ///
  /// Returns the value of the item if it exists, otherwise returns null.
  double? get currentThresholdSetting => readDouble(currentThresholdKey);

  /// Read power threshold from Shared Preferences.
  ///
  /// Returns the value of the item if it exists, otherwise returns null.
  double? get powerThresholdSetting => readDouble(powerThresholdKey);

  /// Read voltage threshold from Shared Preferences.
  ///
  /// Returns the value of the item if it exists, otherwise returns null.
  double? get voltageThresholdSetting => readDouble(voltageThresholdKey);

  /// Write a double item to Shared Preferences.
  ///
  /// Returns true if the item was successfully written, otherwise returns false.
  Future<bool> writeDouble(String key, double value) async {
    final bool result = await _prefs.setDouble(key, value);
    notifyListeners();
    return result;
  }

  /// Write current threshold to Shared Preferences.
  ///
  /// Returns true if the item was successfully written, otherwise returns false.
  Future<bool> setCurrentThresholdSetting(double value) =>
      writeDouble(currentThresholdKey, value);

  /// Write power threshold to Shared Preferences.
  ///
  /// Returns true if the item was successfully written, otherwise returns false.
  Future<bool> setPowerThresholdSetting(double value) =>
      writeDouble(powerThresholdKey, value);

  /// Write voltage threshold to Shared Preferences.
  ///
  /// Returns true if the item was successfully written, otherwise returns false.
  Future<bool> setVoltageThresholdSetting(double value) =>
      writeDouble(voltageThresholdKey, value);

  /// Initialize the Storage structure.
  Future<void> _initStorage() async {
    _prefs = await SharedPreferences.getInstance();
    isStorageReady = true;
    notifyListeners();
  }
}
