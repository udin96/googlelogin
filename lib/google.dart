import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLogin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GoogleLoginState();
  }
}

class _GoogleLoginState extends State<GoogleLogin> {
  bool _isLoggedIn = false;

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  _login() async {
    try {
      await _googleSignIn.signIn();
      setState(() {
        _isLoggedIn = true;
      });
    } catch (err) {
      print(err);
    }
  }

  _logout() {
    _googleSignIn.signOut();
    setState(() {
      _isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title:
              Text('Pickiddo Google Login', style: TextStyle(wordSpacing: 5)),
        ),
        body: Column(
          children: <Widget>[
            Container(
              child: Image(
                image: NetworkImage(
                  'https://www.pickiddo.com/Content/banner/logo.png',
                ),
                width: 200,
                height: 200,
              ),
            ),
            Center(
                child: _isLoggedIn
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.network(
                            _googleSignIn.currentUser.photoUrl,
                            height: 210.0,
                            width: 210.0,
                          ),
                          Text(
                            'Welcome!',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            _googleSignIn.currentUser.displayName,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          OutlineButton(
                            child: Text("Logout"),
                            onPressed: () {
                              _logout();
                            },
                          ),
                        ],
                      )
                    : Center(
                        child: OutlineButton(
                          child: Text("Login with Google"),
                          onPressed: () {
                            _login();
                          },
                        ),
                      )),
          ],
        ),
      ),
    );
  }
}
