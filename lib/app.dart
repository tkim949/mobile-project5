import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
//import 'package:sentry/sentry.dart';
import 'screens/food_detail_s.dart';
import 'screens/food_entry_s.dart';
import 'screens/food_list_s.dart';



class App extends StatelessWidget{
  /*
  App({ Key key, this.sentry}) : super(key: key);
  final SentryClient sentry;

  static Future<void> reportError(dynamic error, dynamic stackTrace) async {
   /* if(Foundation.kDebugMode) {
          print(stackTrace);
          return;
       } */
    final SentryResponse response = await sentry.captureException( //error: instance members can't be accessed from a static method
      exception: error,
      stackTrace: stackTrace
    );
    if (response.isSuccessful) {
      print('Sentry ID: ${response.eventId}');
    } else {
      print('Failed to report to Sentry: ${response.error}');
    }

  } */

  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = 
          FirebaseAnalyticsObserver(analytics: analytics);
  
  static final routes = {
    FoodEntryS.routeName: (context) => FoodEntryS(),
    FoodListS.routeName: (context) => FoodListS(),
    FoodDetailS.routeName: (context) => FoodDetailS(),
    
  };

  Widget build(BuildContext context) {

    return MaterialApp(
      title: "Waste Food",
      theme: ThemeData.dark(),
      //navigatorObservers: <NavigatorObserver>[observer],
      routes: App.routes, 
      //home: FoodListS(analytics: analytics,observer: observer,),
      home: FoodListS(),
      //showSemanticsDebugger: true, /* This is to see the Sematics debug mode! */
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics)
      ],
      );
  }
}
