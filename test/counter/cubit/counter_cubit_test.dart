// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:bloc_test/bloc_test.dart';
import 'package:electrometer/bloc/dashboard/dashboard_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CounterCubit', () {
    test('initial state is 0', () {
      expect(DashboardBloc().state, equals(0));
    });

    blocTest<DashboardBloc, int>(
      'emits [1] when increment is called',
      build: () => DashboardBloc(),
      act: (DashboardBloc cubit) => cubit.increment(),
      expect: () => <Matcher>[equals(1)],
    );

    blocTest<DashboardBloc, int>(
      'emits [-1] when decrement is called',
      build: () => DashboardBloc(),
      act: (DashboardBloc cubit) => cubit.decrement(),
      expect: () => <Matcher>[equals(-1)],
    );
  });
}
