
import 'package:learn_sqlite/Database.dart';
import 'package:learn_sqlite/user.dart';

class UserRepository {
  UserRepository._();
  static final UserRepository repo = UserRepository._();

  Future<List<User>> get users async {
    List<Map<String, dynamic>> results = await DBprovider.db.getUsers();
    List<User> users = results.map((map) =>User.fromMap(map)).toList();
    return users;
  }
}