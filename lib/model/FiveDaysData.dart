import 'package:flutter/material.dart';

class FiveDaysData{
  final String ? dateTime;
  final int ? temp;
  final int ?humidity;
  final int ?temp_min;
  final int ?temp_max;
  final List<String> ?dateList;

  FiveDaysData({ this.dateTime,  this.temp
    ,this.humidity,
    this.temp_min,
    this.temp_max,
    this.dateList
  });

  factory FiveDaysData.fromJson( dynamic json) {
    if(json==null){
      return FiveDaysData();
    }
    var f = json['dt_txt'].split(' ')[0].split('-')[2];
    var l = json['dt_txt'].split(' ')[0].split('-')[1];
    //2022-08-29 15:00:00
    // debugPrint(f+' this is F');
    // debugPrint(l+' this is l');
    var fandl = '$f-$l';
     debugPrint('$fandl this is fandl');
    return FiveDaysData(
      dateTime: '$fandl',
      temp: (json['main']['temp']-273.15).round(),
      temp_min: (json['main']['temp_min']).round(),
      temp_max: (json['main']['temp_max']).round(),
      humidity: (json['main']['humidity']),

    );
  }





}