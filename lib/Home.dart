import 'package:flutter/material.dart';
import 'package:learn_sqlite/Database.dart';
import 'package:learn_sqlite/repository/user_repository.dart';
import 'package:learn_sqlite/user.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // String name = '';
  // String email = '';
  // String password = '';
  UserRepository repository = UserRepository.repo;

  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  Future<List<User>>? users;

  @override
  void initState() {
    super.initState();
    users = repository.users;
  }


  getUser() async {
    return await DBprovider.db.getUsers();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _name,
                decoration: const InputDecoration(
                  labelText: "name"
                 ),
              ),
            ),

            Container(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _email,
                decoration: const InputDecoration(
                  labelText: "Email"
                 ),
              ),
            ),

            Container(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _password,
                decoration: const InputDecoration(
                  labelText: "Password"
                 ),
              ),
            ),

            MaterialButton(
              child: const Text('Save'),
              color: Colors.blue,
              onPressed :() async {
                bool inserted = await DBprovider.db.storeUser(User(
                    name: _name.text, 
                    email: _email.text, 
                    password: _password.text
                  ));
                if (inserted) {
                  setState(() {
                    _name.text = '';
                    _email.text = '';
                    _password.text = '';
                    users = repository.users;
                  });
                }
              },
            ),
            FutureBuilder(
              future: users,
              initialData: 'hello',
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const Text('No users found');
                }
                if (snapshot.data.length<1) {
                  return const Text('No users found');
                }
                return Expanded(
                    child: DataTable(
                      columnSpacing: 8.0,
                    columns: [
                      const DataColumn(label: Text('ID'), numeric: true),
                      const DataColumn(label: Text('Name'), numeric: true),
                      const DataColumn(label: Text('Email')),
                      const DataColumn(label: Text('Action')),
                    ], 
                    rows: [for(User user in snapshot.data) DataRow(
                        cells: [
                          DataCell(Text(user.id.toString())),
                          DataCell(Text(user.name.toString())),
                          DataCell(Text(user.email.toString())),
                          DataCell(MaterialButton(
                            child: const Text('Delete'),
                            onPressed: () async{
                              DBprovider.db.deleteUser(user.id);
                              setState(() {
                                users = repository.users;
                              });
                            },
                          )),
                        ]
                    )]
                  ),
                );
              },
            ),
          ]
        ),
      ),
    );
  }
}