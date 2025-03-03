import 'package:expenses/models/expense.dart';
import 'package:expenses/widgets/expenses_list/expenses_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });
  final Function(Expense expense) onRemoveExpense;
  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        return Dismissible(
          background: Container(
            margin: Theme.of(context).cardTheme.margin,
          ),
          key: ValueKey(expenses[index]),
          onDismissed: (direction) {
            onRemoveExpense(expenses[index]);
          },
          child: ExpensesItem(
            expense: expenses[index],
          ),
        );
      },
    );
  }
}
