import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final dateFormatter = DateFormat.yMMMd();

enum Category {
  travel,
  food,
  leisure,
  entertainment,
  other,
}

abstract interface class CategoryClass {
  static String travel = 'travel';
  static String food = 'food';
  static String leisure = 'leisure';
  static String entertainment = 'entertainment';
}

const categoryIcons = {
  Category.food: Icons.lunch_dining_rounded,
  Category.entertainment: Icons.movie_creation_outlined,
  Category.leisure: Icons.airline_seat_individual_suite_outlined,
  Category.travel: Icons.travel_explore,
  Category.other: Icons.incomplete_circle,
};

class ExpenseModel {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  ExpenseModel({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  String get formattedDate {
    return dateFormatter.format(date);
  }
}

class ExpenseBucket {
  final Category category;
  final List<ExpenseModel> expenses;

  ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory(List<ExpenseModel> allExpenses, this.category)
      : expenses = allExpenses.where((expense) {
          return expense.category == category;
        }).toList();

  double get totalExpenses {
    double sum = 0;
    for (ExpenseModel expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}

List<ExpenseModel> dummyExpenses = [
  ExpenseModel(
    title: "Flight to NYC",
    amount: 350.75,
    date: DateTime(2024, 2, 10),
    category: Category.travel,
  ),
  ExpenseModel(
    title: "Lunch at Italian Bistro",
    amount: 25.50,
    date: DateTime(2024, 2, 11),
    category: Category.food,
  ),
  ExpenseModel(
    title: "Theme Park Tickets",
    amount: 80.00,
    date: DateTime(2024, 2, 12),
    category: Category.entertainment,
  ),
  ExpenseModel(
    title: "Weekend Beach Resort",
    amount: 200.00,
    date: DateTime(2024, 2, 9),
    category: Category.leisure,
  ),
  ExpenseModel(
    title: "Dinner at Steakhouse",
    amount: 45.99,
    date: DateTime(2024, 2, 8),
    category: Category.food,
  ),
  ExpenseModel(
    title: "Concert Tickets",
    amount: 120.00,
    date: DateTime(2024, 2, 7),
    category: Category.entertainment,
  ),
  ExpenseModel(
    title: "Cab Ride to Airport",
    amount: 30.00,
    date: DateTime(2024, 2, 6),
    category: Category.travel,
  ),
  ExpenseModel(
    title: "Spa and Massage",
    amount: 75.00,
    date: DateTime(2024, 2, 5),
    category: Category.leisure,
  ),
  ExpenseModel(
    title: "Fast Food Dinner",
    amount: 15.99,
    date: DateTime(2024, 2, 4),
    category: Category.food,
  ),
  ExpenseModel(
    title: "Movie Night",
    amount: 18.50,
    date: DateTime(2024, 2, 3),
    category: Category.entertainment,
  ),
];
