import 'dart:io';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import '../widgets/food_entry_form.dart';


class FoodEntryS extends StatefulWidget {
  static const routeName = "enter_food";
  FoodEntryS({Key key, this.analytics, this.observer}) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  //final File image;

  @override
  _FoodEntrySState createState() => _FoodEntrySState(analytics, observer);
}

class _FoodEntrySState extends State<FoodEntryS> {
  _FoodEntrySState(this.analytics, this.observer);
  File image;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  //final File image;
  

  @override
  Widget build(BuildContext context) {
    image = ModalRoute.of(context).settings.arguments;
    
    return FoodEntryForm(image: image, analytics: analytics, observer: observer);
         
  }
 
}