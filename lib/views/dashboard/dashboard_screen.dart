import 'package:electrometer/bloc/sensor_data/sensor_data_bloc.dart';
import 'package:electrometer/views/dashboard/pages/dashboard_logs.dart';
import 'package:electrometer/views/dashboard/pages/dashboard_statistics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The dashboard screen.
///
/// Uses application's [SensorDataBloc] to manage the state of the screen.
class DashboardScreen extends StatelessWidget {
  /// Creates a [DashboardScreen] instance.
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SensorDataBloc>(
      create: (_) => SensorDataBloc()
        ..add(const SensorDataFetchEvent(sensorID: 'QB5ckYt0CS7Yc7swMKPu')),
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
  /// The PageView Controller used to manage the pages based on Bottom Navigation
  /// Bar.
  late final PageController _pageController;

  /// The [int] index of the screen selected using Bottom Navigation Bar.
  late int _selectedScreenIndex;

  @override
  void initState() {
    super.initState();
    _selectedScreenIndex = 0;
    _pageController = PageController(initialPage: _selectedScreenIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('House 8A Electric Meter Data')),
      body: PageView(
        controller: _pageController,
        onPageChanged: (int index) =>
            setState(() => _selectedScreenIndex = index),
        children: const <Widget>[
          DashboardStatistics(),
          DashboardLogs(),
        ],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: BottomNavigationBar(
          currentIndex: _selectedScreenIndex,
          onTap: (int selected) => _pageController.animateToPage(
            selected,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOutQuart,
          ),
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
