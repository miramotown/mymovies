import 'package:flutter/material.dart';
import 'package:my_movies/model/dto/movie_dto.dart';
import 'package:my_movies/widgets/popular_card_widget.dart';

class PopularListWidget extends StatelessWidget {

  List<MovieDto>? movieList;

  PopularListWidget({Key? key, this.movieList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(bottom: kFloatingActionButtonMargin + 48),
        shrinkWrap: true,
        itemCount: movieList!.length,
        itemBuilder: (BuildContext context, int index){
          final popularMovieItem = movieList![index];
          return PopularCardWidget(movieDto: popularMovieItem);
        });
  }

}
