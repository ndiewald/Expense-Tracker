import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/widgets/chart.widget.dart';
import 'package:expense_tracker/widgets/input_field.widget.dart';
import 'package:expense_tracker/widgets/transaction_list.widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amberAccent,
        fontFamily: 'Quicksand',
      ),
      home: MyHomePage(title: 'Expense Tracker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    Intl.defaultLocale = 'de_DE';
  }

  final List<Transaction> _userTransactions = [];

  void _openAddTransactionModalSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return InputField(onPressed: _addNewTransaction);
      },
    );
  }

  void _addNewTransaction(String title, double amount, DateTime date) {
    final Transaction transaction = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: date,
    );

    setState(() {
      _userTransactions.add(transaction);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((transaction) => transaction.id == id);
    });
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((transaction) {
      return transaction.date
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () => _openAddTransactionModalSheet(context))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ChartWidget(_recentTransactions),
          TransactionListWidget(
            transactions: _userTransactions,
            onDelete: _deleteTransaction,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openAddTransactionModalSheet(context),
        tooltip: 'Add new Transaction',
      ),
    );
  }
}
