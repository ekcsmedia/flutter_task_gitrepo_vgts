import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_task_gitrepo_vgts/home.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_task_gitrepo_vgts/model/repo.dart';

Future<All> fetchRepos(usernameGit) async {

  final String usernameG = usernameGit;
  final response =
      await http.get (Uri.parse('https://api.github.com/users/$usernameG/repos'));

  if (response.statusCode == 200) {
    print(response.body);
    return All.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to fetch repos');
  }
}

class RepoHome extends StatefulWidget {
  late String username;
  RepoHome({required this.username});

  @override
  _RepoHomeState createState() => _RepoHomeState();
}

class _RepoHomeState extends State<RepoHome> {
  late Future<All> futureRepo;

  @override
  void initState() {
    super.initState();
    futureRepo = fetchRepos(widget.username);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GitHub Repo List'),
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
          child: FutureBuilder<All>(
            future: futureRepo,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // ignore: deprecated_member_use
                List<Repo> repos = <Repo>[];
                dynamic repoLength = int.parse("${snapshot.data?.repos.length}");
                for (int i = 0; i < repoLength; i++) {
                  repos.add(
                    Repo(
                      name: (snapshot.data?.repos[i].name).toString(),
                      description: (snapshot.data?.repos[i].description).toString(),
                      htmlUrl: (snapshot.data?.repos[i].htmlUrl).toString(),
                    ),
                  );
                }
                return ListView(
                  children: repos
                      .map(
                        (r) => Card(
                          child: Column(children: [
                            Text(r.name),
                            Text(r.description),
                            Text(r.htmlUrl),
                          ]),
                        ),
                      )
                      .toList(),
                );
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
