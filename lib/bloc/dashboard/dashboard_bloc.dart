import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

part 'package:electrometer/bloc/dashboard/dashboard_events.dart';
part 'package:electrometer/bloc/dashboard/dashboard_states.dart';

/// [Bloc] handling the state of the dashboard page and its various UI elements.
class DashboardBloc extends Cubit<int> {
  DashboardBloc() : super(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
}
 