import 'package:expensetracker/data/expense_data.dart';
import 'package:expensetracker/models/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/expense_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final newExpenseNameController = TextEditingController();
  final newExpenseAmountController = TextEditingController();

  void addNewExpense() {
    // Logic to add a new expense
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Add New Expence'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: newExpenseNameController),
                TextField(controller: newExpenseAmountController),
              ],
            ),
            actions: [
              MaterialButton(onPressed: save, child: Text('Save')),
              MaterialButton(onPressed: cancel, child: Text('Cancel')),
            ],
          ),
    );
  }

  // Save Function
  void save() {
    ExpenseItem newExpense = ExpenseItem(
      name: newExpenseNameController.text,
      amount: newExpenseAmountController.text,
      dateTime: DateTime.now(),
    );
    Provider.of<ExpenseData>(context, listen: false).addNewExpense(newExpense);
    Navigator.pop(context); // Close the dialog
    clear();
  }

  // Cancel Function
  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    newExpenseNameController.clear();
    newExpenseAmountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder:
          (context, value, child) => Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: addNewExpense,
              shape: CircleBorder(),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              child: Icon(Icons.add),
            ),
            body: ListView.builder(
              itemCount: value.getAllExpenseList().length,
              itemBuilder:
                  (context, index) => ExpenseTile(
                    name: value.getAllExpenseList()[index].name,
                    amount: value.getAllExpenseList()[index].amount,
                    dateTime: value.getAllExpenseList()[index].dateTime,
                  ),
            ),
          ),
    );
  }
}
