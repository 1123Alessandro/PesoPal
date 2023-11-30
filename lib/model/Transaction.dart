import 'dart:core';
import 'package:intl/intl.dart';

class Transaction {
  String _name = 'test';
  double _price = 0.00;
  String _id = '000';
  DateTime _date = DateTime(1970, 4, 1);

  Transaction({required name, required price, required date}) {
    this._name = name;
    this._price = price;
    this._date = date;
    _id = DateFormat('yyyyMMddHHmmss').format(DateTime.now());
  }

  String getName() {
    return this._name;
  }

  double getPrice() {
    return this._price;
  }

  String getID() {
    return this._id;
  }

  DateTime getDate() {
    return this._date;
  }

  void setName(String name) {
    this._name = name;
  }

  void setPrice(double price) {
    this._price = price;
  }

  void setDate(DateTime date) {
    this._date = date;
  }
}