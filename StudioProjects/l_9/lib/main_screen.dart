import 'package:flutter/material.dart';
import 'db_helper.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late Future<User> _userData;

  @override
  void initState() {
    super.initState();
    _userData = getUserData();
  }

  Future<User> getUserData() async {
    DBHelper dbHelper = DBHelper();
    return dbHelper.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Screen'),
      ),
      body: FutureBuilder<User>(
        future: _userData,
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error occurred'));
          } else {
            User user = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Username: ${user.username}'),
                  Text('Phone: ${user.phone}'),
                  Text('Email: ${user.email}'),
                  Text('Address: ${user.address}'),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}