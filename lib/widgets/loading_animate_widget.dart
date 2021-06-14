import 'package:flutter/material.dart';

class LoadingAnimateWidget extends StatefulWidget {
  @override
  _LoadingAnimateWidgetState createState() => _LoadingAnimateWidgetState();
}

class _LoadingAnimateWidgetState extends State<LoadingAnimateWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1500)
    );
    _controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _){
        return Center(
            child: Container(
                width: (150.00 * _controller.value < 100) ? 100 : 150.00 * _controller.value,
                height: (150.00 * _controller.value < 100) ? 100 : 150.00 * _controller.value,
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,//Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.all(
                    const Radius.circular(75.00),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 0),
                        blurRadius: 10.0,
                        spreadRadius: 1.0
                    )
                  ],
                ),
                child: Center(
                  child: Container(
                    width: (105.00 * _controller.value < 70) ? 70 : 105.00 * _controller.value,
                    height: (105.00 * _controller.value < 70) ? 70 : 105.00 * _controller.value,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/image_logo_my_movies.png"),
                          fit: BoxFit.cover
                      ),
                    ),
                  ),
                )
            )
        );
      },
    );
  }
}