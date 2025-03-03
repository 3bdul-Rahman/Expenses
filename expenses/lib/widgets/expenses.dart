import 'package:expenses/main.dart';
import 'package:expenses/models/expense.dart';
import 'package:expenses/widgets/chart/chart.dart';
import 'package:expenses/widgets/expenses_list/expenses_list.dart';
import 'package:expenses/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        category: Category.work,
        title: 'Flutter Course',
        amount: 29.9,
        date: DateTime.now()),
    Expense(
        category: Category.leisure,
        title: 'Cinema',
        amount: 9.71,
        date: DateTime.now()),
    Expense(
        category: Category.food,
        title: 'Breakfast',
        amount: 31.3,
        date: DateTime.now()),
  ];
  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    setState(() {
      _registeredExpenses.remove(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width; //Get my Width
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses App'),
        leading: IconButton(
            onPressed: () {
              setState(() {
                if (appmode == ThemeMode.dark) {
                  appmode = ThemeMode.light;
                } else {
                  appmode = ThemeMode.dark;
                }
              });
            },
            icon: appmode == ThemeMode.dark
                ? const Icon(Icons.light_mode)
                : const Icon(Icons.dark_mode)),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                useSafeArea: true, // لحفظ حدود الهاتف
                isScrollControlled: true, // لاخذ المساحة كاملة
                context: context,
                builder: (ctx) {
                  return NewExpense(onAddExpense: _addExpense);
                },
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Center(
        child: width < 600
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: Chart(expenses: _registeredExpenses)),
                  Expanded(
                    child: ExpensesList(
                      expenses: _registeredExpenses,
                      onRemoveExpense: _removeExpense,
                    ),
                  ),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: Chart(expenses: _registeredExpenses)),
                  Expanded(
                    child: ExpensesList(
                      expenses: _registeredExpenses,
                      onRemoveExpense: _removeExpense,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
