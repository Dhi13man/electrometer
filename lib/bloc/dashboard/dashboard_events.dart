part of 'package:electrometer/bloc/dashboard/dashboard_bloc.dart';

/// Abstract [DashboardEvent] for [DashboardBloc] that all other events extend.
abstract class DashboardEvent extends Equatable {
  @override
  List<Object> get props => <Object>[];
}
