
import "package:flutter/material.dart";
import 'package:learn_sqlite/Home.dart';

void main(){
  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}