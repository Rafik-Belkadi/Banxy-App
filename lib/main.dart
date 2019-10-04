import 'package:flutter/material.dart';
import 'Discover.dart';
import 'Home.dart';

const user_id = 16;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Banxy',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      theme: ThemeData(fontFamily: 'Pluto'),
      routes: {
        '/discover': (_) => DiscoverPage()
      },      
    );
  }
}
