import 'dart:math';

import 'package:timed/timed.dart';

void main() {
  var example1 = Timed.get(to: DateTime(2022, 05, 01));
  print('example1: $example1');

  var to = DateTime(2022, 05, 01);
  var from = DateTime(2022, 12, 01);

  var example2 = Timed.get(to: to, from: from);
  print('example2: $example2');

  to = DateTime(2022, 05, 01);
  from = DateTime(2022, 05, 01);

  var example3 = Timed.get(to: to, from: from);
  print('example3: $example3');

  print('now: ${DateTime(2019, 03, 25).toTimed}');

  to = DateTime(2018, 03, 24);

  var example4 = Timed.get(to: to,annualLimit: 10);
  print('example4: $example4');
}
