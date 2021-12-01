// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:electrometer/views/app/app.dart';
import 'package:electrometer/views/dashboard/dashboard_screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(DashboardScreen), findsOneWidget);
    });
  });
}
