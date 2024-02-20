import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();



}

class _AuthState extends State<Auth> {
  final FirebaseAuth _auth= FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed:() {
            _signInWithGoogle();

          },  child: Text("press"),
        ),
      ),
    );
  }
  Future<User?> _signInWithGoogle() async{
    try{
     final GoogleSignInAccount? googleSignInAccount=await _googleSignIn.signIn();
     if(googleSignInAccount!= null){
       final GoogleSignInAuthentication googleAuth = await googleSignInAccount.authentication;
       final AuthCredential credential = GoogleAuthProvider.credential(
         accessToken: googleAuth.accessToken,
         idToken: googleAuth.idToken,
       );
       final UserCredential authResult = await _auth.signInWithCredential(credential);
       final User? user = authResult.user;
       return user;

     }

    }catch (error){
      print('Error signing in with Google:$error');
      return null;
    }
  }
}
