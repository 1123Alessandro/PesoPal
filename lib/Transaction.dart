import 'dart:core';
import 'package:intl/intl.dart';
import 'TxnType.dart';

class Txn {
  String _name = 'test';
  double _price = 0.00;
  String _id = '000';
  DateTime _date = DateTime(1970, 4, 1);
  TxnType _type = TxnType.None;
  static const String TABLENAME = "Transaction";

  Txn({required name, required price, required date}) {
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

  TxnType getType() {
    return this._type;
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

  void setType(TxnType type) {
    this._type = type;
  }

  void setID(String id) {
    this._id = id;
  }

  Map<String, dynamic> toMap() {
    return {};
  }
}
