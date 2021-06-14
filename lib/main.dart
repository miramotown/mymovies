import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_movies/route/routes.dart';
import 'package:my_movies/state/login_state.dart';
import 'package:my_movies/ui/login/login_screen.dart';
import 'package:my_movies/ui/navigation/navigation_screen.dart';
import 'package:my_movies/util/constant_application.dart';
import 'package:my_movies/util/pallete_colors.dart';
import 'package:provider/provider.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: ConstantApplication.applicationName,
        themeMode: ThemeMode.system,
        theme: ThemeData(
          primaryColor: PalleteColors.premisesBlue_1,
          accentColor: PalleteColors.premisesBlue_1,
          //primarySwatch: Colors.blue,
          //secondaryHeaderColor: Constants.premisesBlue_1
          //visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        darkTheme: ThemeData(
            brightness: Brightness.dark,
            accentColor: PalleteColors.premisesBlue_1
        ),
        routes: {
          '/' : (BuildContext context){
            var state = Provider.of<LoginState>(context);
            if(state.loggedIn){
              return NavigationScreen();
            }else{
              return LoginScreen();
            }
          }
        }
      ),
    );
  }
}
