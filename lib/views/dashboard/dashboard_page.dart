import 'package:electrometer/bloc/dashboard/dashboard_bloc.dart';
import 'package:electrometer/l10n/l10n.dart';
import 'package:electrometer/views/dashboard/elements/power_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The dashboard screen.
///
/// Uses application's [DashboardBloc] to manage the state of the screen.
class DashboardPage extends StatelessWidget {
  /// Creates a [DashboardPage] instance.
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DashboardBloc>(
      create: (_) => DashboardBloc(),
      child: const DashboardView(),
    );
  }
}

/// The view in the dashboard screen.
///
/// Contains all the relevant widgets to display in the dashboard.
class DashboardView extends StatelessWidget {
  /// Creates a [DashboardView] instance.
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.counterAppBarTitle)),
      body: const Center(child: DashboardPowerChart()),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () => context.read<DashboardBloc>().increment(),
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            onPressed: () => context.read<DashboardBloc>().decrement(),
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}

class CounterText extends StatelessWidget {
  const CounterText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final int count = context.select((DashboardBloc cubit) => cubit.state);
    return Text('$count', style: theme.textTheme.headline1);
  }
}
