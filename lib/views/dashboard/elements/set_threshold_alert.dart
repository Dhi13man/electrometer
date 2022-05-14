import 'package:electrometer/repositories/peristent_settings.dart';
import 'package:flutter/material.dart';

/// Sets the threshold for current, power, voltage consumption.
///
/// User will be warned if threshold is exceeded
class SetThresholdsAlert extends StatefulWidget {
  /// Creates a new instance of the [SetThresholdsAlert] class.
  const SetThresholdsAlert({required this.persistentRepository, Key? key})
      : super(key: key);

  /// Repository to read and write storage across local storage.
  final PersistentSettingsRepository persistentRepository;

  @override
  State<SetThresholdsAlert> createState() => _SetThresholdsAlertState();
}

class _SetThresholdsAlertState extends State<SetThresholdsAlert> {
  /// The [TextEditingController] for the current threshold.
  late final TextEditingController currentThresholdController;

  /// The [TextEditingController] for the power threshold.
  late final TextEditingController powerThresholdController;

  /// The [TextEditingController] for the voltage threshold.
  late final TextEditingController voltageThresholdController;

  @override
  void initState() {
    super.initState();
    // Set up text controllers
    currentThresholdController = TextEditingController.fromValue(
      TextEditingValue(
        text: widget.persistentRepository.currentThresholdSetting?.toString() ??
            '',
      ),
    );
    powerThresholdController = TextEditingController.fromValue(
      TextEditingValue(
        text:
            widget.persistentRepository.powerThresholdSetting?.toString() ?? '',
      ),
    );
    voltageThresholdController = TextEditingController.fromValue(
      TextEditingValue(
        text: widget.persistentRepository.voltageThresholdSetting?.toString() ??
            '',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Set Thresholds'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text('Set the thresholds for the following values:'),
          DoubleTextField(
            label: 'Current',
            textController: currentThresholdController,
          ),
          const SizedBox(height: 8),
          DoubleTextField(
            label: 'Power ',
            textController: powerThresholdController,
          ),
          const SizedBox(height: 8),
          DoubleTextField(
            label: 'Voltage',
            textController: voltageThresholdController,
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Set'),
          onPressed: () {
            final double? currentThreshold =
                double.tryParse(currentThresholdController.text);
            final double? powerThreshold =
                double.tryParse(powerThresholdController.text);
            final double? voltageThreshold =
                double.tryParse(voltageThresholdController.text);
            if (currentThreshold != null &&
                powerThreshold != null &&
                voltageThreshold != null) {
              widget.persistentRepository
                  .setCurrentThresholdSetting(currentThreshold);
              widget.persistentRepository
                  .setPowerThresholdSetting(powerThreshold);
              widget.persistentRepository
                  .setVoltageThresholdSetting(voltageThreshold);
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}

class DoubleTextField extends StatelessWidget {
  const DoubleTextField({
    Key? key,
    required this.label,
    required this.textController,
  }) : super(key: key);

  final String label;

  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(label),
        const SizedBox(width: 20),
        Expanded(
          child: TextFormField(
            controller: textController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: '0.0',
            ),
            validator: (String? text) {
              if (text == null || text.isEmpty) {
                return 'Please enter a value';
              }
              final double? value = double.tryParse(text);
              if (value == null) {
                return 'Please enter a valid number';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
