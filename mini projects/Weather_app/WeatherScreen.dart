// ignore: file_names
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/API.dart';
import 'package:weather_app/Additionalinformation.dart';
import 'package:weather_app/Forecast.dart';
import 'package:weather_app/commentBox.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:intl/intl.dart';

class Weatherscreen extends StatefulWidget {
  const Weatherscreen({super.key});
  @override
  State<Weatherscreen> createState() => _WeatherscreenState(); 
}

class _WeatherscreenState extends State<Weatherscreen> {
  bool isData = false;
  String cityname = 'London';
  final TextEditingController tec = TextEditingController();

  Future<Map<String, dynamic>> getcontent() async {
    try {
      final res = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityname&APPID=$api',
        ), //uri->uniformed resources identifier
      );
      final data = jsonDecode(res.body);
      if (data['cod'] != '200') {
        throw 'There is no thing related to your search';
      }
      return data;
      //data['list'][0]['main']['temp'];
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: isData ? ThemeData.dark() : ThemeData.light(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Weather App',
            style: TextStyle(
              fontFamily: String.fromCharCode(1000),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  tec.clear();
                  cityname = 'chennai';
                });
              },
              icon: Icon(Icons.refresh),
            ),
            IconButton(
              onPressed: () => {
                setState(() {
                  isData = !isData;
                }),
              },
              icon: Icon(
                isData ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
              ),
            ),
          ],
        ),
        body: FutureBuilder(
          future: getcontent(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: const CircularProgressIndicator.adaptive());
            }

            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            final data = snapshot.data!;
            final currtemp = data['list'][0]['main']['temp'];
            final climate = data['list'][0]['weather'][0]['main'];
            final pressure = data['list'][0]['main']['pressure'];
            final humidity = data['list'][0]['main']['humidity'];
            final speed = data['list'][0]['wind']['speed'];
            final min = data['list'][0]['main']['temp_min'];
            final max = data['list'][0]['main']['temp_max'];
            final border = OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(60),
            );

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: TextField(
                              controller: tec,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                hintText: 'Enter the City Name',
                                hintStyle: TextStyle(color: Colors.black),
                                prefixIcon: Icon(Icons.search),
                                prefixIconColor: Colors.black,
                                fillColor: Colors.white,
                                filled: true,
                                focusedBorder: border,
                                enabledBorder: border,
                              ),
                              keyboardType: TextInputType.name,
                              onSubmitted: (value) {
                                setState(() {
                                  if (tec.text != '') cityname = value;
                                });
                              },
                            ),
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Color.fromRGBO(5, 13, 237, 1),
                            foregroundColor: Color.fromRGBO(255, 255, 255, 1),
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 10,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              side: BorderSide(color: Colors.black, width: 2),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              if (tec.text != '') cityname = tec.text;
                            });
                          },
                          child: Text('Search'),
                        ),
                      ],
                    ),

                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  '$currtemp K ',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(cityname),
                                const SizedBox(height: 30),
                                Icon(
                                  climate == 'Clouds' || climate == 'Rain'
                                      ? Icons.cloud
                                      : Icons.sunny,
                                  size: 100,
                                ),
                                Text(
                                  climate.toString(),
                                  style: TextStyle(fontSize: 21),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Hourly forecasting',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontFamily: String.fromCharCode(1000),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 120,
                      width: 400,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: 12,
                        itemBuilder: (context, index) {
                          final hourlyForecast = data['list'][index + 1];
                          final climateForecast =
                              data['list'][index + 1]['weather'][0]['main'];
                          final time1 = DateTime.parse(
                            hourlyForecast['dt_txt'].toString(),
                          );
                          final date = DateFormat('d.M.y').format(time1);
                          final day = DateFormat('EEEE').format(time1);
                          return Forecast(
                            time: DateFormat.j().format(time1),
                            date: date,
                            day: day,
                            value: hourlyForecast['main']['temp'].toString(),
                            icon:
                                climateForecast == 'Clouds' ||
                                    climateForecast == 'Rain'
                                ? Icons.cloud
                                : Icons.sunny,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: Text(
                        'Additinal Information',
                        style: TextStyle(
                          fontFamily: String.fromCharCode(100),
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Additionalinformation(
                          icon: WeatherIcons.humidity,
                          text: 'Humidity',
                          value: humidity.toString(),
                        ),
                        Additionalinformation(
                          icon: Icons.air,
                          text: 'Wind Speed',
                          value: speed.toString(),
                        ),
                        Additionalinformation(
                          icon: WeatherIcons.barometer,
                          text: 'Pressure',
                          value: pressure.toString(),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Additionalinformation(
                            icon: WeatherIcons.day_cloudy_windy,
                            text: 'Min',
                            value: min.toString(),
                          ),
                          Additionalinformation(
                            icon: WeatherIcons.day_sunny,
                            text: 'Max',
                            value: max.toString(),
                          ),
                        ],
                      ),
                    ),
                    commentBox(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
