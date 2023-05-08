import 'package:flutter/material.dart';

class Constants {
  BuildContext context;
  Constants(this.context);
  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;

  static const String list = '/list';
  static const String question = '/question';
}

  void printWrapped(String text) {
    final pattern =  RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }
