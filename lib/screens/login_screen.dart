import 'package:firebase/firebase.dart' as firebase;
import 'package:firebase/firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:online_games/utils/custom_router.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showUsername = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final cRouter = CustomRouter();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseUser>(
      future: _auth.currentUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasData) {
          cRouter.router.navigateTo(context, "/games");
          return Center();
        } else {
          return _mainBody();
        }
      },
    );
  }

  Widget _mainBody() {
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
          final GoogleSignIn _googleSignIn = GoogleSignIn();

          final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
          final GoogleSignInAuthentication googleAuth =
              await googleUser.authentication;

          final AuthCredential credential = GoogleAuthProvider.getCredential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );

          final FirebaseUser user =
              (await _auth.signInWithCredential(credential)).user;

          Firestore db = firebase.firestore();
          QuerySnapshot names = await db.collection("users").get();
          DocumentSnapshot nameExistsSnap = names.docs
              .firstWhere((doc) => doc.id.compareTo(user.uid) == 0, orElse: () {
            return null;
          });

          if (nameExistsSnap != null) {
            cRouter.router.navigateTo(context, "/games");
          } else {
            setState(() {
              _showUsername = true;
            });
          }
        },
      ),
    );
  }
}
