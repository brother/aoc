#!/usr/bin/env dart

import 'dart:io';
import 'dart:convert';

main () {

  String filename = "input";
// Note that testdata 1a and 1c will not work in this scenario as it never steps
// backward.
//  String filename = "testdata_1b.txt";

  var lines = new File(filename);
  List<String> commands = lines.readAsLinesSync();

  int current = 0;
  List seen = new List();
  outerloop:
  while (true) {
    innerloop:
    for (var command in commands) {
      int newCurrent = current + int.parse(command);
      if (seen.contains(newCurrent)) {
        print("Current frequency $current, change of $command; resulting frequency $newCurrent, which has already been seen.");
        current = newCurrent;
        break outerloop;
      }
      seen.add(newCurrent);
      print("Current frequency $current, change of $command; resulting frequency $newCurrent.");
      current = newCurrent;
    }
  }
  print("");
  print("Result $current");
}
