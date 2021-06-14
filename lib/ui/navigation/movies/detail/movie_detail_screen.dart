import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:my_movies/model/dto/movie_dto.dart';
import 'package:my_movies/provider/movies_provider.dart';

class MovieDetailScreen extends StatefulWidget {

  final MovieDto? movieDto;

  const MovieDetailScreen({Key? key, this.movieDto}) : super(key: key);

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {

  bool _loadingData = true;
  MovieDto? movieDtoFull;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    processGetMovieDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(widget.movieDto!.title!),
        automaticallyImplyLeading: true,
      ),
      body: movieDetailForm(),
    );
  }

  Widget movieDetailForm(){
    return ListView(
      children: [
        Container(
          height: 400.0,
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.0)),
            child: Hero(
              tag: 'poster-'+widget.movieDto!.movieId!.tmdb.toString(),
              child: FadeInImage(
                image: _imagePoster(),
                placeholder: AssetImage('assets/images/image_no_image.jpg'),
                fit: BoxFit.cover,
                height: 400.0,
              ),
            ),
          ),
        ),
        (movieDtoFull != null) ?
        _movieDetail() :
        Center(child: CircularProgressIndicator())
      ],
    );
  }

  _imagePoster(){
    if(widget.movieDto!.posterPath.isNotEmpty){
      return NetworkImage(widget.movieDto!.posterPath);
    }else{
      return AssetImage('assets/images/image_no_image.jpg');
    }
  }

  Widget _movieDetail(){
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 80.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                LikeButton(
                  size: 42.0,
                  circleColor:
                  CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
                  bubblesColor: BubblesColor(
                    dotPrimaryColor: Color(0xff33b5e5),
                    dotSecondaryColor: Color(0xff0099cc),
                  ),
                  likeBuilder: (bool isLiked) {
                    return Icon(
                      Icons.star,
                      color: isLiked ? Colors.yellowAccent : Colors.grey,
                      size: 42.0,
                    );
                  },
                  likeCount: movieDtoFull!.votes,
                  countBuilder: (int? count, bool isLiked, String? text) {
                    var color = isLiked ? Colors.yellowAccent : Colors.grey;
                    Widget result;
                    if (count == 0) {
                      result = Text(
                        "Like",
                        style: TextStyle(color: color),
                      );
                    } else
                      result = Text(
                        text!,
                        style: TextStyle(color: color),
                      );
                    return result;
                  },
                ),
              ],
            ),
            Text(
              movieDtoFull!.tagline!,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              movieDtoFull!.overview!,
              style: TextStyle(
                  fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ),
    );
  }

  processGetMovieDetail() async{
    setState(() {

    });
    try{
      movieDtoFull = await MoviesProvider.getMovieDetail(widget.movieDto!.movieId!.slug!);
      if (movieDtoFull != null){
        setState(() {

        });
      }else{
        showSnackBar('Service Error', 3);
        setState(() {

        });
      }
    } on TimeoutException catch (a) {
      showSnackBar('Se ha excedido el tiempo de respuesta para la conexion', 3);
      setState(() {

      });
    } on SocketException catch (b) {
      showSnackBar('Problema interno en la conexion - '+b.message, 3);
      setState(() {

      });
    } on Exception catch (c) {
      showSnackBar('No se pudo establecer una conexion con los parametros ingresados. - '+c.toString(), 3);
      setState(() {

      });
    }
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
