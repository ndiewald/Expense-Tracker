import 'package:expense_tracker/widgets/transaction.widget.dart';
import 'package:flutter/material.dart';

import '../models/transaction.dart';

class TransactionListWidget extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String id) onDelete;

  TransactionListWidget({@required this.transactions, @required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: transactions.isEmpty
            ? Column(
                children: [
                  Text('No Transactions added yet!',
                      style: Theme.of(context).textTheme.headline6),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              )
            : ListView.builder(
                itemBuilder: (context, itemIndex) {
                  return TransactionWidget(
                    transaction: transactions[itemIndex],
                    onDelete: onDelete,
                  );
                },
                itemCount: transactions.length,
              ),
      ),
    );
  }
}
