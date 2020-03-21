import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mausam/screens/Display.dart';

class HomePage extends StatefulWidget {
  final bool darkThemeEnabled;

  HomePage(this.darkThemeEnabled);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink[300],
        title: Center(child: Text('Mausam')),

        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/clouds3.jpg'), fit: BoxFit.fill)),
            child: Stack(
              children: <Widget>[Jankari()],
            )),
      ),
    );
  }
}

class Bloc {
  // ignore: close_sinks
  final _themeController = StreamController<bool>();
  get changeTheme => _themeController.sink.add;
  get darkThemeEnabled => _themeController.stream;
}

final bloc = Bloc();
