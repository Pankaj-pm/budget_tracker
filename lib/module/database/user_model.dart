class UserModel {
  int? id;
  String? name;
  String? password;
  String? date;
  String? number;

  UserModel({
    this.id,
    this.name,
    this.password,
    this.date,
    this.number,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    name: json["name"],
    password: json["password"],
    date: json["date"],
    number: json["number"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "password": password,
    "date": date,
    "number": number,
  };
}