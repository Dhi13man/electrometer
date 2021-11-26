// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:bloc_test/bloc_test.dart';
import 'package:electrometer/bloc/sensor_data/sensor_data_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CounterCubit', () {
    test('initial state is 0', () {
      expect(SensorDataBloc().state, equals(0));
    });

    blocTest<SensorDataBloc, SensorDataState>(
      'emits [1] when increment is called',
      build: () => SensorDataBloc(),
      act: (SensorDataBloc cubit) => null,
      expect: () => <Matcher>[equals(1)],
    );

    blocTest<SensorDataBloc, SensorDataState>(
      'emits [-1] when decrement is called',
      build: () => SensorDataBloc(),
      act: (SensorDataBloc cubit) => null,
      expect: () => <Matcher>[equals(-1)],
    );
  });
}
