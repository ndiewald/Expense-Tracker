import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InputField extends StatefulWidget {
  final Function onPressed;

  InputField({Key key, @required this.onPressed}) : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    if (_titleController.text.isEmpty || _amountController.text.isEmpty) {
      return;
    }

    final String title = _titleController.text;
    final double amount = double.parse(_amountController.text);

    if (title.isEmpty || amount <= 0 || _selectedDate == null) {
      return;
    }

    widget.onPressed(title, amount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((date) {
      if (date == null) {
        return;
      }

      setState(() {
        _selectedDate = date;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Title',
              contentPadding: EdgeInsets.all(5),
            ),
            controller: _titleController,
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Amount',
              contentPadding: EdgeInsets.all(5),
            ),
            controller: _amountController,
            keyboardType: TextInputType.number,
            onSubmitted: (_) => _submitData,
          ),
          Container(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  child: Text(_selectedDate == null
                      ? 'No Date Chosen'
                      : 'Picked Date: ' + DateFormat('dd MMM yyyy').format(_selectedDate)),
                ),
                TextButton(
                  onPressed: () => _showDatePicker(context),
                  child: Text(
                    'Choose Date',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: _submitData,
            child: Text('Add Transaction'),
          )
        ],
      ),
    );
  }
}
