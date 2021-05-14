import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionWidget extends StatelessWidget {
  final Transaction transaction;
  final void Function(String id) onDelete;

  const TransactionWidget({
    @required this.transaction,
    @required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: FittedBox(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${transaction.amount.toStringAsFixed(2)} €',
              ),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(DateFormat('dd. MMM yyyy').format(transaction.date)),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: () => onDelete(transaction.id),
        ),
      ),
    );
  }
}
