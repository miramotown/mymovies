import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_movies/model/dto/movie_dto.dart';
import 'package:my_movies/model/dto/trending_dto.dart';
import 'package:my_movies/model/rest/themoviedb_response.dart';
import 'package:my_movies/provider/themoviedb_provider.dart';
import 'package:my_movies/ui/navigation/movies/detail/movie_detail_screen.dart';

class TrendingCarouselCardWidget extends StatefulWidget {

  TrendingDto? trending;

  TrendingCarouselCardWidget({Key? key, this.trending}) : super(key: key);

  @override
  _TrendingCarouselCardWidgetState createState() => _TrendingCarouselCardWidgetState();
}

class _TrendingCarouselCardWidgetState extends State<TrendingCarouselCardWidget> {

  String? _messageResult;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right:  15.0),
      child: Card(
        elevation: 5.0,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: InkWell(
          onTap: (){
            goToMovieDetail(widget.trending!.movie);
          },
          child: Column(
            children: <Widget>[
              (widget.trending!.isProcess) ?
              Container(
                  height: 200.0,
                  child: Center(
                      child: CircularProgressIndicator()
                  )
              )
                  :
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Hero(
                  tag: 'poster-'+widget.trending!.movie!.movieId!.tmdb.toString(),
                  child: FadeInImage(
                    image: _imagePoster(),
                    placeholder: AssetImage('assets/images/image_no_image.jpg'),
                    fit: BoxFit.cover,
                    height: 200.0,
                  ),
                ),
              ),
              SizedBox(height: 5.0,),
              Text(
                widget.trending!.movie!.title!,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.caption,
              ),
              Text(
                'Watchers: '+widget.trending!.watchers.toString(),
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
        ),
      ),
    );
  }

  goToMovieDetail(MovieDto? movieDto) async {
    _messageResult = await Navigator.push(
        context,
        MaterialPageRoute(builder: (buildContext) => MovieDetailScreen(movieDto: movieDto,))
    );
    if(_messageResult != null){
      print('goToMovieDetail() - result -> '+_messageResult!);
    }
  }

  _imagePoster(){
    if(widget.trending!.movie!.posterPath.isNotEmpty){
      return NetworkImage(widget.trending!.movie!.posterPath);
    }else{
      return AssetImage('assets/images/image_no_image.jpg');
    }
  }

  _initData() async{
    if(widget.trending!.movie!.movieId!.imdb != null){
      try{
        TheMovieDbResponse response = await TheMovieDbProvider.getTheMovieDbInfo(widget.trending!.movie!);
        String posterPath = response.movieResults!.first.posterPath!;
        widget.trending!.movie!.posterPath = 'https://image.tmdb.org/t/p/w500$posterPath';
        setState(() {
          widget.trending!.isProcess = false;
        });
      } on TimeoutException catch (a) {
        setState(() {
          widget.trending!.isProcess = false;
          widget.trending!.movie!.posterPath = '';
        });
      } on SocketException catch (b) {
        setState(() {
          widget.trending!.isProcess = false;
          widget.trending!.movie!.posterPath = '';
        });
      } on Exception catch (c) {
        setState(() {
          widget.trending!.isProcess = false;
          widget.trending!.movie!.posterPath = '';
        });
      }
    }else{
      setState(() {
        widget.trending!.isProcess = false;
        widget.trending!.movie!.posterPath = '';
      });
    }
  }

}
