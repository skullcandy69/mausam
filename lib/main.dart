import 'package:flutter/material.dart';
import 'package:mausam/screens/home.dart';

void main() => runApp(MyApp());

//Using Bloc
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.darkThemeEnabled,
      initialData: false,
      builder: (context, snapshot) => MaterialApp(
          theme: snapshot.data ?   ThemeData.dark():ThemeData.light(),
          home: HomePage(snapshot.data),),
    );
  }
}
