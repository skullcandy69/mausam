import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:mausam/models/weather%20data.dart';
import 'package:mausam/models/weather.dart';
import 'package:mausam/utils/config.dart';
import 'package:http/http.dart' as http;

class Jankari extends StatefulWidget {
  @override
  _JankariState createState() => _JankariState();
}

class _JankariState extends State<Jankari> {
  String _hour;
  String _second;
  String _min;

  bool isLoading = false;
  WeatherData weatherData;

  @override
  void initState() {
    loadWeather(defaultCity);

    _hour = _formatDateTime(DateTime.now());
    _min = _formatDateTime(DateTime.now());
    _second = _formatDateTime(DateTime.now());

    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    Timer.periodic(Duration(minutes: 5), (Timer t) => loadWeather(defaultCity));

    //Timer.periodic(Duration(seconds: 1), (Timer t) => updateTemp(defaultCity,));

    super.initState();
  }

  void _getTime() {
    final DateTime now = DateTime.now();

    final String formattedhour = _formathour(now);
    final String formattedMin = _formatmin(now);
    final String formattedSecond = _formatsecond(now);

    setState(() {
      _hour = formattedhour;
      _min = formattedMin;
      _second = formattedSecond;
    });
  }

  String _formathour(DateTime dateTime) {
    return DateFormat.H().format(dateTime);
  }

  String _formatmin(DateTime dateTime) {
    return DateFormat('mm').format(dateTime);
  }

  String _formatsecond(DateTime dateTime) {
    return DateFormat('ss').format(dateTime);
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('dd').format(dateTime);
  }

  _onsave(String val) {
    setState(() {
      defaultCity = val;
    });
    print(defaultCity);
  }
  Location _location = new Location();
  String error;

  TextEditingController _controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: grey, offset: Offset(1, 2), blurRadius: 10)
                  ]),
              child: ListTile(
                leading: Icon(
                  Icons.search,
                  color: red,
                ),
                title: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                      hintText: 'Enter new location', border: InputBorder.none),
                  onChanged: (String value) {
                    _onsave(value);
                    loadWeather(defaultCity);
                  },
                  onTap: () {
                    setState(() {
                      _controller.clear();
                    });
                  },
                ),
              ),
            ),
          ),

//          Row(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              Container(
//                height: 60,
//                width: 45,
//                // color: Colors.grey,
//                child: Center(
//                    child: Text(
//                  "$_hour",
//                  style: GoogleFonts.armata(
//                      textStyle:
//                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
//                )),
//              ),
//              Text(
//                ":",
//                style: TextStyle(
//                    color: Colors.black,
//                    fontSize: 30,
//                    fontWeight: FontWeight.bold),
//              ),
//              Container(
//                  height: 60,
//                  width: 50,
////                        color: Colors.grey,
//                  child: Center(
//                      child: Text(_min,
//                          style: GoogleFonts.armata(
//                              textStyle: TextStyle(
//                                  fontSize: 30,
//                                  fontWeight: FontWeight.bold))))),
//              Text(
//                ":",
//                style: TextStyle(
//                    color: Colors.black,
//                    fontSize: 30,
//                    fontWeight: FontWeight.bold),
//              ),
//              Container(
//                height: 60,
//                width: 50,
////                      color: Colors.grey,
//                child: Center(
//                    child: Text(_second,
//                        style: GoogleFonts.armata(
//                            textStyle: TextStyle(
//                                fontSize: 30, fontWeight: FontWeight.bold)))),
//              ),
//            ],
//          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: weatherData != null
                    ? Weather(weather: weatherData)
                    : CircularProgressIndicator(),
              ),
//
            ],
          ),
        ],
      ),
    );
  }




  loadWeather(String city) async {
    setState(() {
      isLoading = true;
    });

    final weatherResponse = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&APPID=$apiId');

    if (weatherResponse.statusCode == 200) {
      return setState(() {
        weatherData =
            new WeatherData.fromJson(jsonDecode(weatherResponse.body));

        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      return 'error';
    }
  }
}
