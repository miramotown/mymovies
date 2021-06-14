import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_movies/model/dto/user_dto.dart';
import 'package:my_movies/state/login_state.dart';
import 'package:my_movies/util/constant_application.dart';
import 'package:my_movies/util/validate.dart';
import 'package:my_movies/widgets/editable_input_text_widget.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  CollectionReference? collectionReference;
  UserCredential? userCredential;
  String? imageUrl;
  UserDto? userDto;
  var userData;
  final _controllerName = TextEditingController();
  final _controllerEmail = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUser();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(ConstantApplication.titleProfileScreen),
        automaticallyImplyLeading: false,
      ),
      body: _profileForm(),
    );
  }

  Widget _profileForm(){
    return Container(
      child: ListView(
        scrollDirection: Axis.vertical,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        children: [
          SizedBox(
            height: 5.0,
          ),
          Container(
            height: 100.0,
            child: Center(
              child: (imageUrl != null) ? CircleAvatar(
                radius: 50.0,
                backgroundImage: NetworkImage(imageUrl!),
              ) : Icon(Icons.account_circle_rounded, size: 100.0,),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text('Name:'),
          EditableInputText(
            controller: _controllerName,
            inputType: TextInputType.text,
            maxLength: 30,
            maxLines: 1,
          ),
          SizedBox(
            height: 5.0,
          ),
          Text('Email:'),
          EditableInputText(
            controller: _controllerEmail,
            inputType: TextInputType.emailAddress,
            maxLength: 60,
            maxLines: 1,
          ),
          SizedBox(
            height: 10.0,
          ),
          saveChangesButton(),
          SizedBox(
            height: 100.0,
          ),
          logoutButton(),
        ],
      ),
    );
  }

  Widget saveChangesButton(){
    return MaterialButton(
      minWidth: 500.0,
      color: Theme.of(context).accentColor,
      splashColor: Colors.blueAccent,
      child: Text(
        'Save Changes',
        style: TextStyle(
          fontSize: 14.0,
          color: Colors.white,
        ),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)
      ),
      onPressed: (){
        if(_controllerName.text.isEmpty){
          showSnackBar('Name is empty', 2);
        }else if(!Validate.isValidEmail(_controllerEmail.text.trim())){
          showSnackBar('invalid Email', 2);
        }else{
          applyChanges();
        }
      },
    );
  }

  Widget logoutButton(){
    return MaterialButton(
      minWidth: 500.0,
      color: Theme.of(context).errorColor,
      splashColor: Colors.blueAccent,
      child: Text(
        'Logout',
        style: TextStyle(
          fontSize: 14.0,
          color: Colors.white,
        ),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)
      ),
      onPressed: (){
        context.read<LoginState>().logout();
      },
    );
  }

  Future<dynamic> getUser() async{
    DocumentReference document = FirebaseFirestore.instance.collection("users").doc(context.read<LoginState>().userCredential!.user!.uid);
    await document.get().then((value){
      userData = value.data();
      print("value -> "+value.data().toString());
    });

    if(userData != null){
      _controllerName.text = userData["name"];
      _controllerEmail.text = userData["email"];
      imageUrl = userData["image"];
    }
    setState(() {});
  }

  applyChanges() async{
    collectionReference = FirebaseFirestore.instance.collection('users');
    if(collectionReference != null){
      await collectionReference!.doc(context.read<LoginState>().userCredential!.user!.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          print('Document data: ${documentSnapshot.data()}');
          updateUser(documentSnapshot);
        }
      });
    }
  }

  Future<void> updateUser(var oldData) {
    return collectionReference!
        .doc(context.read<LoginState>().userCredential!.user!.uid).update({
      'name': _controllerName.text.trim(),
      'email': _controllerEmail.text.trim(),
      'loginDate' : oldData.data()["loginDate"],
      'updateDate' : DateTime.now().toIso8601String()
    }).then((value) => print("User Update"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  showSnackBar(String message, int duration){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: duration),
      ),
    );
  }
  
}
