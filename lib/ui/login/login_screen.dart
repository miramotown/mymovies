import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_movies/model/dto/user_dto.dart';
import 'package:my_movies/state/login_state.dart';
import 'package:my_movies/util/pallete_colors.dart';
import 'package:my_movies/widgets/loading_animate_widget.dart';
import 'package:uuid/uuid.dart';
import 'package:video_player/video_player.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {

  bool? loadingVisible = false;
  String? bottomText = "Copyright© 2021 - +1 Mas Uno - My Movies";
  bool? _loggedIn = false;

  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  VideoPlayerController? _videoPlayerController;
  double? screenWidth;
  double? screenHeight;
  var uuid;

  @override
  void initState(){
    super.initState();
    _videoPlayerController = VideoPlayerController.asset('assets/videos/video_login_background.mp4')..initialize().then((_) {
      _videoPlayerController!.play();
      _videoPlayerController!.setLooping(true);
      setState(() {

      });
    });
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

  }

  @override
  void dispose(){
    super.dispose();
    _videoPlayerController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    this.screenWidth = MediaQuery.of(context).size.width;
    this.screenHeight = MediaQuery.of(context).size.height;
    return loginForm(context);
  }

  Widget loginForm(BuildContext context){
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: (_videoPlayerController != null) ? _videoPlayerController!.value.size.width : 0,
                height: (_videoPlayerController != null) ? _videoPlayerController!.value.size.height : 0,
                child: VideoPlayer(_videoPlayerController!),
              ),
            ),
          ),
          (Theme.of(context).primaryColor == PalleteColors.premisesBlue_1) ?
          Container(
            color: Color.fromARGB(80, 255, 255, 255),
          )
              :
          Container(
            color: Color.fromARGB(80, 35, 83, 196),
          ),
          Container(
            width: screenWidth,
            height: screenHeight,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    height: screenHeight! * 0.35,
                    width: screenWidth,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 60.0, right: 50.0, left: 50.0),
                      child: _buildMyMoviesLogo(),
                    ),
                  ),
                  Container(
                    height: screenHeight! * 0.65,
                    width: screenWidth,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 50.0, right: 50.0, top: 50.0),
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: Container(),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(bottom: 50.0),
                                child: loginGoogleButton()
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15.0),
                              child: Text(
                                widget.bottomText!,
                                style: TextStyle(
                                  fontSize: 10.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          (widget.loadingVisible!) ? Container(
            color: Color.fromARGB(100, 35, 83, 196),
            child: LoadingAnimateWidget(),
          ) : SizedBox(
            width: 1.0,
            height: 1.0,
          ),
        ],
      ),
    );
  }

  Widget loginGoogleButton(){
    return Consumer<LoginState>(
      builder: (context, value, child){
        if(value.loadingSign){
          return Center(child: CircularProgressIndicator());
        }else{
          return child!;
        }
      },
      child: MaterialButton(
        minWidth: 500.0,
        color: Colors.white,
        splashColor: Colors.blueAccent,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 34.0,
                width: 34.0,
                child: Image.asset(
                    "assets/images/image_logo_google_sign.png"
                )
              ),
            ),
            Center(
              child: Text(
                "Sign in with Google",
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black54
                ),
              ),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
        ),
        onPressed: ()  {
          processLoginButton();
        },
      ),
    );
  }

  Widget _buildMyMoviesLogo(){
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                      top: 10.0,
                      bottom: 10.0
                  ),
                  height: 100.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.scaleDown,
                        image: AssetImage('assets/images/image_logo_my_movies.png')
                      )
                  ),
                )
            ),
          ],
        ),
        Text(
          'My Movies',
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  void showSnackBar(String message, int duration){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: duration),
      ),
    );
  }


  processLoginButton() async{
    uuid = Uuid();
    String uuidGenerate = uuid.v1();
    context.read<LoginState>().login();
    var user = Provider.of<LoginState>(context, listen: false).userCredential;
    if(user != null){
      UserDto userDto = new UserDto(name: user.user!.displayName, email: user.user!.email, loginDate: DateTime.now());
      print('UserDto -> '+userDtoResponseToJson(userDto));
      FirebaseFirestore.instance
          .collection("users")
          .parent!
          .set({
            "name" : userDto.name,
            "email" : userDto.email,
            "loginDate" : userDto.loginDate.toString()
      });
    }
  }

}
