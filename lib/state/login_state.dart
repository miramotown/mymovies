import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginState with ChangeNotifier, DiagnosticableTreeMixin{
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  CollectionReference? users;

  bool _loggedIn = false;
  bool _loadingSign = false;
  UserCredential? _userCredential;

  UserCredential? get userCredential => _userCredential;
  bool get loggedIn => _loggedIn;
  bool get loadingSign => _loadingSign;

  void login() async{
    _loadingSign = true;
    notifyListeners();
    try{
      _userCredential = await signInWithGoogle();
      _loadingSign = false;
      if(_userCredential != null){
        users = FirebaseFirestore.instance.collection('users');
        if(users != null){
          await users!.doc(_userCredential!.user!.uid)
              .get()
              .then((DocumentSnapshot documentSnapshot) {
            if (documentSnapshot.exists) {
              print('Document data: ${documentSnapshot.data()}');
            } else {
              addUser();
            }
          });
        }

        _loggedIn = true;
        notifyListeners();
      }else{
        _loggedIn = false;
        notifyListeners();
      }
    }on Exception catch (c) {
      print('LoginState - login() - Exception -> '+c.toString());
      _loadingSign = false;
      _loggedIn = false;
      notifyListeners();
    }
  }

  void logout(){
    _googleSignIn.signOut();
    _loggedIn = false;
    notifyListeners();
  }

  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return users!
    .doc(_userCredential!.user!.uid).set({
      'name': _userCredential!.user!.displayName!,
      'email': _userCredential!.user!.email!,
      'image': _userCredential!.user!.photoURL!,
      'loginDate' : DateTime.now().toIso8601String()
    }).then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(FlagProperty('loggedIn', value: loggedIn));
    properties.add(FlagProperty('loadingSign', value: loadingSign));
    properties.add(ObjectFlagProperty('userCredential', _userCredential));
  }

  Future<UserCredential?> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

}