import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mausam/models/weather%20data.dart';
import 'package:mausam/utils/config.dart';

class Weather extends StatelessWidget {
  final WeatherData weather;

  Weather({Key key, @required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .75,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(
        top: 5.0,
        bottom: 5.0,
        left: 10.0,
        right: 10.0,
      ),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(color: grey, offset: Offset(1, 5), blurRadius: 20)
      ], borderRadius: BorderRadius.circular(20), color: Colors.grey[200]),
      //color: grey,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 10, top: 15, bottom: 15, right: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            AutoSizeText(
              '${weather.name},${weather.country} ',
              style: GoogleFonts.aleo(
                  textStyle: TextStyle(
                      color: Colors.indigo,
                      fontSize: 50,
                      fontWeight: FontWeight.w400)),
              maxLines: 1,
            ),
            Text(new DateFormat.yMMMMEEEEd().format(weather.date),
                style: GoogleFonts.aleo(
                    textStyle: new TextStyle(color: Colors.black45))),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text('${weather.temp.toStringAsFixed(1)}°C',
                        style: TextStyle(
                            color: Colors.indigo,
                            fontSize: 30,
                            fontWeight: FontWeight.w400)),
                    AutoSizeText(
                      weather.main,
                     // style: TextStyle(color: Colors.black45),
                      style: GoogleFonts.aleo(
                          textStyle:
                          new TextStyle(color: Colors.indigo)),
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                      minFontSize: 10,
                    ),
                  ],
                ),
                Image.network(
                  'https://openweathermap.org/img/w/${weather.icon}.png',
                  scale: .4,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: ListTile(
                leading: Text("Min Temp:",
                    style: GoogleFonts.aleo(
                        textStyle: new TextStyle(color: Colors.black45))),
                trailing: Text('${weather.tempMin.toStringAsFixed(1)}°C',
                    style: GoogleFonts.aleo(
                        textStyle: new TextStyle(color: Colors.black45))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: ListTile(
                leading: Text("Max Temp:",
                    style: GoogleFonts.aleo(
                        textStyle: new TextStyle(color: Colors.black45))),
                trailing: Text('${weather.tempMax.toStringAsFixed(1)}°C',
                    style: GoogleFonts.aleo(
                        textStyle: new TextStyle(color: Colors.black45))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: ListTile(
                leading: Text("Feels like:",
                    style: GoogleFonts.aleo(
                        textStyle: new TextStyle(color: Colors.black45))),
                trailing: Text('${weather.feelsLike.toStringAsFixed(1)}°C',
                    style: GoogleFonts.aleo(
                        textStyle: new TextStyle(color: Colors.black45))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: ListTile(
                leading: Text("Humidity:",
                    style: GoogleFonts.aleo(
                        textStyle: new TextStyle(color: Colors.black45))),
                trailing: Text('${weather.humidity.toStringAsFixed(1)}%',
                    style: GoogleFonts.aleo(
                        textStyle: new TextStyle(color: Colors.black45))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: ListTile(
                leading: Text("Pressure:",
                    style: GoogleFonts.aleo(
                        textStyle: new TextStyle(color: Colors.black45))),
                trailing: Text('${weather.pressure.toStringAsFixed(1)}hPA',
                    style: GoogleFonts.aleo(
                        textStyle: new TextStyle(color: Colors.black45))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: ListTile(
                leading: Text("Wind Speed:",
                    style: GoogleFonts.aleo(
                        textStyle: new TextStyle(color: Colors.black45))),
                trailing: Text('${weather.wind.toStringAsFixed(1)}m/s',
                    style: GoogleFonts.aleo(
                        textStyle: new TextStyle(color: Colors.black45))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
