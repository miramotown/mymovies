import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_movies/model/dto/movie_dto.dart';
import 'package:my_movies/model/rest/themoviedb_response.dart';
import 'package:my_movies/provider/themoviedb_provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:my_movies/ui/navigation/movies/detail/movie_detail_screen.dart';

class PopularCardWidget extends StatefulWidget {

  MovieDto? movieDto;


  PopularCardWidget({Key? key, this.movieDto}) : super(key: key);

  @override
  _PopularCardWidgetState createState() => _PopularCardWidgetState();
}

class _PopularCardWidgetState extends State<PopularCardWidget> {

  late final _ratingController;
  late double _rating;
  double _initialRating = 1.0;
  String? _messageResult;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: InkWell(
        onTap: (){
          goToMovieDetail(widget.movieDto);
        },
        child: Container(
          child: Row(
            children: [
              (widget.movieDto!.isProcess) ?
              Container(
                  height: 100.0,
                  width: 70.0,
                  child: Center(
                      child: CircularProgressIndicator()
                  )
              )
                  :
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: FadeInImage(
                  image: _imagePoster(),
                  placeholder: AssetImage('assets/images/image_no_image.jpg'),
                  fit: BoxFit.cover,
                  height: 100.0,
                  width: 70.0,
                ),
              ),
              SizedBox(
                width: 15.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.movieDto!.title!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(widget.movieDto!.year!.toString()),
                  RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                ],
              )
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
    if(widget.movieDto!.posterPath.isNotEmpty){
      return NetworkImage(widget.movieDto!.posterPath);
    }else{
      return AssetImage('assets/images/image_no_image.jpg');
    }
  }

  _initData() async{
    if(widget.movieDto!.movieId!.imdb != null){
      try{
        TheMovieDbResponse response = await TheMovieDbProvider.getTheMovieDbInfo(widget.movieDto!);
        String posterPath = response.movieResults!.first.posterPath!;
        widget.movieDto!.posterPath = 'https://image.tmdb.org/t/p/w500$posterPath';
        setState(() {
          widget.movieDto!.isProcess = false;
        });
      } on TimeoutException catch (a) {
        setState(() {
          widget.movieDto!.isProcess = false;
          widget.movieDto!.posterPath = '';
        });
      } on SocketException catch (b) {
        setState(() {
          widget.movieDto!.isProcess = false;
          widget.movieDto!.posterPath = '';
        });
      } on Exception catch (c) {
        setState(() {
          widget.movieDto!.isProcess = false;
          widget.movieDto!.posterPath = '';
        });
      }
    }else{
      setState(() {
        widget.movieDto!.isProcess = false;
        widget.movieDto!.posterPath = '';
      });
    }
  }

}
