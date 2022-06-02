
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/homescreen.dart';
import '../Auth/appstate.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ApplicationState(),
      builder: (context, _) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        //appBarTheme: AppBarTheme(color: Colors.amber),       
      ),
      debugShowCheckedModeBanner:false,
      home: homescreen()
    );
  }
}