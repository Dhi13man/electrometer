// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:bloc_test/bloc_test.dart';
import 'package:electrometer/dashboard/dashboard.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CounterCubit', () {
    test('initial state is 0', () {
      expect(DashboardCubit().state, equals(0));
    });

    blocTest<DashboardCubit, int>(
      'emits [1] when increment is called',
      build: () => DashboardCubit(),
      act: (cubit) => cubit.increment(),
      expect: () => [equals(1)],
    );

    blocTest<DashboardCubit, int>(
      'emits [-1] when decrement is called',
      build: () => DashboardCubit(),
      act: (cubit) => cubit.decrement(),
      expect: () => [equals(-1)],
    );
  });
}
