import 'package:flutter/material.dart';
import 'package:my_movies/model/dto/trending_dto.dart';
import 'package:my_movies/widgets/trending_carousel_card_widget.dart';

class TrendingCarouselWidget extends StatelessWidget {

  List<TrendingDto>? trendingList;
  Function? nextPage;

  TrendingCarouselWidget({@required this.trendingList, @required this.nextPage});

  final _pageController = new PageController(
      initialPage: 1,
      viewportFraction: 0.30
  );

  @override
  Widget build(BuildContext context) {

    _pageController.addListener(() {
      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent - 200){
        print('Loading next page...');
        nextPage!();
      }
    });

    return Container(
      height: 250.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: trendingList!.length,
        itemBuilder: (context, i){
          return TrendingCarouselCardWidget(trending: trendingList![i]);
        },
      ),
    );
  }


}