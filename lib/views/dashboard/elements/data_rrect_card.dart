import 'package:flutter/material.dart';

/// Shows a Data Rounded Rectangle card with a title and a subtitle.
///
/// For Dashboard screen.
class DataRRectCard extends StatelessWidget {
  /// Creates a [DataRRectCard] with a title and a subtitle.
  const DataRRectCard(
      {required String title, required String subtitle, Key? key})
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
    return Card(
      color: theme.colorScheme.primaryContainer,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        child: Column(
          children: <Widget>[
            Text(
              _title,
              style: const TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _subtitle,
              style: TextStyle(
                color: theme.colorScheme.secondary,
                fontFamily: 'Segoe UI',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
