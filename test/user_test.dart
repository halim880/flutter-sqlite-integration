import 'package:learn_sqlite/user.dart';
import 'package:test/test.dart';

void main() {
  test('Counter value should be incremented', () {
    final User user = User(name: "akash", email: "akash@gmail.com", password: "password");
    Map<String, dynamic> mapUser = user.toMap();
    expect(mapUser['name'], 'akash');
    expect(mapUser['email'], 'akash@gmail.com');
    expect(mapUser['password'], 'password');
  });
}