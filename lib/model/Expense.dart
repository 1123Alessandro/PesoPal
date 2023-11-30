import 'Transaction.dart';
import 'TxnType.dart';
import 'dart:core';

class Expense extends Transaction {

  TxnType type = TxnType.Expense;

  Expense({required name, required price, required date}) : super(name: name, price: price, date: date);

  Map<String, dynamic> toMap() {
    return {
      'id': this.getID(),
      'name': this.getName(),
      'price': this.getPrice(),
      'date': this.getDate(),
      'type': 'Expense',
    };
  }
}

