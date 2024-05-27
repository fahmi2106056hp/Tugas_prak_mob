import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late Future<List<dynamic>> _userList;
  List<dynamic> _users = [];

  Future<List<dynamic>> _fetchUsers() async {
    final response = await http.get(Uri.parse('https://reqres.in/api/users?page=2'));
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData.containsKey('data')) {
        return responseData['data'];
      } else {
        throw Exception('Data not found in response');
      }
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  void _loadUsers() async {
    final users = await _fetchUsers();
    setState(() {
      _users = users;
    });
  }

  Future<void> _navigateToAddUserScreen(BuildContext context) async {
    final newUser = await Navigator.pushNamed(context, '/add_user');
    if (newUser != null) {
      setState(() {
        _users.add(newUser);
      });
    }
  }

  void _navigateToUserDetail(BuildContext context, int userId) {
    Navigator.pushNamed(context, '/user_detail', arguments: userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: _users.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index) {
                var user = _users[index];
                return ListTile(
                  title: Text('${user['first_name']} ${user['last_name']}'),
                  onTap: () {
                    _navigateToUserDetail(context, user['id']);
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToAddUserScreen(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
