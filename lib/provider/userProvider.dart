import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task_gitrepo_vgts/api.dart';
import 'package:http/http.dart' as http;

import '../model/user.dart';

class UserProvider with ChangeNotifier {
  late User user;

  Future<void> getUserProfile(String username) async {
    final url = ('${Api.api}/users/${username}');

    try{
    final response = await http.get(Uri.parse(url),
        headers: {
      'Authorization': 'token ${Api.token}'
    });
    final responseData = json.decode(response.body) as Map<String, dynamic>;
    print(responseData['name']);
    user = User(
      name: responseData['login'],
      avatarUrl: responseData['avatar_url'],
      email: responseData['email']
    );
    } catch(e) {
      print(e);
    }
  }

}