#!/usr/bin/env dart

import 'dart:io';
import 'dart:convert';

main () async {

  String filename = "input";
//  String filename = "testdata_1a.txt";

  Stream lines = new File(filename)
  .openRead()
  .transform(utf8.decoder)
  .transform(const LineSplitter());

  int current = 0;
  await for (var command in lines) {
    int newCurrent = current + int.parse(command);
    print("Current frequency $current, change of $command; resulting frequency $newCurrent");
    current = newCurrent;
  }
}
