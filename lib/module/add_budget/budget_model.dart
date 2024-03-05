class BudgetModel {
  int? id;
  String? type;
  double? amount;
  String? date;
  String? note;
  int? userId;
  String? category;

  BudgetModel({
    this.id,
    this.type,
    this.amount,
    this.date,
    this.note,
    this.userId,
    this.category,
  });

  factory BudgetModel.fromJson(Map<String, dynamic> json) => BudgetModel(
        id: json["id"],
        type: json["type"],
        amount: json["amount"]?.toDouble(),
        date: json["date"],
        note: json["note"],
        userId: json["user_id"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "amount": amount,
        "date": date,
        "note": note,
        "user_id": userId,
        "category": category,
      };
}
