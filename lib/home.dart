import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_task_gitrepo_vgts/reposHome.dart';
import 'package:flutter_task_gitrepo_vgts/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task_gitrepo_vgts/usersHome.dart';

import 'orgsHome.dart';

// home screen after successful login

final AuthService authService = AuthService();

class Home extends StatefulWidget {
  final User? user;

  Home({@required this.user});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final nameController = TextEditingController();
  final orgnameController = TextEditingController();

  late String name = nameController.text;
  late String org = orgnameController.text;

  late bool loader;

  @override
  void initState() {
    loader = false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body:  SingleChildScrollView(
          child: Container(
              height: height,
              width: width,
              child: loader
                  ? Center(
                child: CircularProgressIndicator(),
              )
                  : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Hey ' + (widget.user?.displayName).toString() +"!",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25
                    ),
                  ),
                  SizedBox(height: height*0.03,),
                  Container(
                    height: height*0.26,
                    width: height*0.26,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: 5,
                            color: Colors.white
                        ),
                        image: DecorationImage(
                            image: NetworkImage(
                                (widget.user?.photoURL).toString()
                            )
                        )
                    ),
                  ),
                  SizedBox(height: height*0.03,),
    /*            Text(
                    'User ID: ' + (widget.user?.uid).toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15
                    ),
                  ),   */
                  Text(
                    'Email: ' + (widget.user?.email).toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15
                    ),
                  ),
                  SizedBox(height: height*0.03,),
                  Container(
                    height: height*0.06,
                    width: width*0.47,
                    child:
                    ElevatedButton(
                      child: Text(
                        'Log Out',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18
                        ),
                      ),
                      onPressed: (){
                        setState(() {
                          loader = true;
                        });
                        authService.signOutWithGitHub();
                      },
                    ),
                  ),
                  SizedBox(height: height*0.03,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18
                        ),
                        decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: 'Username'),
                        controller: nameController),
                  ),
                  ElevatedButton(
                      child: Text(
                        'Go to User Data',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18
                        ),
                      ),
                      onPressed: (){
                        Navigator.of(context)
                            .pushReplacement(
                            MaterialPageRoute(builder: (context) => UserDetailsScreen(username: name),
                            ));
                      }
                  ),
                  SizedBox(height: height*0.03,),
                  ElevatedButton(
                    child: Text(
                      'Go to Repos List',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18
                      ),
                    ),
                    onPressed: (){
                      Navigator.of(context)
                          .pushReplacement(
                        MaterialPageRoute(builder: (context) => RepoHome(username: name),
                      ));
                    }
                  ),
                  SizedBox(height: height*0.03,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18
                        ),
                        decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: 'Organisation Name'),
                        controller: orgnameController),
                  ),
                  ElevatedButton(
                      child: Text(
                        'Go to Organisation List',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18
                        ),
                      ),
                      onPressed: (){
                        Navigator.of(context)
                            .pushReplacement(
                            MaterialPageRoute(builder: (context) => OrgHome(organisationName: org),
                            ));
                      }
                  ),
                ],
              )
          ),
        ),
      ),
    );
  }
}