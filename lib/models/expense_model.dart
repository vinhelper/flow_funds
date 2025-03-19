class Expense {
  final String id;
  final String title;
  final String? note;
  final double amount;
  final String categoryId;
  final DateTime date;

  Expense({
    required this.id,
    required this.title,
    this.note,
    required this.amount,
    required this.categoryId,
    required this.date,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      title: json['title'],
      note: json['note'],
      amount: json['amount'],
      categoryId: json['categoryId'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'note': note,
      'amount': amount,
      'categoryId': categoryId,
      'date': date,
    };
  }
}
