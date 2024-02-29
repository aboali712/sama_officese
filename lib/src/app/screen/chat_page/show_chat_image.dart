import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowImage extends StatelessWidget {
  final String imageUrl;
  const ShowImage( {Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return Scaffold(body:Container(
      height: size.height,
      width: size.width,
      color: Colors.black,
      child: Image.network(imageUrl),

    ) ,);
  }
}