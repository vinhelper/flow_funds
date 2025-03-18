class Expense {
  final String id;
  final String title;
  final String note;
  final double amount;
  final String categoryId;
  final DateTime date;

  Expense({
    required this.id,
    required this.title,
    required this.note,
    required this.amount,
    required this.categoryId,
    required this.date,
  });
}
