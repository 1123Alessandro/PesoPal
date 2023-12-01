import 'Transaction.dart';
import 'TxnType.dart';
import 'dart:core';

class Earn extends Txn {

  TxnType type = TxnType.Earn;

  Earn({required name, required price, required date}) : super(name: name, price: price, date: date);

  Map<String, dynamic> toMap() {
    return {
      'id': this.getID(),
      'name': this.getName(),
      'price': this.getPrice(),
      'date': this.getDate(),
      'type': 'Earn',
    };
  }
}
