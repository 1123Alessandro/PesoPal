import 'Transaction.dart';
import 'TxnType.dart';
import 'dart:core';

class Expense extends Txn {

  Expense({required name, required price, required date}) : super(name: name, price: price, date: date) {
    this.setType(TxnType.Expense);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.getID(),
      'name': this.getName(),
      'price': this.getPrice(),
      'date': this.getDate().toString(),
      'type': 'Expense',
    };
  }
}

