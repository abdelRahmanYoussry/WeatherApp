import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../../constant/images.dart';
import '../../controller/HomeController.dart';
import '../../widget/myList.dart';
import '../../widget/my_chart.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return GetBuilder<HomeController> (
      builder: (controller){
        return ConditionalBuilder(
          fallback: (context)=>const Center(child: CircularProgressIndicator(color: Colors.yellowAccent,)),
          condition: controller.currentWeather.name !=null,
          builder: (context)=>Scaffold(
            drawer: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(40),
                bottomRight: Radius.circular(20),
              ),
              child: SafeArea(
                top: true,
                // height: mediaQuery.height-50,
                child: Drawer(
                  backgroundColor: Colors.blue,
                  width: mediaQuery.width/1.5,
                  elevation: 0.1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 10),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.topRight,
                          child:  Padding(
                            padding: EdgeInsets.only(right: 15.0),
                            child: Icon(Icons.settings,color: Colors.white,),
                          ),
                        ),
                        SizedBox(
                          height: mediaQuery.height/20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 8,
                          padding: const EdgeInsets.only(
                              top: 10, left: 10, right: 10, bottom: 20),
                          child: TextField(
                            onChanged: (value) =>
                            controller.searchText = value,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            textInputAction: TextInputAction.search,
                            onSubmitted: (value) =>
                                controller.getCurrentWeatherInSearch(),
                            decoration: InputDecoration(
                              suffix: IconButton(
                                onPressed: () {
                                  controller.getCurrentWeatherInSearch();
                                },
                                icon: const Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                              ),
                              hintStyle:
                              const TextStyle(color: Colors.white),
                              hintText: 'Search',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                const BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                const BorderSide(color: Colors.white),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                const BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children:  [
                            const Icon(Icons.star,
                              color: Colors.white,),
                            const SizedBox(width: 10,),
                            Text(
                              'Favourite Location ',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'flutterfonts',
                              ),
                            ),
                            const SizedBox(width: 40,),
                            const Icon(Icons.report_gmailerrorred_sharp,
                              color: Colors.white,),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0,right: 20,top: 25),
                          child: Row(
                            children:  [
                              const Icon(Icons.location_on,
                                color: Colors.white,size: 14,),
                              const SizedBox(width: 3,),
                              Text(
                                '${controller.currentWeather.name}',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'flutterfonts',
                                ),
                              ),
                              const Spacer(),
                              const Icon(Icons.circle,
                                color: Colors.yellowAccent,size: 14,),
                              Text(
                                '${(controller.currentWeather.mainWeather!.temp! - 273.15).truncate().toString()}\u00B0',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                    color: Colors.white,
                                    // fontSize: 60,
                                    fontFamily: 'flutterfonts'),
                              ),

                            ],
                          ),
                        ),
                        //............
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            ' ............................................................. ',
                            maxLines: 1,
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'flutterfonts',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: mediaQuery.height/100,
                        ),
                        Row(
                          children:  [
                            const Icon(Icons.favorite,
                              color: Colors.white,),
                            const SizedBox(width: 20,),
                            Text(
                              'Top Cities :',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'flutterfonts',
                              ),
                            ),

                          ],
                        ),
                        SizedBox(
                          width: double.infinity/2,
                          height: MediaQuery.of(context).size.height / 2.5,
                          child: Card(
                              color: Colors.blueAccent.withOpacity(0.1),
                              elevation: 0.2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: MyList()),
                        ),


                      ],
                    ),
                  ),
                ),
              ),
            ),
            body: Builder(
              builder: (context)=>myHomeScreen(context),
            ),
          ),
         
        );
      },

    );

 

  }
  Widget myHomeScreen(context){
    var mediaQuery = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              // color: Colors.blue,
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.black12, BlendMode.colorDodge),
                image: AssetImage(
                  'assets/images/cloud-in-blue-sky.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: <Widget>[
                  AppBar(
                    centerTitle: true,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${controller.currentWeather.name}'
                              .toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'flutterfonts',
                          ),
                        ),
                        const Icon(Icons.location_on_sharp)
                      ],
                    ),
                    leading: IconButton(
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                  ),

                  if (controller.isGpsOpened == false)
                    InkWell(
                      child: Container(
                        width: mediaQuery.width / 2,
                        height: mediaQuery.height / 28,
                        decoration: BoxDecoration(
                            color:
                            Colors.transparent.withOpacity(0.2),
                            borderRadius:
                            BorderRadius.circular(20)),
                        child: Center(
                          child: Text(
                            'Turn on Location Services',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'flutterfonts',
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        controller.openGpsSettings();
                      },
                    ),
                  Text(
                    DateFormat()
                        .add_MMMMEEEEd()
                        .format(DateTime.now()),
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'flutterfonts',
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '${(controller.currentWeather.mainWeather!.temp! - 273.15).truncate().toString()}\u00B0',
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(
                            color: Colors.white,
                            // fontSize: 60,
                            fontFamily: 'flutterfonts'),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: mediaQuery.width / 4,
                            height: mediaQuery.height / 8,
                            child: controller.currentWeather
                                .weather![0].description ==
                                'clear sky'
                                ? LottieBuilder.asset(
                                fit: BoxFit.fill,
                                Images.clearSky)
                                : LottieBuilder.asset(
                                fit: BoxFit.fill,
                                Images.cloudy),
                          ),
                          Text(
                            '${controller.currentWeather.weather![0].description}',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                              color: Colors.white,
                              // fontSize: mediaQuery.width/25,
                              fontFamily: 'flutterfonts',
                            ),
                          ),
                          Text(
                            ' ${(controller.currentWeather.mainWeather!.temp_max! - 273.15).floor()}\u00B0 / ${(controller.currentWeather.mainWeather!.temp_min! - 273.15).round().toString()}\u00B0',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'flutterfonts',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  //Seven days
                  SizedBox(
                    width: double.infinity/2,
                    height: MediaQuery.of(context).size.height / 2.5,
                    child: Card(
                        color: Colors.blueAccent.withOpacity(0.1),
                        elevation: 0.2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: CustomScrollView(
                          slivers: [
                            SliverAppBar(
                              toolbarHeight: 30,
                              pinned: true,
                              automaticallyImplyLeading: false,
                              // backgroundColor:Colors.blueAccent.withOpacity(0.1) ,
                              expandedHeight: 100,
                              flexibleSpace: FlexibleSpaceBar(
                                background: Container(color: Colors.blueAccent.withOpacity(0.1),),
                                title: Text(
                                  'forcast next 7 days'
                                      .toUpperCase(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ), centerTitle: true,

                              ),
                            ),
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                    (BuildContext context, int index) {
                                  return  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        controller.fiveDaysData[index].dateTime!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontFamily: 'flutterfonts',
                                        ),
                                      ),
                                      const SizedBox(width: 30,),
                                      const Icon(Icons.water_drop,color: Colors.black,size: 18),
                                      Text(
                                        '${(controller.fiveDaysData[index].humidity!*0.05).round()}%',
                                        style:
                                        Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(width: 10,),
                                      const Icon(Icons.sunny,color: Colors.yellowAccent,),
                                      const SizedBox(width: 10,),
                                      const Icon(Icons.nightlight_round,color: Colors.yellow,),
                                      const SizedBox(width: 10,),
                                      Text(
                                        ' ${(controller.fiveDaysData[index].temp_max! - 273.15).floor()}\u00B0 / ${(controller.fiveDaysData[index].temp_min! - 273.15).round().toString()}\u00B0',
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight:
                                          FontWeight.bold,
                                          fontFamily:
                                          'flutterfonts',
                                        ),
                                      ),

                                    ],
                                  );
                                },
                                childCount: controller.fiveDaysData.length,
                              ),
                            ),
                          ],
                        )),
                  ),
                  //sunrise
                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 2.05,
                    child: Card(
                        color: Colors.blueAccent.withOpacity(0.1),
                        elevation: 0.2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:  <Widget>[
                                  Icon(Icons.water_drop,color: Colors.white,size: mediaQuery.width/8,),
                                  Icon(Icons.air,color: Colors.white,size: mediaQuery.width/8,),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Humidity: ${(controller.currentWeather.mainWeather!.humidity!*0.05).round()}%' ,
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'Wind: ${controller.currentWeather.wind!.speed} Km/h',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: LottieBuilder.asset(
                                Images.sunriseAndSunset,fit: BoxFit.cover,
                                height: mediaQuery.height/4,width: mediaQuery.width,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Sunrise ${DateTime.fromMillisecondsSinceEpoch(controller.currentWeather.sys!.sunrise!*1000).toString()
                                        .split(' ')[1].split('000')[0].split('.')[0].replaceRange(5, 8 ,' ')
                                    }',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'sunset ${DateTime.fromMillisecondsSinceEpoch(controller.currentWeather.sys!.sunset!*1000).toString()
                                        .split(' ')[1].split('000')[0].split('.')[0].replaceRange(5, 8 ,' ')}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),


                          ],)
                    ),
                  ),
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'forecast next 5 days'.toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          controller.getFiveDaysData();
                          controller.update();
                          // MyChart();
                        },
                        icon: (const Icon(
                          Icons.next_plan_outlined,
                          color: Colors.white,
                        )),
                      ),
                    ],
                  ),
                  MyChart(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'other cities:'.toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(
                        fontSize: 16,
                        fontFamily: 'flutterfonts',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  MyList(),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 8,
                    padding: const EdgeInsets.only(
                        top: 10, left: 20, right: 20, bottom: 20),
                    child: TextField(
                      onChanged: (value) =>
                      controller.searchText = value,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      textInputAction: TextInputAction.search,
                      onSubmitted: (value) =>
                          controller.getCurrentWeatherInSearch(),
                      decoration: InputDecoration(
                        suffix: IconButton(
                          onPressed: () {
                            controller.getCurrentWeatherInSearch();
                          },
                          icon: const Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        ),
                        hintStyle:
                        const TextStyle(color: Colors.white),
                        hintText: 'Search'.toUpperCase(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                          const BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                          const BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                          const BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
