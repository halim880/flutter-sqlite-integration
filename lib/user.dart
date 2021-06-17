

class User {
  final int? id;
  final String name;
  final String email;
  final String? password;

  User({
    this.id,
    required this.name, 
    required this.email,
    required this.password
  });

  factory User.fromMap(Map<String, dynamic> map)=> User(
    id: map['id'],
    name: map['name'],
    email: map['email'],
    password: map['password'],
  );

  Map<String, dynamic> toMap() => {
    'id': id!=null?id:null,
    "name": name,
    "email": email,
    "password": password,
  };
}