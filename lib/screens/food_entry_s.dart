import 'dart:io';
import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';
//import 'package:location/location.dart';
import '../widgets/food_entry_form.dart';


class FoodEntryS extends StatefulWidget {
  static const routeName = "enter_food";

  @override
  _FoodEntrySState createState() => _FoodEntrySState();
}

class _FoodEntrySState extends State<FoodEntryS> {
 File image;
  /*
  LocationData locationData;

  @override
  void initState() {
    super.initState();
    retrieveLocation();
  }

  void retrieveLocation() async {
    var locationService = Location();
    locationData = await locationService.getLocation();
    setState( () {} );
  }*/

  @override
  Widget build(BuildContext context) {
    image = ModalRoute.of(context).settings.arguments;
    /*
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text('New Waste Food')),

      body: Column(
          children: <Widget>[
            Image.file(image, height:200, width: 300, fit:BoxFit.fill),
            FoodEntryForm(image: image),
          ],),
    ); */
    return FoodEntryForm(image: image);
    
    
    //FoodEntryForm();
    
    /*return Scaffold(
         appBar: AppBar(
           title: Text("Food Entry Screen")),
        body: Center(
          //child: Text("Here for entering a new waster food"),) 
            child: getLoc()),
        ); */
          /*
          if (locationData == null) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Latitude: ${locationData.latitude}', style: Theme.of(context).textTheme.headline4),
                  Text('Longitude: ${locationData.longitude}', style: Theme.of(context).textTheme.headline4),
                  RaisedButton(
                    child: Text('share'),
                    onPressed: () {  
                    }
                  )
              ],
              ), 
            );
         }*/
    
  }
 /*
  Widget getLoc() {

        if (locationData == null) {
            return Center(child: CircularProgressIndicator());
        } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Latitude: ${locationData.latitude}', style: Theme.of(context).textTheme.headline4),
                  Text('Longitude: ${locationData.longitude}', style: Theme.of(context).textTheme.headline4),
                  RaisedButton(
                    child: Text('share'),
                    onPressed: () {  
                    }
                  )
              ],
              ), 
            );
         }
  }*/
}