import 'package:flutter/material.dart';
import 'screens/food_detail_s.dart';
import 'screens/food_entry_s.dart';
import 'screens/food_list_s.dart';
import 'screens/food_camera.dart';

class App extends StatelessWidget{

  //App({ Key key,}) : super(key: key);
  //final SharedPreferences preferences;
  
  static final routes = {
    FoodEntryS.routeName: (context) => FoodEntryS(),
    FoodListS.routeName: (context) => FoodListS(),
    FoodDetailS.routeName: (context) => FoodDetailS(),
    FoodCamera.routeName: (context) => FoodCamera(),
  };

  //@override
 // _AppState createState() => _AppState();
//}

//class _AppState extends State<App> {
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "Waste Food",
      theme: ThemeData.dark(),
      routes: App.routes, 
      home: FoodListS(),
      );
  }
}
