import 'package:electrometer/bloc/sensor_data/sensor_data_bloc.dart';
import 'package:electrometer/views/dashboard/screens/dashboard_logs.dart';
import 'package:electrometer/views/dashboard/screens/dashboard_statistics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The dashboard screen.
///
/// Uses application's [SensorDataBloc] to manage the state of the screen.
class DashboardPage extends StatelessWidget {
  /// Creates a [DashboardPage] instance.
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SensorDataBloc>(
      create: (_) => SensorDataBloc(),
      child: const DashboardView(),
    );
  }
}

/// The view in the dashboard screen.
///
/// Contains all the relevant widgets to display in the dashboard.
class DashboardView extends StatefulWidget {
  /// Creates a [DashboardView] instance.
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  /// The [int] index of the screen selected using Bottom Navigation Bar.
  late int _selectedScreenIndex;

  /// The [List] of [Widget]s to be displayed in the dashboard based on
  /// [_selectedScreenIndex].
  final List<Widget> _screens = <Widget>[
    const DashboardStatistics(),
    const DashboardLogs(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedScreenIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('House 8A Electric Meter Data')),
      body: _screens[_selectedScreenIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: BottomNavigationBar(
          currentIndex: _selectedScreenIndex,
          onTap: (int selected) =>
              setState(() => _selectedScreenIndex = selected),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              backgroundColor:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              icon: const Icon(Icons.timeline),
              label: 'Statistics',
            ),
            BottomNavigationBarItem(
              backgroundColor:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              icon: const Icon(Icons.history),
              label: 'Logs',
            ),
          ],
        ),
      ),
    );
  }
}
