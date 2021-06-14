import 'package:flutter/material.dart';
import 'package:my_movies/ui/login/login_screen.dart';
import 'package:my_movies/ui/navigation/navigation_screen.dart';

Map<String, WidgetBuilder> getApplicationRouter(){

  return <String, WidgetBuilder>{
    '/login'                                  : (BuildContext context) => LoginScreen(),
    //'/register_company'                     : (BuildContext context) => RegisterCompanyScreen(),
    //'/register_company_valid'               : (BuildContext context) => RegisterCompanyValidScreen(),
    //'/register_company_password'            : (BuildContext context) => RegisterCompanyPasswordScreen(),
    '/navigation'                             : (BuildContext context) => NavigationScreen(),
  };

}