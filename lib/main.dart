import 'dart:convert';
import 'user_list_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  RegistrationScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RegistrationScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> registerUser(String name, String phone, String password) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:3000/api/v1/users'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'phone': phone,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Handle successful registration
    } else {
      // Handle registration failure
    }
  }

  Future<void> updateUser(String name, String phone, String password) async {
    final Map<String, dynamic> userData = {
      'name': name,
      'phone': phone,
      'password': password,
    };

    final response = await http.patch(

      Uri.parse('http://127.0.0.1:3000/api/v1/users/' + name),
      // Provide the appropriate endpoint for updating the user
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(userData),
    );
  }
  Future<void> deleteUser(String name) async {
    final response = await http.delete(
      Uri.parse('http://127.0.0.1:3000/api/v1/users/' + name),
      // Provide the appropriate endpoint for deleting the user
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'Phone'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),

            SizedBox(height: 16), // Add space between inputs and buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // Adjust alignment as needed
              children: [
                ElevatedButton(
                  onPressed: () {
                    final name = nameController.text;
                    final phone = phoneController.text;
                    final password = passwordController.text;
                    updateUser(name, phone, password);
                  },
                  child: Text('Update'),
                ),
                ElevatedButton(
                  onPressed: () {
                    final name = nameController.text;
                    deleteUser(name);
                  },
                  child: Text('Delete'),
                ),
                ElevatedButton(
                  onPressed: () {
                    final name = nameController.text;
                    final phone = phoneController.text;
                    final password = passwordController.text;
                    registerUser(name, phone, password);
                  },
                  child: Text('Create'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserListPage()),
                    );
                  },
                  child: Text('Show Users'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}