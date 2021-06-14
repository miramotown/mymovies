import 'package:flutter/material.dart';
import 'package:my_movies/ui/navigation/movies/movies_screen.dart';
import 'package:my_movies/ui/navigation/profile/profile_screen.dart';
import 'package:my_movies/util/constant_application.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {

  int _currentIndex = 0;

  final List<Widget> _navigationScreens = [
    MoviesScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return mainScreen();
  }

  Widget mainScreen(){
    return Scaffold(
      body: _navigationScreens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        fixedColor: Theme.of(context).accentColor,
        unselectedItemColor: Theme.of(context).hintColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.movie_creation_rounded,
            ),
            label: ConstantApplication.titleMoviesScreen,
          ),
          BottomNavigationBarItem(
            icon: Icon(
                Icons.person),
            label: ConstantApplication.titleProfileScreen,
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index){
    setState(() {
      _currentIndex = index;
    });
  }

}
