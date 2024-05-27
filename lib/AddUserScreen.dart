import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddUserScreen extends StatefulWidget {
  @override
  _AddUserScreenState createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _avatarController = TextEditingController();

  Future<void> _addUser(String firstName, String lastName, String email, String avatar) async {
    final response = await http.post(
      Uri.parse('https://reqres.in/api/users'),
      body: jsonEncode({
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'avatar': avatar,
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 201) {
      final newUser = json.decode(response.body);
      Navigator.pop(context, newUser);  // Return the new user
    } else {
      throw Exception('Failed to add user.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _avatarController,
              decoration: InputDecoration(labelText: 'Avatar'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String firstName = _firstNameController.text;
                String lastName = _lastNameController.text;
                String email = _emailController.text;
                String avatar = _avatarController.text;
                _addUser(firstName, lastName, email, avatar);
              },
              child: Text('Add User'),
            ),
          ],
        ),
      ),
    );
  }
}
