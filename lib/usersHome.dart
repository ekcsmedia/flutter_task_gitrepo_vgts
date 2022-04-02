import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_task_gitrepo_vgts/home.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_task_gitrepo_vgts/model/user.dart';

Future<User> fetchUsers(userGit) async {

  final String userG = userGit;
  final response =
  await http.get (Uri.parse('https://api.github.com/users/$userG'));

  if (response.statusCode == 200) {
    print(response.body);
    return User.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to fetch users');
  }
}

class UserHome extends StatefulWidget {
  late String username;
  UserHome({required this.username});

  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  late Future<User> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = fetchUsers(widget.username);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GitHub User Data'),
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () async {Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home())
              );
              })
        ],      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: FutureBuilder<User>(
            future: futureUser,
            builder: (context, snapshot) {
              if (snapshot.hasData) {

              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error'),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
