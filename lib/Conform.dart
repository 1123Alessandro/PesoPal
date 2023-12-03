import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'dart:math';

import 'Analytics.dart';
import 'TransactionHistory.dart';
import 'DatabaseManager.dart';
import 'AddRecord.dart';

List<Map> conformRecs(List<Map> recs) {
  if (recs.length == 3) {
    return recs;
  }
  List<Map> newRecs = [];
  for (Map record in recs) {
    newRecs.add(record);
  }
  while (newRecs.length < 3) {
    Map<String, Object> map = {
      'name': 'None',
      'date': 'Add more transactions to your wallet!',
      'price': 0,
    };
    newRecs.add(map);
  }
  return newRecs;
}

List<Map> conformDash(List<Map> dash) {
  if (dash.length < 1) {
    return nones;
  }
  List<Map> newDash = [];
  for (Map n in dash) {
    newDash.add(n);
  }
  if (newDash[0]['type'] == 'Earn') {
    Map<String, Object> map = {
      'total': 0.0,
      'type': 'Expense'
    };
    newDash.add(map);
  }
  else {
    Map<String, Object> map = {
      'total': 0.0,
      'type': 'Earn'
    };
    newDash.add(map);
  }
  return newDash;
}