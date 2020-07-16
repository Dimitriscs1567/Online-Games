import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        padding: const EdgeInsets.all(0.0),
        child: Container(
          width: 250,
          color: Colors.blue,
          child: Row(
            children: [
              Container(
                height: 40,
                margin: const EdgeInsets.all(2.0),
                padding: const EdgeInsets.all(8.0),
                color: Colors.white,
                child: Image.asset(
                  "assets/google-button.png",
                  fit: BoxFit.fill,
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.blue,
                  child: Text(
                    "Sign in with Google",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        onPressed: () async {
          print("dasdasdasdasdasd");
          final GoogleSignIn _googleSignIn = GoogleSignIn();
          final FirebaseAuth _auth = FirebaseAuth.instance;

          final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
          final GoogleSignInAuthentication googleAuth =
              await googleUser.authentication;

          final AuthCredential credential = GoogleAuthProvider.getCredential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );

          final FirebaseUser user =
              (await _auth.signInWithCredential(credential)).user;
          print("signed in " + user.displayName);
        },
      ),
    );
  }
}
