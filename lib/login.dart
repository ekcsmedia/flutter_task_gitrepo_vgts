import 'secret_keys.dart' as SecretKey;
import 'package:flutter_task_gitrepo_vgts/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

final AuthService authService = AuthService();

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  late StreamSubscription? _subs;
  late bool loader;

  @override
  void initState() {
    loader = false;
    _initDeepLinkListener();
    super.initState();
  }

  @override
  void dispose() {
    _disposeDeepLinkListener();
    super.dispose();
  }

  void _initDeepLinkListener() async {
    // ignore: deprecated_member_use
    _subs = getLinksStream().listen((String? link) {
      _checkDeepLink(link!);
    }, cancelOnError: true);
  }

  void _checkDeepLink(String link) {
    if (link != null) {
      String code = link.substring(link.indexOf(RegExp('code=')) + 5);
      authService.loginWithGitHub(code)
          .then((firebaseUser) {
        print(firebaseUser?.email);
        print(firebaseUser?.photoURL);
        print("LOGGED IN AS: " + (firebaseUser?.displayName).toString());
      }).catchError((e) {
        print("LOGIN ERROR: " + e.toString());
      });
    }
  }

  void _disposeDeepLinkListener() {
    if (_subs != null) {
      _subs?.cancel();
      _subs = null;
    }
  }

  void onClickGitHubLoginButton() async {
    const String url = "https://github.com/login/oauth/authorize" +
        "?client_id=" + SecretKey.GITHUB_CLIENT_ID +
        "&scope=public_repo%20read:user%20user:email";

    if (await canLaunch(url)) {
      setState(() {
        loader = true;
      });
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      setState(() {
        loader = false;
      });
      print("CANNOT LAUNCH THIS URL!");
    }
  }

  @override
  Widget build(BuildContext context){
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
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
                'Firebase GitHub Authentication',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    fontWeight: FontWeight.w500
                ),
              ),
              SizedBox(height: height*0.05,),
              Container(
                height: height*0.06,
                width: width*0.5,
                child:
                ElevatedButton(
                    child: Text(
                      'GitHub Log In',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18
                      ),
                    ),
                    onPressed: onClickGitHubLoginButton,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}