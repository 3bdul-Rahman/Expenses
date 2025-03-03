import 'package:expenses/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});
  final Function(Expense expense) onAddExpense;
  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final formatter = DateFormat.yMd();
  Category? _selectedCategory;
  DateTime? _selectedDate;
  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _amountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Title'),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        prefixText: '\$',
                        label: Text('Amount'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(_selectedDate == null
                            ? 'No Date Selected'
                            : formatter.format(_selectedDate!)),
                        IconButton(
                          onPressed: () async {
                            final now = DateTime.now();
                            final firstDate =
                                DateTime(now.year - 1, now.month, now.day);
                            final pickedDate = await showDatePicker(
                                context: context,
                                initialDate: now,
                                firstDate: firstDate,
                                lastDate: now);
                            setState(() {
                              _selectedDate = pickedDate;
                            });
                          },
                          icon: const Icon(Icons.calendar_month),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  DropdownButton(
                      value: _selectedCategory,
                      items: Category.values
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e.name.toUpperCase()),
                            ),
                          )
                          .toList(),
                      onChanged: (newCat) {
                        if (newCat == null) {
                          return;
                        }
                        setState(() {
                          _selectedCategory = newCat;
                        });
                      }),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      return Navigator.pop(context);
                    },
                    child: const Text('Cancle'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final double? enteredAmount =
                          double.tryParse(_amountController.text);
                      final bool amountIsInvalid =
                          enteredAmount == null || enteredAmount <= 0;
                      if (_titleController.text.trim().isEmpty ||
                          amountIsInvalid ||
                          _selectedDate == null ||
                          _selectedCategory == null) {
                        showDialog(
                            context: context,
                            builder: (ctx) {
                              return AlertDialog(
                                title: const Text('Invalid Input'),
                                content: const Text('Check your input'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(ctx);
                                    },
                                    child: const Text('Ok'),
                                  )
                                ],
                              );
                            });
                      } else {
                        widget.onAddExpense(Expense(
                            category: _selectedCategory!,
                            title: _titleController.text,
                            amount: enteredAmount,
                            date: _selectedDate!));
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Save Expense'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
