
import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather/model/currentWeather.dart';
import 'package:weather/service/Weather_Service.dart';

import '../model/FiveDaysData.dart';

class HomeController extends GetxController{
   String ? city;
   String? searchText;

 HomeController({this.city});
  CurrentWeather currentWeather=CurrentWeather();
 List<FiveDaysData> fiveDaysData=[];
  List<CurrentWeather> currentWeatherList=[];
   List<String> cities=['Tokyo','Cairo','London','Paris','Soul'];


   @override
  void onInit()async{
   await getCurrentLocation();
   // getCurrentWeather();
  getWeatherDataByLonAndLat();
  getFiveDaysData();
   getTopFiveCites();
   const Duration checkingTime = Duration(seconds:5);
  var _timer = Timer.periodic(checkingTime, (Timer t) => checkIfGpsIsOpened());//Using Geo

   initState();
    super.onInit();
  }

  void onUpdate(){
    initState();
  }

  void initState() {
    getWeatherDataByLonAndLat();

    // getCurrentWeather();
    // getFiveDaysData();
  }



 void getFiveDaysData() {
     fiveDaysData.clear();
   WeatherService(city:city).getFiveDaysForecastService(
       lon: position!.longitude, lat: position!.latitude,
       onSuccess:(value){
         // print(value.toString());
         fiveDaysData=value;
         // fiveDaysData.forEach((e) {
         //  if(e.dateList!.contains(e.dateTime)){
         //    e.dateList!.remove(e.dateTime);
         //   }else{
         //    e.dateList!.add(e.dateTime!);
         //  }
         //    // debugPrint(e.dateList.toString());
         // });

         debugPrint('${value.length.toString()}  getFiveDaysDataOnSuccess');
     update();
   } ,onError:(error){
     // debugPrint(error.toString());
     debugPrint('${error}getFiveDaysDataError');

     update();
   } );

 }

 void getFiveDaysDataInSearch() {
   fiveDaysData.clear();
   WeatherService(city:searchText).getFiveDaysForecastSearchService(
       onSuccess:(value){
     fiveDaysData=value;
     update();
   } ,onError:(error){
     // debugPrint(error.toString());
     debugPrint('${error}getFiveDaysDataError');

     update();
   } );

 }

  void getTopFiveCites() {
    currentWeatherList.clear();
    cities.forEach((element) {
      WeatherService(city:element).getTopFiveWeatherService(
          onSuccess:(value){
            currentWeatherList.add(value);
          } ,onError:(error){
        // debugPrint(error.toString());
        debugPrint('${error}getTopFiveCitesError');
        update();
      } );
    });
    print('${cities.length}cites lenght');
    print('${currentWeatherList.length}currentWeatherList');
    update();

  }

   bool ?serviceEnabled;
   bool ?isGpsOpened;
   Future<Position> _determinePosition() async {
     LocationPermission permission;
     // Test if location services are enabled.
     serviceEnabled = await Geolocator.isLocationServiceEnabled();
     // isGpsOpened=serviceEnabled;
     print(serviceEnabled.toString());
     if (!serviceEnabled!) {

     }
     permission = await Geolocator.checkPermission();
     if (permission == LocationPermission.denied) {
       permission = await Geolocator.requestPermission();
       if (permission == LocationPermission.denied) {
         // Permissions are denied, next time you could try
         // requesting permissions again (this is also where
         // Android's shouldShowRequestPermissionRationale
         // returned true. According to Android guidelines
         // your App should show an explanatory UI now.
         return Future.error('Location permissions are denied');
       }
       if (permission == LocationPermission.whileInUse) {
         serviceEnabled=true;
         // Permissions are denied, next time you could try
         // requesting permissions again (this is also where
         // Android's shouldShowRequestPermissionRationale
         // returned true. According to Android guidelines
         // your App should show an explanatory UI now.
         return Future.error('Location permissions are denied');
       }
     }

     if (permission == LocationPermission.deniedForever) {
       // Permissions are denied forever, handle appropriately.
       return Future.error(
           'Location permissions are permanently denied, we cannot request permissions.');
     }

     // When we reach here, permissions are granted and we can
     // continue accessing the position of the device.
     return await Geolocator.getCurrentPosition();
   }

   void openGpsSettings(){
     Geolocator.openLocationSettings().then((value) {
       getWeatherDataByLonAndLat();
       getFiveDaysData();
     });


   }









   // void getCurrentWeather() {
   //   debugPrint('getCurrentWeatherDate1');
   //   WeatherService(city:WeatherService().city).getCurrentWeatherService(
   //       onSuccess:(value){
   //         debugPrint('getCurrentWeatherDate 2'.toString());
   //         currentWeather=value;
   //         print(currentWeather.name);
   //       } ,onError:(error){
   //     print(error);
   //
   //     // debugPrint(error.toString());
   //     debugPrint('${error.toString()}getCurrentWeather  Error');
   //     update();
   //   } );
   //
   // }


   void getCurrentWeatherInSearch() {
     debugPrint('getCurrentWeatherInSearch');
     WeatherService(city:searchText).getSearchCityWeatherService(
         onSuccess:(value){
           debugPrint('getCurrentWeatherDate 2'.toString());
           currentWeather=value;
           print('${currentWeather.name!}this is search City');
           getFiveDaysDataInSearch();
           update();
         } ,onError:(error){
       debugPrint('${error.toString()}getCurrentWeather  Error');
       update();
     } );

   }

Position? position;

 Future<void>  getCurrentLocation()async{
  await  _determinePosition();
      position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
   print(position.toString());

     WeatherService().getCityNameService(lon: position!.longitude, lat: position!.latitude);

  }


void getWeatherDataByLonAndLat()async{
 await WeatherService().getWeatherFromLonAndLat(lon: position!.longitude, lat: position!.latitude,
      onSuccess: (value){
     currentWeather=value;
    // print('${currentWeather.id}this is id');
    update();

      },onError: (error){
   print(error.toString());
     });

}



Future<bool?> checkIfGpsIsOpened() async {
   isGpsOpened=await Geolocator.isLocationServiceEnabled();
   update();
    debugPrint('$isGpsOpened   checkIfGpsIsOpened()');
   return isGpsOpened;
}
//   Future<bool> checkLocationServiceEnable() {
//     isGpsOpened=Geolocator.isLocationServiceEnabled() ;
//     return Geolocator.getCurrentPosition();
//
// if(serviceEnabled==false){
//   print(serviceEnabled.toString());
// }
//
//
//   }

}