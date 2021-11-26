import 'package:flutter/material.dart';

/// Shows a DataCircle with a title and a subtitle.
///
/// For Dashboard screen.
class DataCircle extends StatelessWidget {
  /// Creates a [DataCircle] with a title and a subtitle.
  const DataCircle({required String title, required String subtitle, Key? key})
      : _title = title,
        _subtitle = subtitle,
        super(key: key);

  /// The [String] title of the DataCircle.
  final String _title;

  /// The [String] subtitle of the DataCircle.
  final String _subtitle;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.colorScheme.primaryVariant,
          width: 0.5,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: const Offset(0, 2),
            color: theme.colorScheme.primaryVariant,
            blurRadius: 4,
          ),
        ],
        color: theme.backgroundColor,
        shape: BoxShape.circle,
      ),
      padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            _title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.secondary,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            _subtitle,
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
