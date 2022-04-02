import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_task_gitrepo_vgts/home.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_task_gitrepo_vgts/model/org.dart';

import 'model/org.dart';
import 'model/org.dart';

Future<All> fetchOrgs(organisation) async {

  final String organisationN = organisation;
  final response =
  await http.get (Uri.parse('https://api.github.com/$organisationN'));

  if (response.statusCode == 200) {
    print(response.body);
    return All.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to fetch orgs');
  }
}

class OrgHome extends StatefulWidget {
  late String organisationName;
  OrgHome({required this.organisationName});

  @override
  _OrgHomeState createState() => _OrgHomeState();
}

class _OrgHomeState extends State<OrgHome> {
  late Future<All> futureOrgs;

  @override
  void initState() {
    super.initState();
    futureOrgs = fetchOrgs(widget.organisationName);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GitHub Organisations List'),
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
            future: futureOrgs,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Orgs> organisationList = <Orgs>[];
                dynamic orgsLength = int.parse("${snapshot.data?.orgs.length}");
                for (int i = 0; i < orgsLength; i++) {
                  organisationList.add(
                    Orgs(
                      url: (snapshot.data?.orgs[i].url).toString(),
                      description: (snapshot.data?.orgs[i].description).toString(),
                    ),
                  );
                }
                return ListView(
                  children: organisationList
                      .map(
                        (r) => Card(
                      child: Column(children: [
                        Text(r.url),
                        Text(r.description),
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
