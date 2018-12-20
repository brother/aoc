#!/usr/bin/env dart

import 'dart:io';
import 'dart:convert';

main () {
  bool test = true;
  String filename = "input";
  if (test) {
    filename = "testdata_a1.txt";
  }

  var lines = new File(filename);
  List<String> boxidList = lines.readAsLinesSync();

  int pairs = 0;
  int trips = 0;

  for (var boxid in boxidList) {
    int pairFactor, tripFactor;
    int thesePairs = 0;
    int theseTrips = 0;
    bool pairAvailable = true;
    bool tripAvailable = true;

    Map chars = new Map();

    if (test) {
      print("Looking at $boxid.");
      List<String> hindsight = boxid.split(":");
      boxid = hindsight[1];
      pairFactor = int.parse(hindsight[0].split(",")[0]);
      tripFactor = int.parse(hindsight[0].split(",")[1]);
      print("Expecting to find $pairFactor pairs and $tripFactor trips in $boxid.");
    }

    // Assuming the list is always ASCII and so on... lazy
    for (int i=0; i<boxid.length; i++) {
      String letter = boxid[i];
      if (! chars.containsKey(letter)) {
        chars[letter] = 0;
      }
      chars[letter]++;
    }

    bumpScores(letter, score) {
      if (score == 2 && pairAvailable) {
        pairs++;
        thesePairs++;
        pairAvailable = false;
      } else if (score == 3 && tripAvailable) {
        trips++;
        theseTrips++;
        tripAvailable = false;
      }
    }
    chars.forEach(bumpScores);

    if (test) {
      expectEquals(thesePairs, pairFactor, "pair", boxid);
      expectEquals(theseTrips, tripFactor, "trips", boxid);
    }
  }
  print("Checksum ($pairs * $trips): ${pairs * trips}");
}

expectEquals(int actual, int expected, String type, String boxid) {
  if (actual != expected) {
    print("Problem with `$boxid`, expected $type result not found.");
    print("Actual: $actual");
    print("Expected: $expected");
  }
}
