import 'package:flutter/material.dart';
import 'package:flutter_task_gitrepo_vgts/provider/userProvider.dart';
import 'package:provider/provider.dart';

// user data are fetched and shown


class UserDetailsScreen extends StatefulWidget {
  late String username;
  UserDetailsScreen({required this.username});

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    Provider.of<UserProvider>(context).getUserProfile(widget.username);

  }
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.username),
        centerTitle: true,
      ),
      body:Container(
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
                    (user.user?.avatarUrl).toString()
                )
            )
        ),
      ),
    );
  }
}
