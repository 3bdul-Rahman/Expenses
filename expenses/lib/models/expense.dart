import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final dateFormat = DateFormat.yMd();

enum Category { food, travel, work, leisure }

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work
};

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String formattedDate() {
    return dateFormat.format(date);
  }

  Expense(
      {required this.category,
      required this.title,
      required this.amount,
      required this.date})
      : id = uuid.v4();
}

class ExpenseBucket {
  ExpenseBucket(this.category, this.expenses);
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category) // كونستراكتور خاص بتعمله الاسم اللي يريحك 
      : expenses = allExpenses
            .where((element) {
              return element.category == category;
            })
            .toList();
  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;
    for (var element in expenses) {
      sum += element.amount;
    }
    return sum;
  }
}
