import 'package:electrometer/bootstrap.dart';
import 'package:electrometer/views/app/app.dart';
import 'package:flutter/widgets.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  bootstrap(() => const App());
}
