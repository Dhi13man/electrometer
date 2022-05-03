// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:bloc_test/bloc_test.dart';
import 'package:electrometer/bloc/sensor_data/sensor_data_bloc.dart';
import 'package:electrometer/views/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

class MockCounterCubit extends MockCubit<SensorDataState>
    implements SensorDataBloc {}

void main() {
  group('CounterPage', () {
    testWidgets('renders CounterView', (WidgetTester tester) async {
      await tester.pumpApp(const DashboardScreen());
      expect(find.byType(DashboardView), findsOneWidget);
    });
  });

  group('CounterView', () {
    late SensorDataBloc counterCubit;

    setUp(() {
      counterCubit = MockCounterCubit();
    });

    testWidgets('renders current count', (WidgetTester tester) async {
      const SensorDataState state = SensorDataUninitializedState();
      when(() => counterCubit.state).thenReturn(state);
      await tester.pumpApp(
        BlocProvider<SensorDataBloc>.value(
          value: counterCubit,
          child: const DashboardView(),
        ),
      );
      expect(find.text('$state'), findsOneWidget);
    });

    testWidgets('calls increment when increment button is tapped',
        (WidgetTester tester) async {
      when(() => counterCubit.state).thenReturn(
        const SensorDataUninitializedState(),
      );
      when(() => null).thenReturn(null);
      await tester.pumpApp(
        BlocProvider<SensorDataBloc>.value(
          value: counterCubit,
          child: const DashboardView(),
        ),
      );
      await tester.tap(find.byIcon(Icons.add));
      verify(() => null).called(1);
    });

    testWidgets('calls decrement when decrement button is tapped',
        (WidgetTester tester) async {
      when(() => counterCubit.state).thenReturn(
        const SensorDataUninitializedState(),
      );
      when(() => null).thenReturn(null);
      await tester.pumpApp(
        BlocProvider<SensorDataBloc>.value(
          value: counterCubit,
          child: const DashboardView(),
        ),
      );
      await tester.tap(find.byIcon(Icons.remove));
      verify(() => null).called(1);
    });
  });
}
