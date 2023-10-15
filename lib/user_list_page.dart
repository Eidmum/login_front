import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class UserListPage extends StatefulWidget {
  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  List<Map<String, dynamic>> users = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:3000/api/v1/users'));

    if (response.statusCode == 200) {
      final List<dynamic> userData = json.decode(response.body);
      setState(() {
        users = List<Map<String, dynamic>>.from(userData);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            title: Text('Name: ${user['name']}'),
            subtitle: Text('Phone: ${user['phone']}'),
          );
        },
      ),
    );
  }
}
