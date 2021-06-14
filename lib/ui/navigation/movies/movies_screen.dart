import 'package:flutter/material.dart';
import 'package:my_movies/model/dto/movie_dto.dart';
import 'package:my_movies/provider/movies_provider.dart';
import 'package:my_movies/util/constant_application.dart';
import 'package:my_movies/widgets/popular_list_widget.dart';
import 'package:my_movies/widgets/trending_carousel_widget.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {

  final moviesProvider = new MoviesProvider();

  @override
  void initState() {
    super.initState();
    moviesProvider.getTrending();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(ConstantApplication.titleMoviesScreen),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: ListView(
          scrollDirection: Axis.vertical,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            _trendingMovieCarousel(),
            SizedBox(
              height: 10.0,
            ),
            _popularMovieList(),
          ],
        ),
      ),
    );
  }

  Widget _trendingMovieCarousel(){
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                'Trending',
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              )
          ),
          SizedBox(height: 5.0,),
          StreamBuilder(
              stream: moviesProvider.trendingStream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if(snapshot.hasData){
                  return TrendingCarouselWidget(
                    trendingList: snapshot.data,
                    nextPage: moviesProvider.getTrending,
                  );
                }else{
                  return Container(
                    height: 250.0,
                    child: Center(
                        child: CircularProgressIndicator()
                    ),
                  );
                }
              }
          ),
        ],
      ),
    );
  }

  Widget _popularMovieList(){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                'Popular',
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),
              )
          ),
          SizedBox(height: 5.0,),
          FutureBuilder(
            future: moviesProvider.getPopular(),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot){
              if(snapshot.hasData){
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: PopularListWidget(
                    movieList: snapshot.data as List<MovieDto>,
                  ),
                );
              }else{
                return Container(
                  height: 250.0,
                  child: Center(
                      child: CircularProgressIndicator()
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }


}
